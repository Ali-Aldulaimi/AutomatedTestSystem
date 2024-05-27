pipeline {
    agent none
    parameters {
        booleanParam(name: 'CHECKOUT', defaultValue: true, description: 'Perform chechkout?')
        string(name: 'WHAT_TO_CHECKOUT', defaultValue: 'refs/heads/Master_25x', description: 'What do you want to checkout? You can give e.g. a branch, commit-id, etc.')
        booleanParam(name: 'BUILD', defaultValue: true, description: 'Build sources?')
        booleanParam(name: 'PRE_TESTS', defaultValue: true, description: 'Execute pre-tests?')
        booleanParam(name: 'REINSTALL_AQTIVATE', defaultValue: true, description: 'Re-install AQtivate?')
        booleanParam(name: 'UPGRADE_DUT', defaultValue: true, description: 'Upgrade DUT?')
        booleanParam(name: 'CONFIGURE_DUT', defaultValue: true, description: 'Configure DUT?')
        booleanParam(name: 'EXEC_ROBOT_TESTS', defaultValue: true, description: 'Execute robot tests?')
    }
    options {
        disableConcurrentBuilds()
        buildDiscarder logRotator(  artifactDaysToKeepStr: '', 
                                    artifactNumToKeepStr: '10', 
                                    daysToKeepStr: '', 
                                    numToKeepStr: '10')
    }
    triggers {
      pollSCM 'H 0 * * *'
    }
    stages {
        stage("checkout (SWBuild)") {
            when {
                expression {
                    return false // This stage is disabled due low disk space in ARCDT023. To clone FW use AQT257 instead.  
                }
            }
            agent { label 'SWBuild' }
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: 'refs/heads/ci_test_25x']], 
                    extensions: [
                        [$class: 'CloneOption', 
                            noTags: false, 
                            reference: '', 
                            shallow: false, 
                            timeout: 120
                        ], 
                        [$class: 'RelativeTargetDirectory', 
                            relativeTargetDir: 'src_tests'
                        ]
                    ], 
                    userRemoteConfigs: [
                        [credentialsId: '91a34187-0aab-4c75-9c21-f9a4d30f0ffa', 
                        url: 'ssh://ci_test@arc-git.ensto.com/opt/git/aq_ci_test.git']
                    ]
                ])
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: "${params.WHAT_TO_CHECKOUT}"]],
                    extensions: [
                        [$class: 'CloneOption', 
                            noTags: false, 
                            reference: '', 
                            shallow: false, 
                            timeout: 120
                        ], 
                        [$class: 'RelativeTargetDirectory', 
                            relativeTargetDir: 'src_dut'
                        ]
                    ], 
                    userRemoteConfigs: [
                        [credentialsId: '91a34187-0aab-4c75-9c21-f9a4d30f0ffa', 
                        url: 'ssh://ci_test@arc-git.ensto.com/opt/git/aq_relay.git']
                    ]
                ])
                checkout poll: false, scm:([
                    $class: 'GitSCM', 
                    branches: [[name: 'refs/heads/master']], 
                    extensions: [
                        [$class: 'CloneOption', 
                            noTags: false, 
                            reference: '', 
                            shallow: false, 
                            timeout: 120
                        ], 
                        [$class: 'RelativeTargetDirectory', 
                            relativeTargetDir: 'src_settingtools'
                        ]
                    ], 
                    userRemoteConfigs: [
                        [credentialsId: '91a34187-0aab-4c75-9c21-f9a4d30f0ffa', 
                        url: 'ssh://ci_test@arc-git.ensto.com/opt/git/aq_settingtool.git']
                    ]
                ])
            }
        }
        stage("checkout (CITest)") {
            when {
                expression {
                    return params.CHECKOUT == true
                }
            }
            agent { label 'CITest' }
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: 'refs/heads/ci_test_25x__Ali']], 
                    extensions: [
                        [$class: 'CloneOption', 
                            noTags: false, 
                            reference: '', 
                            shallow: false, 
                            timeout: 120
                        ], 
                        [$class: 'RelativeTargetDirectory', 
                            relativeTargetDir: 'src_tests'
                        ]
                    ], 
                    userRemoteConfigs: [
                        [credentialsId: '91a34187-0aab-4c75-9c21-f9a4d30f0ffa', 
                        url: 'ssh://ci_test@arc-git.ensto.com/opt/git/aq_ci_test.git']
                    ]
                ])
            }
        }
         stage("build & pack FW") {
            when {
                expression {
                    return false // This stage is disabled due low disk space in ARCDT023. To build FW use AQT257 instead. 
                }
            }
            agent { label 'SWBuild' }
            steps {
                dir("src_tests") {
                    bat '''generate_path_files.bat'''
                    bat '''copy create_latest_fw_package.bat ..\\src_dut'''
                }
                dir("src_dut") {
                    bat '''cs-make.exe clean'''
                    retry(count: 3) {
                        bat '''cs-make.exe''' // Sometimes build fails due to some Cygwin memory errors, therefore we retry automatically
                    }
                    bat '''pack_fw_and_xml.bat'''
                    bat '''create_latest_fw_package.bat'''
                }
            }
        }
        stage("pre-tests") {
            when {
                expression {
                    return params.PRE_TESTS == true
                }
            }
            agent { label 'CITest' }
            steps {
                catchError() {
                    dir("src_tests/robot") {
                        bat '''robot -d reports -o pre_tests-AQS254.xml -r NONE -l NONE pre_tests-AQS254.robot'''
                    }
                }
                dir("src_tests/robot/reports") {
                    bat '''rebot -o combined.xml pre_tests-AQS254.xml'''
                }
            }
        }
        stage("re-install AQtivate") {
            when {
                expression {
                    return params.REINSTALL_AQTIVATE == true
                }
            }
            agent { label 'CITest' }
            steps {
                catchError() {
                    dir("src_tests/robot") {
                        bat '''robot -d reports -o reinstall_aqtivate.xml -r NONE -l NONE reinstall_aqtivate.robot'''
                    }
                }
                script {
                    if (fileExists('src_tests/robot/reports/combined.xml')) {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml combined.xml reinstall_aqtivate.xml'''
                        }
                    }
                    else {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml reinstall_aqtivate.xml'''
                        }
                    }
                }
            }
        }
        stage("upgrade DUT FW") {
            when {
                expression {
                    return params.UPGRADE_DUT == true
                }
            }
            agent { label 'CITest' }
            steps {
                catchError() {
                    dir("src_tests/robot") {
                        bat '''robot -d reports -o upgrade_dut.xml -r NONE -l NONE -v FW_ZIP_PATH://ARCDT023/artifacts upgrade_dut.robot'''
                    }
                }
                script {
                    if (fileExists('src_tests/robot/reports/combined.xml')) {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml combined.xml upgrade_dut.xml'''
                        }
                    }
                    else {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml upgrade_dut.xml'''
                        }
                    }
                }
            }
        }
        stage("configure DUT") {
            when {
                expression {
                    return params.CONFIGURE_DUT == true
                }
            }
            agent { label 'CITest' }
            steps {
                catchError() {
                    dir("src_tests/robot") {
                        bat '''robot -d reports -o configure_dut_AQS254.xml -r NONE -l NONE configure_dut_AQS254.robot'''
                    }
                }
                script {
                    if (fileExists('src_tests/robot/reports/combined.xml')) {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml combined.xml configure_dut_AQS254.xml'''
                        }
                    }
                    else {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml configure_dut_AQS254.xml'''
                        }
                    }
                }
            }
        }
        stage("robot tests") {
            when {
                expression {
                    return params.EXEC_ROBOT_TESTS == true
                }
            }
            agent { label 'CITest' }
            steps {
                catchError() {
                    dir("src_tests/robot") {
                        bat '''robot -d reports -o smoke_tests-AQS254.xml -r NONE -l NONE smoke_tests-AQS254.robot'''
                    }
                }
                script {
                    if (fileExists('src_tests/robot/reports/combined.xml')) {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml combined.xml smoke_tests-AQS254.xml'''
                        }
                    }
                    else {
                        dir("src_tests/robot/reports") {
                            bat '''rebot -o combined.xml smoke_tests-AQS254.xml'''
                        }
                    }
                }
            }
        }
    }
    post {
        success {
            node('SWBuild') {
            dir("src_dut") {
                bat '''del *AQS_ONLY.zip'''
                bat '''xcopy /y v*.zip c:\\artifacts\\relay_fw'''
                }
            }
        }
        always {
            node('CITest') {
            script {
                if (fileExists('src_tests/robot/reports/combined.xml')) {
                    step([
                        $class : 'RobotPublisher',
                        outputPath : 'src_tests/robot/reports',
                        outputFileName : "combined.xml",
                        disableArchiveOutput : false,
                        passThreshold : 100,
                        unstableThreshold: 95.0,
                        otherFiles : "*.png",
                    ])
                }
                dir("src_tests/robot/reports") {
                    bat '''del *.xml *.html'''
                }
                }
            }
            node('SWBuild') {
                dir("src_dut") {
                    bat '''..\\src_tests\\set_build_label.bat ${BUILD_NUMBER}'''
                    buildName readFile(file: 'version.txt')
                    bat '''del version.txt'''
                }
            }
        }
    }
}

*** Settings ***
Library     LabjackLibrary.py
Library     u3.py
Library           Process
Resource   FuncsList.robot
*** Keywords ***
#Functions list
Power On/Off DUT 
    [Arguments]    ${DUT}
    Open Labjack    1
        IF  ${DUT} == 254
            DeActivaite Relay    1
            DeActivaite Relay    2
            DeActivaite Relay    4 
            ${result_0} =    LabjackLibrary.Get DIO State    0
                IF  ${result_0}==1
                    Activaite Relay    0
                    Sleep     70
                END
        END
        IF  ${DUT} == 255
            DeActivaite Relay    0
            DeActivaite Relay    2
            DeActivaite Relay    1
            ${result_0} =    LabjackLibrary.Get DIO State    4
                IF  ${result_0}==1
                    Activaite Relay    4
                    Sleep     70
                END
        END
        IF  ${DUT} == 256
            DeActivaite Relay    0
            DeActivaite Relay    2
            DeActivaite Relay    4
            ${result_0} =    LabjackLibrary.Get DIO State    1
                IF  ${result_0}==1
                    Activaite Relay    1
                    Sleep     70
                END
        END
        IF  ${DUT} == 257
            DeActivaite Relay    0
            DeActivaite Relay    1
            DeActivaite Relay    4
            ${result_0} =    LabjackLibrary.Get DIO State    2
                IF  ${result_0}==1
                     Activaite Relay    2
                    Sleep     70
                END
        END   
    Close Labjack

Check Other DUTs Are Off
    Open Labjack    1
    ${result_0} =    LabjackLibrary.Get DIO State    0
    Run Keyword If    ${result_0} == 0
          ...           LabjackLibrary.DeActivaiteRelay    0

    ${result_1} =    LabjackLibrary.Get DIO State    1
    Run Keyword If    ${result_1} == 0
        ...    LabjackLibrary.DeActivaiteRelay    1

    ${result_4} =    LabjackLibrary.Get DIO State    4
    Run Keyword If    ${result_4} == 0
        ...    LabjackLibrary.DeActivaiteRelay    4
    Close Labjack

Check All DIs Are Not Active
    Open Labjack    1
    ${result1} =    LabjackLibrary.Get DIO State    8
    Log    ${result1}
    Should Be Equal As Integers    ${result1}    1
    ${result2} =    LabjackLibrary.Get DIO State    9
    Log    ${result2}
    Should Be Equal As Integers    ${result2}    1
    ${result3} =    LabjackLibrary.Get DIO State    10
    Log    ${result3}
    Should Be Equal As Integers    ${result3}    1
    Close Labjack

Check Input State for Labjack
    [Arguments]    ${labjackNumber}    ${inputPin}    ${expectedValue}
    Open Labjack    ${labjackNumber}
    ${result} =    LabjackLibrary.Read Input State    ${inputPin}
    Log    ${result}
    Should Be Equal As Integers    ${result}    ${expectedValue}
    Close Labjack

Apply 24V on DIs
    Open Labjack    1
    Activaite Relay    8
    Activaite Relay    9
    Activaite Relay    10
    Close Labjack

Remove 24V from DIs
    Open Labjack    1
    DeActivaite Relay    8
    DeActivaite Relay    9
    DeActivaite Relay    10
    Close Labjack

Initialize & check Low Voltage
    [Documentation]    Initializes to low voltage by deactivating a relay and checking DIO state
    Open Labjack    1
    LabjackLibrary.DeActivaite Relay    11
    ${result} =    LabjackLibrary.Get DIO State    11
    Should Be Equal As Integers    ${result}    1
    Close Labjack

Initialize & Check Low Current
    [Documentation]    This keyword initializes the Labjack and checks the low current condition.
    Open Labjack    1
    LabjackLibrary.DeActivaite Relay    12
    ${result} =    LabjackLibrary.Get DIO State    12
    Should Be Equal As Integers    ${result}    1
    Close Labjack

Switch & Check Injection to High Voltage
    Open Labjack    1
    Activaite Relay    11
    ${result} =    LabjackLibrary.Get DIO State    11
    Log   ${result}
    Should Contain    ${result}    0
    Close Labjack

Switch Injection to Low Voltage
    Open Labjack    1
    DeActivaite Relay    11
    ${result} =    LabjackLibrary.Get DIO State    11
    Log   ${result}
    Should Contain    ${result}    1

Switch Injection to High Current
    Open Labjack    1
    Activaite Relay    12
    ${result} =    LabjackLibrary.Get DIO State    12
    Log   ${result}
    Should Contain    ${result}    0
    Sleep    1s

Switch Injection to Low Current
    Open Labjack    1
    DeActivaite Relay    12
    ${result} =    LabjackLibrary.Get DIO State    12
    Log   ${result}
    Should Contain    ${result}    1

set T1 to "NC"
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  1  192.168.100.53  timeout=10s
        Log   ${result.stderr}
        Should Contain	 ${result.stderr}	RELE_T1_POL set to 1

Check T1 polarity is "NO"
    Check Input State for Labjack    1    16    0

Set T1 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL set to 0 

Check DOC state is ON 
     FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DOC1_CONDITION  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	DOC1_CONDITION value 2
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END   

Enable Stage
    [Arguments]    ${ParameterName}    ${Mode}
    ${result} =    Run Process    //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  ${ParameterName}    ${Mode}  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain    ${result.stderr}    ${ParameterName} set to    ${Mode}
    sleep    1s

Check State is None
    Sleep  1s  Give some time for the stage to acoomodate new settings
    [Arguments]    ${ParameterName}
    ${result} =    Run Process    //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  ${ParameterName}  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain    ${result.stderr}    ${ParameterName} value 0

Check State is ON
    Sleep  3s  Give some time for the stage to acoomodate new settings 
    [Arguments]    ${ParameterName}   ${Value} 
    ${result} =    Run Process    //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  ${ParameterName}  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain    ${result.stderr}    ${ParameterName} value ${Value}
Set pick up value 
    [Arguments]    ${ParameterName}    ${PickUpValue} 
    ${result} =    Run Process    //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  ${ParameterName}  ${PickUpValue}  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain    ${result.stderr}    ${ParameterName} set to ${PickUpValue}
    Sleep  1s  Give some time for the stage to accommodate new settings

Disable Stage
    [Arguments]    ${ParameterName}
    ${result} =    Run Process    //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  ${ParameterName}  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain    ${result.stderr}    ${ParameterName} set to 0

Power Off DUT
        Sleep    5
        Open Labjack    1  
        DeActivaite Relay    2   
        Close Labjack

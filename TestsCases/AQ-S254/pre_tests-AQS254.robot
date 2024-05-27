*** Settings ***
Library           Process
Library    LabjackLibrary.py
Library    u3.py
Resource   Keywords.robot
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Power On DUT and Check Other Devices
    Power On/Off DUT    254        #pass only the numerical part of DUT name ex:AQ-T254 = 254
   
Ping to DUT to Check network staibility 
    ${ping_result} =    Run Process    ping    192.168.100.53
    Log    ${ping_result.stdout}
    Should Contain    ${ping_result.stdout}    Reply from 192.168.100.53
    sleep    3s     
Pre01: IRF not active
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  IRF_IRFACTIVE  192.168.100.53  -0.1  0.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre02: No false trips
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DR_DRCNTR  192.168.100.53  -0.1  0.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre03: PCPU Load around 5% (+/-5%)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  SYS_LOAD  192.168.100.53  2  6  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre04: DBG_PROF_TOTAL around 1100 (+/-100)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_TOTAL  192.168.100.53  100  200  timeout=10s
        Log  ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain  ${result.stderr}  Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END
Pre05: DBG_PROF_FMT_PREPARATION around 55 (+/-5)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_PREPARATION  192.168.100.53  -1  10  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END
Pre06: DBG_PROF_FMT_FFT around 90 (+/-5)  
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_FFT  192.168.100.53  -1  10  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END
Pre07: DBG_PROF_FMT_MAG_ANGLE around 145 (+/-10)  
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_MAG_ANGLE  192.168.100.53  -1  10  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END
Pre08: DBG_PROF_FMT_FREQ_ORTO around 65 (+/-10)    
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_FREQ_ORTO  192.168.100.53  -1  10  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END
Pre09: DBG_PROF_LOGIC_EXECUTE around 5 (+/-2)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_LOGIC_EXECUTE  192.168.100.53  1  7  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre10: DBG_PROF_MATLAB_MEAS around 400 (+/-30)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_MATLAB_MEAS  192.168.100.53  30  50  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre11: DBG_PROF_MATLAB_STEP around 350 (+/-100)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_MATLAB_STEP  192.168.100.53  70  90  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre12.1: All DIs are "Not active" in the beginning
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 0
pre12.2: All DIs are "Not active" in the beginning (LabJack)
     Check All DIs Are Not Active

Pre13.1: set T1 to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL set to 1

Pre13.2: T1 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T1_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL value 1
    Check Input State for Labjack    1    16    0        #LJnum    InputPin    expectedValue
Pre14.1: Set T2 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T2_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL set to 1

Pre14.2: T2 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T2_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL value 1
    Check Input State for Labjack    1    17    0        #LJnum    InputPin    expectedValue
    

Pre15.1 Set T3 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T3_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL set to 1

Pre15.2 T3 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T3_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL value 1
    Check Input State for Labjack    1    18    0        #LJnum    InputPin    expectedValue
    
Pre16.1 Set T4 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T4_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL set to 1
    

Pre16.2 T4 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T4_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL value 1
    Check Input State for Labjack    1    19    0        #LJnum    InputPin    expectedValue
         
Pre17.1 Set T5 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T5_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL set to 1

Pre17.2 T5 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T5_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL value 1
    Check Input State for Labjack    2    16    0        #LJnum    InputPin    expectedValue
     
Pre18.1 system fault or is powered OFF. (SF-pin 16-17)
    Check Input State for Labjack    2    18    1        #LJnum    InputPin    expectedValue
                                                         #Pins 16 and 17 are closed when the unit has a system fault or is powered OFF
       

Pre18.2 the unit is powered ON and there is no system fault. (SF-pin 16-18 \ SF "NO")
     Check Input State for Labjack    3    17    0        #LJnum    InputPin    expectedValue
                                                          # Pins 16 and 18 are closed when the unit is powered ON and there is no system fault
      
Pre19: Apply 24V on DIs (Activaite DO.2.1-DO.2.3 )
	Apply 24V on DIs

Pre20.1: DIs ??&?? are "Active"
    Sleep  3s  Give some time for the DIs to settle
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 7

Pre20.2: Remove 24V from DIs (DEActivaite DO.2.1-DO.2.3 )
	
        Remove 24V from DIs

Pre21: Set T1 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL set to 0

Pre22.1: T1 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T1_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL value 0

Pre22.2: T1 polarity is "NO"(LabJack)
    Check Input State for Labjack    1    16    1        #LJnum    InputPin    expectedValue
    
Pre23: Set T2 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T2_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL set to 0

Pre24.1: T2 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T2_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL value 0
 
Pre24.2: T2 polarity is "NO"
     Check Input State for Labjack    1    17    1        #LJnum    InputPin    expectedValue
    
Pre25: Set T3 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T3_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL set to 0

Pre26.1: T3 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T3_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL value 0

Pre26.2: T3 polarity is "NO"(LabJack)
    Check Input State for Labjack    1    18    1        #LJnum    InputPin    expectedValue
    
Pre27: Set T4 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T4_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL set to 0

Pre28.1: T4 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T4_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL value 0

Pre28.2: T4 polarity is "NO"
    Check Input State for Labjack    1    19    1        #LJnum    InputPin    expectedValue 
    

Pre29: Set T5 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T5_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL set to 0

Pre30.1: T5 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T5_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL value 0

Pre30.2: T5 polarity is "NO"
     Check Input State for Labjack    2    16    1        #LJnum    InputPin    expectedValue
     
Pre31.1: All DIs are "Not active" at the end
    Sleep  3s  Give some time for the DIs to settle
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 0

pre31.2: All DIs are "Not active" at the end
    Check All DIs Are Not Active
    
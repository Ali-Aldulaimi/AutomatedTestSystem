*** Settings ***
Library           Process
Library    LabjackLibrary.py
Library    u3.py
Resource   Keywords.robot
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Power On DUT and Check Other Devices
  Power On/Off DUT    257        #pass only the numerical part of DUT name ex:AQ-T254 = 254

Ping to DUT to Check network staibility 
    ${ping_result} =    Run Process    ping    192.168.100.53
    Log    ${ping_result.stdout}
    Should Contain    ${ping_result.stdout}    Reply from 192.168.100.53   
    sleep    3s   
Pre01: CT1 measures around 100A pri. (+/-20A)
    ${result} =	Run Process	 //ARCDT023/artifacts/AQconsole(exe)/AQconsole.exe  dbr  MEAS1_IL1PRI  192.168.100.53  80  120  timeout=15s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre02: CT2 measures around 100A pri. (+/-20A)
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  MEAS1_IL2PRI  192.168.100.53  80  120  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre03.1: VT1 measures around 62V sec. (+/-5V)
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  MEAS3_U1SEC  192.168.100.53  57  67  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK
Pre03.2: VT2 measures around 62V sec. (+/-5V)
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  MEAS3_U2SEC  192.168.100.53  57  67  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK


Pre04: IRF not active
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  IRF_IRFACTIVE  192.168.100.53  -0.1  0.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre05: No false trips
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DR_DRCNTR  192.168.100.53  -0.1  0.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK

Pre06: PCPU Load around 25% (+/-5%)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  SYS_LOAD  192.168.100.53  20  30  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre07: DBG_PROF_TOTAL around 1100 (+/-100)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_TOTAL  192.168.100.53  1000  1200  timeout=10s
        Log  ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain  ${result.stderr}  Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre08: DBG_PROF_FMT_PREPARATION around 55 (+/-5)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_PREPARATION  192.168.100.53  50  60  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre09: DBG_PROF_FMT_FFT around 90 (+/-5)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_FFT  192.168.100.53  85  95  timeout=10s
        Log   ${result.stderr}
        ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre10: DBG_PROF_FMT_MAG_ANGLE around 145 (+/-10)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_MAG_ANGLE  192.168.100.53  135  155  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre11: DBG_PROF_FMT_FREQ_ORTO around 65 (+/-10)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_FMT_FREQ_ORTO  192.168.100.53  55  75  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre12: DBG_PROF_LOGIC_EXECUTE around 5 (+/-2)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_LOGIC_EXECUTE  192.168.100.53  2  7  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre13: DBG_PROF_MATLAB_MEAS around 400 (+/-30)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_MATLAB_MEAS  192.168.100.53  370  430  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre14: DBG_PROF_MATLAB_STEP around 350 (+/-100)
    FOR  ${index}  IN RANGE  1  10
        ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DBG_PROF_MATLAB_STEP  192.168.100.53  250  450  timeout=10s
        Log   ${result.stderr}
         ${bStatus} =  Run Keyword And Return Status  Should Contain	 ${result.stderr}	Compare:OK
        Exit For Loop If  ${bStatus} == ${True}
    END
    IF  ${bStatus} == ${False}
        Fail  ${result.stderr}
    END

Pre15.1: All DIs are "Not active" in the beginning
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 0
pre15.2: All DIs are "Not active" in the beginning (LabJack)
     Check All DIs Are Not Active

Pre16.1: set T1 to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL set to 1

Pre16.2: T1 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T1_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL value 1
    Check Input State for Labjack    1    16    0        #LJnum    InputPin    expectedValue
Pre17.1: Set T2 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T2_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL set to 1

Pre17.2: T2 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T2_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL value 1
    Check Input State for Labjack    1    17    0        #LJnum    InputPin    expectedValue
    

Pre18.1 Set T3 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T3_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL set to 1

Pre18.2 T3 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T3_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL value 1
    Check Input State for Labjack    1    18    0        #LJnum    InputPin    expectedValue
    
Pre19.1 Set T4 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T4_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL set to 1
    

Pre19.2 T4 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T4_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL value 1
    Check Input State for Labjack    1    19    0        #LJnum    InputPin    expectedValue
         
Pre20.1 Set T5 polarity to "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T5_POL  1  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL set to 1

Pre20.2 T5 polarity is "NC"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T5_POL  192.168.100.53  0.9  1.1  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL value 1
    Check Input State for Labjack    2    16    0        #LJnum    InputPin    expectedValue
     
Pre21.1 system fault or is powered OFF. (SF-pin 16-17)
    Check Input State for Labjack    3    16    1        #LJnum    InputPin    expectedValue
                                                         #Pins 16 and 17 are closed when the unit has a system fault or is powered OFF
       

Pre21.2 the unit is powered ON and there is no system fault. (SF-pin 16-18 "NO")
     Check Input State for Labjack    3    17    0        #LJnum    InputPin    expectedValue
                                                          # Pins 16 and 18 are closed when the unit is powered ON and there is no system fault
      
Pre22: Apply 24V on DIs (Activaite DO.2.1-DO.2.3 )
	Apply 24V on DIs

Pre23.1: DIs ??&?? are "Active"
    Sleep  3s  Give some time for the DIs to settle
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 7

Pre23.2: Remove 24V from DIs (DEActivaite DO.2.1-DO.2.3 )
	
        Remove 24V from DIs

Pre24: Set T1 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T1_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL set to 0

Pre25.1: T1 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T1_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T1_POL value 0

Pre25.2: T1 polarity is "NO"(LabJack)
    Check Input State for Labjack    1    16    1        #LJnum    InputPin    expectedValue
    
Pre26: Set T2 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T2_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL set to 0

Pre27.1: T2 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T2_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T2_POL value 0
 
Pre27.2: T2 polarity is "NO"
     Check Input State for Labjack    1    17    1        #LJnum    InputPin    expectedValue
    
Pre28: Set T3 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T3_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL set to 0

Pre29.1: T3 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T3_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T3_POL value 0

Pre29.2: T3 polarity is "NO"(LabJack)
    Check Input State for Labjack    1    18    1        #LJnum    InputPin    expectedValue
    
Pre30: Set T4 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T4_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL set to 0

Pre31.1: T4 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T4_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T4_POL value 0

Pre31.2: T4 polarity is "NO"
    Check Input State for Labjack    1    19    1        #LJnum    InputPin    expectedValue 
    

Pre32: Set T5 polarity to "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbw  RELE_T5_POL  0  192.168.100.53  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL set to 0

Pre33.1: T5 polarity is "NO"
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  RELE_T5_POL  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	RELE_T5_POL value 0

Pre33.2: T5 polarity is "NO"
     Check Input State for Labjack    2    16    1        #LJnum    InputPin    expectedValue
     
Pre34.1: All DIs are "Not active" at the end
    Sleep  3s  Give some time for the DIs to settle
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  DIGI_DI1_32  192.168.100.53  0  0  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	DIGI_DI1_32 value 0

pre34.2: All DIs are "Not active" at the end
    Check All DIs Are Not Active
    
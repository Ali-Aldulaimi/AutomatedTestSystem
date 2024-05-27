*** Settings ***
Library           Process
Library    LabjackLibrary.py
Resource   Keywords.robot
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Prot01: Initialize to low current
    Initialize & Check Low Current
    ${result} =	Run Process	 //ARCDT023/artifacts/AQconsole(exe)/AQconsole.exe  dbr  MEAS1_IL1PRI  192.168.100.53  80  120  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK
   
Prot02: Non-directional overcurrent protection (I>; 50/51)
    Config & Test NOC1
Prot03: Non-directional earth fault protection (I0>; 50N/51N)
    Config & Test NEF1 
prot04: Directional earth fault protection (I0dir>; 67N/32N)
    Config & Test DEF1 
Prot05: Circuit breaker failure protection (CBFP; 50BF/52BF)
    Config & Test CBFP

prot06:Overfrequency and underfrequency protection (f>/<; 81O/81U)
    Config & Test FRQV1(Overfrequency)
    Config & Test FRQV1(Underrequency)
protA: disable injection device    
    Switch Injection to Low Current 
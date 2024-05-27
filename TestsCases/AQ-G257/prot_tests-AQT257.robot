*** Settings ***
Library           Process
Library    LabjackLibrary.py
Resource   Keywords.robot
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Prot01: Initialize to low voltage
    Initialize & check Low Voltage
    ${result} =	Run Process	 //ARCDT023/artifacts//AQconsole(exe)/AQconsole.exe  dbr  MEAS3_U1SEC  192.168.100.53  57  67  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK
Prot02.1: Initialize to low current
    Initialize & Check Low Current
    ${result} =	Run Process	 //ARCDT023/artifacts/AQconsole(exe)/AQconsole.exe  dbr  MEAS1_IL1PRI  192.168.100.53  80  120  timeout=10s
    Log   ${result.stderr}
    Should Contain	 ${result.stderr}	Compare:OK
   

Prot03: Overvoltage protection (U>; 59)
    Config & Test OV1

Prot04: Non-directional overcurrent protection (I>; 50/51)
    Config & Test NOC1
Prot05: Non-directional earth fault protection (I0>; 50N/51N)
    Config & Test NEF1 
Prot06: Directional overcurrent protection (Idir>; 67)
    Config & Test DOC 
prot07: Directional earth fault protection (I0dir>; 67N/32N)
    Config & Test DEF1 
Prot08: Circuit breaker failure protection (CBFP; 50BF/52BF)
    Config & Test CBFP

Prot09: Undervoltage protection (U<; 27)
    Config & Test UV1

prot10: Neutral overvoltage protection (U0>; 59N)
    Config & Test NOV1
prot11:Sequence voltage protection (U1/U2>/<; 47/27P/59PN)
    Config & Test VUB1(Pos Seq)
    Config & Test VUB1(Neg Seq) 
prot11:Overfrequency and underfrequency protection (f>/<; 81O/81U)
    Config & Test FRQV1(Overfrequency)
    Config & Test FRQV1(Underrequency)

Prot12:Rate-of-change of frequency (df/dt>/<; 81R)            #To apply frequency difference, we need another injection device such as Frequency convertor.
    Config & Test DFT1


protA: disable injection device    
    Switch Injection to Low Current 

protB: disable injection device    
    Switch Injection to Low Voltage 
*** Settings ***
Library     LabjackLibrary.py
Library     u3.py
Library           Process
Resource   FuncsList.robot
*** Keywords ***
#Protection Functions tests 
Config & Test OV1
    Enable Stage   OV1_MODE    1
    Set pick up value    OV1_PICK_UP_PU_1    100
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    OV1_CONDITION
    Switch & Check Injection to High Voltage
    Check State is ON     OV1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch Injection to Low Voltage
    Check State is None    OV1_CONDITION
    Disable Stage    OV1_MODE

Config & Test NOC1
    Enable Stage   NOC1_MODE    1
    Set pick up value    NOC1_PICK_UP_PU_1    0.6
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    NOC1_CONDITION
    Switch Injection to High Current
    Check State is ON     NOC1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch injection to low current
    Check State is None    NOC1_CONDITION
    Disable Stage    NOC1_MODE

Config & Test NEF1    #This protection uses I01 and I02 which are not being implemnted yet.
    Enable Stage    NEF1_MODE    1
    Check State is None    NEF1_CONDITION
    Switch Injection to High Current
    Set pick up value    NEF1_PICK_UP_PU_1    0.4
    #Check State is ON     NEF1_CONDITION     
    Switch Injection to Low Current
    Disable Stage    NEF1_MODE

Config & Test DOC
    Enable Stage    DOC1_MODE    1
    Set pick up value    DOC1_PICK_UP_PU_1    0.4
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    DOC1_CONDITION
    Switch Injection to High Current
    Check DOC state is ON                         #Read state 10 times to check all the direction of the current
    Switch injection to low current
    Check State is None    DOC1_CONDITION
    Disable Stage    DOC1_MODE

Config & Test DEF1                                #This protection uses I01 and I02 which are not being implemnted yet.
    Enable Stage   DEF1_MODE    1
    Set pick up value    DEF1_PICK_UP_PU_1    0.4
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    DEF1_CONDITION
    Switch Injection to High Current
    #Check State is ON     DEF1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch injection to low current
    Check State is None    DEF1_CONDITION
    Disable Stage    DEF1_MODE
     
    
Config & Test CBFP
    Set T1 to "NC"
    Enable Stage    CBF1_MODE    1
    Set pick up value    CBF1_PICK_UP_PH_1    0.4
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    CBF1_CONDITION
    Switch Injection to High Current
    Check State is ON     CBF1_CONDITION    3
    Check T1 polarity is "NO"
    Switch injection to low current
    Set T1 polarity to "NO"
    Disable Stage    CBF1_MODE

    

Config & Test UV1
    Enable Stage   UV1_MODE    1
    Set pick up value    UV1_PICK_UP_PU_1   80
    Enable Stage    SYS_PRESET    1           #reset protection function
    Switch & Check Injection to High Voltage
    Check State is None    UV1_CONDITION
    Switch Injection to Low Voltage
    Check State is ON     UV1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Disable Stage    UV1_MODE


Config & Test NOV1
    Enable stage  M1VT1_VTMODE4    1
    Enable Stage   NOV1_MODE    1
    Set pick up value    NOV1_PICK_UP_PU_1    99
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is None    NOV1_CONDITION
    Switch & Check Injection to High Voltage
    Check State is ON     NOV1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch Injection to Low Voltage
    Check State is None    NOV1_CONDITION
    Disable Stage    NOV1_MODE
    Disable Stage  M1VT1_VTMODE4

Config & Test VUB1(Pos Seq)
    Enable Stage   M1VT1_VTMODE13    2       #Enable 2LL+U3+U4 mode (0=3LN+U4;1=3LL+U4;2=2LL+U3+U4;3=3LN (LEA req. HW))
    Enable Stage   M1VT1_VTMODE3    1        #Enable U3 mode U0 (0=NotUsed;1=U0;2=SS
    Enable Stage   VUB1_MODE    1            
    Set pick up value    VUB1_PICK_UP_PU_1    60
    Check State is None    VUB1_CONDITION
    Enable Stage    SYS_PRESET    1           #reset protection function
    Switch & Check Injection to High Voltage
    Check State is ON     VUB1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch Injection to Low Voltage
    Check State is None    VUB1_CONDITION
    Disable Stage    VUB1_MODE
    Enable Stage   M1VT1_VTMODE13   1   
    Disable Stage   M1VT1_VTMODE3

Config & Test VUB1(Neg Seq)
    Enable Stage   M1VT1_VTMODE13    2       #Enable 2LL+U3+U4 mode (0=3LN+U4;1=3LL+U4;2=2LL+U3+U4;3=3LN (LEA req. HW))
    Enable Stage   M1VT1_VTMODE3    1        #Enable U3 mode U0 (0=NotUsed;1=U0;2=SS
    Enable Stage   VUB1_MODE    1            
    Set pick up value    VUB1_PICK_UP_PU_1    60
    Check State is None    VUB1_CONDITION
    Enable Stage   VUB1_MEASMAG    1
    Enable Stage    SYS_PRESET    1           #reset protection function
    Switch & Check Injection to High Voltage
    Check State is ON     VUB1_CONDITION    2    #0=Normal;1=Start;2=Trip;3=Blocked
    Switch Injection to Low Voltage
    Check State is None    VUB1_CONDITION
    Disable Stage    VUB1_MODE
    Enable Stage   M1VT1_VTMODE13   1   
    Disable Stage   M1VT1_VTMODE3    

Config & Test FRQV1(Overfrequency)
    Enable Stage   FRQV1_MODE    1           
    Enable Stage   FRQV1_FUNCENA_LO1    1   #f<enable
    Enable Stage   FRQV1_MEASENA_LO1_1   1   #Enable f< used in setting group
    Set pick up value    FRQV1_FPICK_LO1_1    49    #set pick up value to 49Hz 
    Check State is None    FRQV1_L1CONDITION    #Due limitation of sputnik, frequency pick up value will be change to test the function.
    Set pick up value   FRQV1_FPICK_LO1_1   51    #set pick up value to >=51Hz 
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is ON     FRQV1_L1CONDITION    2    #Check f<condition = 2 (0=Normal;1=Start;2=Trip;3=Blocked)
    Disable Stage   FRQV1_MEASENA_LO1_1       #Disable f< used in setting group
    Disable Stage   FRQV1_FUNCENA_LO1
    Disable Stage   FRQV1_MODE

Config & Test FRQV1(Underrequency)
    Enable Stage   FRQV1_MODE    1           
    Enable Stage   FRQV1_FUNCENA_HI1    1    #f>enable
    Enable Stage   FRQV1_MEASENA_HI1_1   1   #Enable f> used in setting group
    Set pick up value    FRQV1_FPICK_HI1_1    51    #set pick up value to 50Hz 
    Check State is None    FRQV1_H1CONDITION    #Due limitation of sputnik, frequency pick up value will be change to test the function.
    Set pick up value   FRQV1_FPICK_HI1_1   49    #set pick up value to <=49Hz 
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is ON     FRQV1_H1CONDITION    2    #Check f>condition = 2 (0=Normal;1=Start;2=Trip;3=Blocked)
    Disable Stage   FRQV1_MEASENA_HI1_1      #Disable f> used in setting group
    Disable Stage   FRQV1_FUNCENA_HI1
    Disable Stage   FRQV1_MODE
    
Config & Test DFT1
    Enable Stage   DFT1_MODE    1           
    Enable Stage   DFT1_FUNCENA_HZS1    1    #df/dt >/< (1) Enable
    Set pick up value     DFT1_HILO_HZS1_1    2    #df/dt >/< (1) operating mode (0=Rising;1=Falling;2=Both)
    Check State is None     DFT1_HZS1CONDITION    
    Set pick up value   DFT1_FPICK_HIGH_HZS1_1   51    #df/dt >/< (1) f> limit
    Set pick up value   DFT1_FPICK_LOW_HZS1_1   49
    #we need fequency injector here to inject different frequencies (Inject more then 2Hz diffrence ex 52-49Hz)
    #Check State is ON     FRQV1_H1CONDITION    2    #This test should uncommented when the frequency injector applied 
    Disable Stage   DFT1_MODE             
    Disable Stage   DFT1_FUNCENA_HZS1     
   

Config & Test TOLM1
    Enable Stage   TOLM1_MODE    1
    Set pick up value    TOLM1_IN    0.4
    Enable Stage    SYS_PRESET    1           #reset protection function
    Check State is ON   TOLM1_THSTATUS    4       # Check motor status is running normally
    Switch Injection to High Current
    Check State is ON     TOLM1_THSTATUS    3    # Check motor status is overloading  the status // "Overloading" is shown. When the measured current is above 2 x In, the status"High overload" is shown.
    Switch Injection to Low Current              #Due the limitation of sputnik, it not possible to test high overload. exceeding 2xln is not possible with the current CT scalling.
    Check State is ON   TOLM1_THSTATUS    4       # Check motor status is running normally again
    Disable Stage    TOLM1_MODE







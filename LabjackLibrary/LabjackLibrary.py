import u3
import time
import numpy as np
import LabJackPython
from labjack_unified.devices import LabJackU3
class LabjackLibrary:
    def __init__(LJ):
        LJ.DId = None
    def open_labjack(LJ, DId): #Open connection to LabJack
        try:
            LJ.DId = u3.U3(firstFound=False, localId=DId)
            print(LJ.DId.configU3())
            LJ.DId.configU3(FIOAnalog=0,CIODirection = 0,CIOState = 1)
            print(LJ.DId.configU3())
                       
        except Exception as e:
            raise ConnectionError("Failed to establish LabJack connection: " + str(e))




    
    def Activaite_Relay(LJ,pin):        #open Connection to Relay 
        try:
            LJ.DId.configIO(FIOAnalog=0, EIOAnalog=0, NumberOfTimersEnabled=0, EnableCounter1=False, EnableCounter0=False)
            LJ.DId.setDOState(int(pin), 0)
        except Exception as e:
            raise ConnectionError("Failed to Activaite relay : " + str(e))
        return "0"

    def DeActivaite_Relay(LJ, pin):
        try:
            LJ.DId.setDOState(int(pin), 1)
            return "0"
        except Exception as e:
            raise ConnectionError("Failed to DeActivaite relay : " + str(e))
            
            
        

    def getDIOState(LJ, ioNum):
       
          state = LJ.DId.getDIOState(int(ioNum))
          if state == 0:
               return "0"
 
          else:
               return "1"
          
    
    def read_input_state(LJ, ioNum):
       try:
           time.sleep(0.5) # Sleep for 3 seconds
           LJ.DId.configU3(FIOAnalog=0,CIODirection = 0)
           LJ.DId.configIO(FIOAnalog=0)
           LJ.DId.getFeedback(u3.BitDirWrite(16, 0))
           LJ.DId.getFeedback(u3.BitDirWrite(17, 0))
           LJ.DId.getFeedback(u3.BitDirWrite(18, 0))
           LJ.DId.getFeedback(u3.BitDirWrite(19, 0))
    
           LJ.DId.getDIState(int(ioNum))
           Input_state = LJ.DId.getDIState(int(ioNum))
           print("Input state = ", Input_state)
           
           if Input_state == 0:
               return "0"
 
           else:
                     return "1"
       except Exception as e:
           raise ValueError("Failed to read input state: " + str(e))
       
       
    

    def close_labjack(LJ):
        if LJ.DId is not None:
            LJ.DId.close()
            LJ.DId = None

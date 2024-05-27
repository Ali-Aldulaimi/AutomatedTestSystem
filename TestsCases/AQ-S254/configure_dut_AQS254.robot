*** Settings ***
Library           Process
Library           OperatingSystem
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Conf01: Restore factory defaults
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_factory_reset_AQS254.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf02: Configure DUT IP address
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_setup_communications_AQS254.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf03: Initialize connection to the DUT via AQtivate
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_lead_in_AQ254.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf04: Configure digital inputs
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_dig_io_AQ254.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback}
Conf05: Close AQtivate
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_lead_out_AQ254.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
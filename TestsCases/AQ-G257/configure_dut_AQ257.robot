*** Settings ***
Library           Process
Library           OperatingSystem
Suite Teardown    Terminate All Processes    kill=True

*** Test Cases ***
Conf01: Restore factory defaults
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_factory_reset.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf02: Configure DUT IP address
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_setup_communications.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf03: Initialize connection to the DUT via AQtivate
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_lead_in.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf04: Configure CT
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_ct_AQ257.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf05: Configure VT
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_vt.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf06: Configure Generator Module
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_generator_module.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf07: Configure digital inputs
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_dig_io.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
Conf08: Close AQtivate
    ${result} =	Run Process	 java  -jar  ../tools/sikulixide-2.0.5.jar  -r  ../sikulix/sik_dut_configuration_lead_out.py
    Should Not Contain	 ${result.stdout}  [error] --- Traceback
type("d", Key.WIN)
wait(1)
type(Key.WIN)
wait(1)
type("aqtivate")
wait(2)
type(Key.ENTER)
wait("aq_status_red.png", 20)
click(Pattern("aq_menustrip_disconnected_empty_ip.png").targetOffset(222,1))
click(Pattern("aq_menustrip_select_ip.png").targetOffset(-15,0))
click(Pattern("aq_menustrip_disconnected_front_ip.png").targetOffset(277,2))
wait(Pattern("aq_status_green.png").similar(0.61), 20)
click(Pattern("aq_menustrip.png").targetOffset(-125,0))
click(Pattern("aq_menustrip_commands_connected.png").targetOffset(-76,-110))
wait(Pattern("aq_dialog_def_name_aqs_file_already_exists.png").similar(0.85), 60)
click(Pattern("aq_dialog_def_name_aqs_file_already_exists.png").similar(0.85).targetOffset(-44,67))
wait(Pattern("aq_dialog_aqs_open_this_file_now.png").similar(0.85), 60)
click(Pattern("aq_dialog_aqs_open_this_file_now.png").similar(0.85).targetOffset(-45,33))
wait("aq_menustruct_all.png", 90)
Do.popup("Waiting 5 seconds for the menustruct to load", 5)
click("aq_menustruct_communication.png")
click(Pattern("aq_parameters_ethernet.png").targetOffset(557,-2))
type("a", Key.CTRL)
type("192.168.100.53"+Key.ENTER)
click(Pattern("aq_parameters_ethernet.png").targetOffset(555,69))
type("a", Key.CTRL)
type("192.168.100.1"+Key.ENTER)
click(Pattern("aq_menustrip.png").targetOffset(-124,1))
click(Pattern("aq_menustrip_commands_connected.png").targetOffset(-65,-65))
click(Pattern("aq_dialog_write_changes.png").similar(0.85).targetOffset(-247,301))
wait(Pattern("aq_dialog_reconf_comm_settings.png").similar(0.85), 60)
click(Pattern("aq_dialog_reconf_comm_settings.png").similar(0.85).targetOffset(75,38))
Do.popup("Waiting 5 seconds for the IP change negotiation to finish", 5)
click(Pattern("aq_menustrip_connected_front_ip.png").targetOffset(274,3))
click(Pattern("aq_menustrip_disconnected_front_ip.png").targetOffset(158,2))
type("a", Key.CTRL)
type("192.168.100.53")
while not exists(Pattern("aq_status_green.png").similar(0.60)):
    Do.popup("Waiting 10 seconds for the new settings to take effect. \nThen we try to connect", 10)
    # Wait to make sure we give DUT enough time to take the newly changed IP address into use
    click(Pattern("aq_menustrip_disconnected_53_ip_2.png").similar(0.65).targetOffset(238,-113))
    Do.popup("Waiting 50 seconds for the connection to open", 50)
if exists(Pattern("aq_dialog_errors_and_warnings.png").similar(0.90)):
    click(Pattern("aq_dialog_errors_and_warnings.png").similar(0.90).targetOffset(0,321))
click(Pattern("aq_status_green.png").similar(0.61)) # Make sure focus is in AQtivate
type(Key.F4, KeyModifier.ALT) # Close AQtivate
if exists(Pattern("aq_dialog_save_on_exit.png").similar(0.85)):
    click(Pattern("aq_dialog_save_on_exit.png").similar(0.85).targetOffset(42,38))
else:
    type(Key.ENTER) # Confirm close
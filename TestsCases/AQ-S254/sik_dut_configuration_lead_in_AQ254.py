type("d", Key.WIN)
wait(1)
type(Key.WIN)
wait(1)
type("aqtivate")
wait(2)
type(Key.ENTER)
wait("aq_status_red.png", 20)
click(Pattern("aq_menustrip_disconnected_empty_ip.png").targetOffset(139,2))
type("192.168.100.53")
click(Pattern("aq_menustrip_disconnected_53_ip.png").targetOffset(275,1))
wait(Pattern("aq_status_green.png").similar(0.61), 20)
click(Pattern("aq_menustrip.png").targetOffset(-126,-1))
click(Pattern("aq_menustrip_commands_connected.png").targetOffset(-72,-113))
wait(Pattern("aq_dialog_def_name_aqs_file_already_exists.png").similar(0.85), 60)
click(Pattern("aq_dialog_def_name_aqs_file_already_exists.png").similar(0.85).targetOffset(-41,66))
wait(Pattern("aq_dialog_aqs_open_this_file_now.png").similar(0.85), 60)
click(Pattern("aq_dialog_aqs_open_this_file_now.png").similar(0.85).targetOffset(-40,33))
wait("aq_menustruct_all.png", 90)

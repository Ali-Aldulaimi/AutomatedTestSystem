#setBundlePath("C:/jenkins/workspace/dev/25x_dev_jari/src_tests/sikulix/pics")
type("d", Key.WIN)
wait(1)
type(Key.WIN)
wait(1)
type("aqtivate")
wait(2)
type(Key.ENTER)
wait("aq_status_red.png", 20)
click(Pattern("aq_menustrip_disconnected_empty_ip.png").targetOffset(113,1))
type("192.168.100.53")
click(Pattern("aq_menustrip_disconnected_53_ip.png").targetOffset(276,3))
wait(Pattern("aq_status_green.png").similar(0.61).targetOffset(-80,-43), 30)
click(Pattern("aq_menustrip.png").targetOffset(-123,0))
click(Pattern("aq_menustrip_commands_connected.png").targetOffset(-44,69))
wait(2)
click(Pattern("aq_dialog_factory_reset_1.png").similar(0.85).targetOffset(-40,66))
wait(2)
click(Pattern("aq_dialog_factory_reset_2.png").similar(0.85).targetOffset(-38,66))
wait(2)
click(Pattern("aq_dialog_factory_reset_3.png").similar(0.85).targetOffset(-40,66))
wait(Pattern("aq_dialog_reconf_comm_settings.png").similar(0.85), 60)
if exists (Pattern("aq_dialog_reconf_comm_settings.png").similar(0.85)):
    click(Pattern("aq_dialog_reconf_comm_settings.png").similar(0.85).targetOffset(72,38))
Do.popup("Waiting 5 seconds for the IP change negotiation to finish", 5)
click(Pattern("aq_menustrip_connected_53_ip.png").targetOffset(315,2))
type(Key.F4, KeyModifier.ALT) # Close AQtivate
if exists(Pattern("aq_dialog_save_on_exit.png").similar(0.85)):
    click(Pattern("aq_dialog_save_on_exit.png").similar(0.85).targetOffset(42,38))
else:
    type(Key.ENTER) # Confirm close
# Wait for the PCPU to reboot before continuing to the next test
Do.popup("Waiting 70 seconds for the DUT to reboot", 70)
wait(Pattern("aq_status_green.png").similar(0.61), 10)
click(Pattern("aq_status_green.png").similar(0.61)) # Make sure focus is in AQtivate
type(Key.F4, KeyModifier.ALT) # Close AQtivate
if exists(Pattern("aq_dialog_save_on_exit.png").similar(0.85)):
    click(Pattern("aq_dialog_save_on_exit.png").similar(0.85).targetOffset(42,38))
else:
    type(Key.ENTER) # Confirm close
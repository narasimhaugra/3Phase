import gptest


def prompt_yes_no(prompt_text):
    response = ""
    while response not in ('y', 'n'):
        response = raw_input("{} (y/n): ".format(prompt_text))

        if response not in ('y', 'n'):
            print "Please answer 'y' (for yes) or 'n' (for no)."
            
    return response


class LEDsOk(gptest.TestCase):
    def get_input_value(self, input_tag):
        response = ""

        if input_tag == 'left_indicator_on':
            response = prompt_yes_no("Is the left blue indicator on?")
        elif input_tag == 'center_indicator_on':
            response = prompt_yes_no("Is the center blue indicator on?")
        elif input_tag == 'right_indicator_on':
            response = prompt_yes_no("Is the right blue indicator on?")
        elif input_tag == 'green_led_on':
            response = prompt_yes_no("Is the green LED on?")
        elif input_tag == 'red_led_on':
            response = prompt_yes_no("Is the red LED on?")
        else:
            raise gptest.InputNotAvailableError(input_tag)

        return response


class LCDOk(gptest.TestCase):
    def get_input_value(self, input_tag):
        response = ""

        if input_tag == 'lcd_backlight_on':
            response = prompt_yes_no("Is the LCD backlight on?")
        elif input_tag == 'lcd_all_on':
            response = prompt_yes_no("Are all LCD segments on?")
        else:
            raise gptest.InputNotAvailableError(input_tag)

        return response


class ScrollButtonOk(gptest.TestCase):
    def get_input_value(self, input_tag):
        response = ""

        if input_tag == 'set_scroll_button_pressed':
            raw_input("Please hold the scroll button, press enter, and keep it held until the end of the test.")
            response = 'y'
        else:
            raise gptest.InputNotAvailableError(input_tag)

        return response


class CoverTamperButtonOk(gptest.TestCase):
    def get_input_value(self, input_tag):
        response = ""

        if input_tag == 'set_tamper_button_released':
            raw_input("Please ensure the cover tamper button is in the released (up) position and press enter.")
            response = 'y'
        elif input_tag == 'set_tamper_button_pressed':
            raw_input("Please ensure the cover tamper button is in the pressed (down) position and press enter.")
            response = 'y'
        else:
            raise gptest.InputNotAvailableError(input_tag)

        return response


class ExternalFlashPresent(gptest.TestCase):
    pass


class RFModuleOk(gptest.TestCase):
    pass

/**
 * @file hardware_test.cpp
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "gpos/hardware/boards/node_1_2/board_node_1_2.h"
#include "gpos/unittest/unittest.h"
#include "gpos/unittest/test_case.h"


BoardNode12 board;


class Node12HardwareTestCase : public TestCase
{
protected:

	Node12HardwareTestCase()
	{
	}
};


/**
 * Test if all LEDs are connected and functioning.
 */
TEST(Node12HardwareTestCase, LEDsOk)
{
	board.leftIndicator.turnOn();
	getInputAndCheck("left_indicator_on", "y");
	board.leftIndicator.turnOff();

	board.centerIndicator.turnOn();
	getInputAndCheck("center_indicator_on", "y");
	board.centerIndicator.turnOff();

	board.rightIndicator.turnOn();
	getInputAndCheck("right_indicator_on", "y");
	board.rightIndicator.turnOff();

	board.greenLed.turnOn();
	getInputAndCheck("green_led_on", "y");
	board.greenLed.turnOff();

	board.redLed.turnOn();
	getInputAndCheck("red_led_on", "y");
	board.redLed.turnOff();
}


/**
 * Test whether LCD and LCD backlight are functioning.
 */
TEST(Node12HardwareTestCase, LCDOk)
{
	board.lcdBacklight.turnOn();
	getInputAndCheck("lcd_backlight_on", "y");

	board.energyMeterLcd.setAll();
	getInputAndCheck("lcd_all_on", "y");

	board.energyMeterLcd.clearAll();
	board.lcdBacklight.turnOff();
}

/**
 * Test whether the scroll button is functioning properly.
 */
TEST(Node12HardwareTestCase, ScrollButtonOk)
{
	assertTrue(board.scrollButton.getStatus() == released);

	getInputAndCheck("set_scroll_button_pressed", "y");
	assertTrue(board.scrollButton.getStatus() == pressed);
}

/**
 * Test whether the cover tamper button is functioning properly.
 */
TEST(Node12HardwareTestCase, CoverTamperButtonOk)
{
	getInputAndCheck("set_tamper_button_released", "y");
	assertTrue(board.coverTamperButton.getStatus() == released);

	getInputAndCheck("set_tamper_button_pressed", "y");
	assertTrue(board.coverTamperButton.getStatus() == pressed);
}

/**
 * Test if flash chip is up by getting its manufacturer and device ID.
 */
TEST(Node12HardwareTestCase, ExternalFlashPresent)
{
	uint8_t manufacturer;
	uint8_t deviceId;
	board.externalFlash.getManufacturerAndDeviceId(&manufacturer, &deviceId);

	assertTrue(manufacturer == 0xEF);
	assertTrue(deviceId == 0x13);
}

/**
 * Test if RF module is up by querying it for RSSI.
 */
TEST(Node12HardwareTestCase, RFModuleOk)
{
	uint8_t reading = board.rfModule.getRSSIReading();

	/**
	 * Raw RSSI reading of 230 corresponds to an RSSI of -115 dBm, which is
	 * below the sensitivity level of the module (); therefore any reading
	 * out of this range is suspicious
	 */
	assertTrue(reading < 240);
}


class Node12HardwareTest: public UnitTest
{
public:
	LEDsOk test1;
	LCDOk test2;
	ScrollButtonOk test3;
	CoverTamperButtonOk test4;
	ExternalFlashPresent test5;
	RFModuleOk test6;
	TestCase *myTestCases[6];

	Node12HardwareTest::Node12HardwareTest()
		: UnitTest("hardware_test")
	{
		testCases = myTestCases;
		testCases[0] = &test1;
		testCases[1] = &test2;
		testCases[2] = &test3;
		testCases[3] = &test4;
		testCases[4] = &test5;
		testCases[5] = &test6;
	}
	uint16_t getNumTestCases() { return 6; }
};


int main()
{
	board.watchdog.disable();
	board.lcdBacklight.turnOff();

	Communicator::initialize(&(board._maxwellSerial));

	Node12HardwareTest test;

	while (1)
	{
		board.update();
		test.update();
	}
}

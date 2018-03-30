/**
 * @file board_assembly_test.cpp
 * Program which tests all different features of the board to ensure that it
 * has been assembled correctly.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "../board_node_1_1.h"


int main(void)
{
	BoardNode11 board;

	/** Turn on all UI elements */
	board.lcdBacklight.turnOn();
	board.redLed.turnOn();
	board.greenLed.turnOn();
	board.leftIndicator.turnOn();
	board.centerIndicator.turnOn();
	board.rightIndicator.turnOn();

	StopWatch sw(&(board.systemTime));
	while(1)
	{
		board.update();

		if (board.coverTamperButton.getStatus() == pressed)
		{
			board.energyMeterLcd.clearAll();
			board.energyMeterLcd.displayString("BUT 1", 5);
		}
		else if (board.scrollButton.getStatus() == pressed)
		{
			board.energyMeterLcd.clearAll();
			board.energyMeterLcd.displayString("BUT 2", 5);
		}
		else
		{
			board.energyMeterLcd.clearAll();
			board.energyMeterLcd.displayString("-TEST-", 6);
		}

		sw.delay(100);
	}

	return 0;
}

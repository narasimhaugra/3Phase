/**
 * @file rc11x_range_testing.cpp
 * Program to facilitate RF range testing on the Node board.
 *
 * This program has four states:
 *    1. Router Mode - Radiocrafts module is in its normal Router mode to allow
 *       for connectivity testing. In this mode the LCD displays "rOutEr".
 *    2. Gateway Mode - Radiocrafts module is in Gateway mode to allow for connectivity
 *    	 testing. In this mode the LCD displays "GAtE"
 *    3. Tx Carrier Mode - Radiocrafts module is in TX Carrier mode, transmitting
 *       a constant carrier to allow for direct signal strength measurements.
 *       In this mode the LCD displays "CArr".
 *    4. Signal Strength Mode - Radiocrafts module is in Config mode, and the
 *    	 microcontroller periodically polls it for signal strength with the 'S' command
 *    	 and displays the result. In this mode the LCD displays "S [strength]" where
 *    	 [strength] is an integer representing signal strength in dBm.
 *
 * The user may toggle between the different states by pressing the Scroll button or by
 * sending the character 'n' (which stands for "next") over the IR interface.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

// TODO: Add a way to configure channel, output power, network ID, etc. over IR interface

#include "../board_node_1_2.h"
//#include "../../pmu_5_3/board_pmu_5_3.h"

typedef enum state_enum
{
	state_router,
	state_gateway,
	state_tx_carrier,
	state_signal_strength
} state_t;

int main(void)
{
	//BoardPmu53 board;
	BoardNode12 board;
	board.lcdBacklight.turnOn();
	StopWatch startupDelayTimer(&(board.systemTime));
	startupDelayTimer.delay(500);

	board.rfModule.setNodeType(router);
	board.rfModule.exitConfigMode();
	board.energyMeterLcd.clearAll();
	board.energyMeterLcd.displayString("ROUTER", 6);
	state_t state = state_router;

	StopWatch updateTimer(&(board.systemTime));
	push_button_status_t buttonStatus = board.scrollButton.getStatus();
	/** For signal strength mode averaging */
	uint8_t signalStrengthNumSamples = 0;
	int32_t signalStrengthSum = 0;
	while(1)
	{
		board.update();

		uint8_t byte = '\0';
		push_button_status_t currentButtonStatus = board.scrollButton.getStatus();
		if (((currentButtonStatus == pressed) && (buttonStatus == released)) ||
				(board.irModule.recv(&byte) && (byte == 'n')))
		{
			board.redLed.turnOff();
			board.greenLed.turnOn();
			if (currentButtonStatus == pressed)
			{
				buttonStatus = pressed;
			}
			updateTimer.reset();

			if (state == state_router)
			{
				board.rfModule.setNodeType(gateway);
				board.rfModule.exitConfigMode();
				board.energyMeterLcd.clearAll();
				board.energyMeterLcd.displayString("GATE", 4);
				state = state_gateway;
			}
			else if (state == state_gateway)
			{
				board.rfModule.sendTXCarrier();
				board.energyMeterLcd.clearAll();
				board.energyMeterLcd.displayString("CARR", 4);
				state = state_tx_carrier;
			}
			else if (state == state_tx_carrier)
			{
				uint8_t signalStrength = board.rfModule.getRSSIReading();
				board.energyMeterLcd.clearAll();
				board.energyMeterLcd.displayInteger(-1 * (int16_t(signalStrength) / 2));
				board.energyMeterLcd.setChar(0, 'S');
				state = state_signal_strength;
			}
			else
			{
				board.rfModule.setNodeType(router);
				board.rfModule.exitConfigMode();
				board.energyMeterLcd.clearAll();
				board.energyMeterLcd.displayString("ROUTER", 6);
				state = state_router;
			}
		}
		else if (currentButtonStatus == released)
		{
			board.greenLed.turnOff();
			board.redLed.turnOn();
			buttonStatus = released;
		}

		/** Update states which have changing information */
		if (updateTimer.getElapsedMilliSec() > 250)
		{
			updateTimer.reset();

			if (state == state_signal_strength)
			{
				signalStrengthSum += board.rfModule.getRSSIReading();
				signalStrengthNumSamples++;

				/**
				 * If we've collected enough samples, compute the average and
				 * display the result
				 */
				if (signalStrengthNumSamples >= 4)
				{
					int32_t signalStrength = -1 * ((signalStrengthSum / ((int32_t)signalStrengthNumSamples)) / 2);
					board.energyMeterLcd.clearAll();
					board.energyMeterLcd.displayInteger(signalStrength);
					board.energyMeterLcd.setChar(0, 'S');

					signalStrengthNumSamples = 0;
					signalStrengthSum = 0;
				}
			}
		}
	}

	return 0;
}

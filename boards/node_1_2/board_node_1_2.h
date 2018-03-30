/**
 * @file board_node_1_2.h
 * Board definition for Node v1.2.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef BOARD_NODE_1_2_H_
#define BOARD_NODE_1_2_H_

#define SECONDS_BETWEEN_1900_AND_1970 2208988800

#include <time.h>
#include "gpos/hardware/boards/board.h"
#include "gpos/hardware/components/drivers.h"
#include "gpos/hardware/microcontrollers/msp430f6733.h"
#include "gpos/utils/utils.h"
#include "assert.h"


using namespace msp430f6733;

class BoardNode12 : public Board
{
public:
	typedef enum
	{
		normal,
		sub_2_ma
	} power_mode_t;

private:
	power_mode_t _powerMode;
	StopWatch timeUpdateSw;

	/** microcontroller internals */
	Clock _clock;
	Timer _timer;
	IOPin _redLedPin;
	IOPin _greenLedPin;
	IOPin _leftIndicatorPin;
	IOPin _centerIndicatorPin;
	IOPin _rightIndicatorPin;

    /**
     * These pins are power supply for cover open tamper and scroll button pins.
     * Separate pins are used to power to have larger control of power consumption
     * (not sure but some pull-up power consumption).
     */
	IOPin _scrollButtonPullUpSupply;
	IOPin _coverTamperPullUpSupply;

	IOPin _rfCtsPin;
	IOPin _rfConfigPin;
	IOPin _rfResetPin;

	IOPin _irShutdownPin;
	IOPin _lcdBacklightPin;
	IOPin _scrollButtonPin;
	IOPin _coverTamperButtonPin;

	/** Pins for latching relay.*/
	IOPin _relayPin1;
	IOPin _relayPin2;

	/**
	 * This pin is used to choose between super sleep and normal mode.Right now
	 *  the pin is used before board is initialised and hence is used in the raw
	 *  form(registers directly accessed)
	 */
	IOPin maxwellMainsIndicator;

	LCDDriver _lcdDriver;

	bool _updateSystemTimeFromRTC();

public:
	/** These IOPins are public, since currently they are used as raw GPIO */
	IOPin maxwellNeutralMissing;
	IOPin maxwellGPIO2;
	IOPin maxwellResetPin;
	AuxSupply auxSupply;

	Flash infoFlash;
	Watchdog watchdog;
	CRC_Module crcModule;
	UART _rfSerial;
	UART _irSerial;
	UART _maxwellSerial;
	SPI _externalFlashSPI;

	MyTime systemTime;

	/** board specific */
	LED redLed;
	LED greenLed;
	LED leftIndicator;
	LED centerIndicator;
	LED rightIndicator;
	LED lcdBacklight;

	LCD_ESTLCG083 energyMeterLcd;
	RC11XX rfModule;
	IrDA irModule;

	SimpleSerial maxwellComm;
	Flash_W25Q80BV externalFlash;
	PushButton coverTamperButton;
	PushButton scrollButton;
	LatchingRelay relay;
	RTC rtc;

	BoardNode12();
	void reset();
	void update();

	/*
	 * This is used to switch between power modes.Right now two power modes
	 * are there ie:normal mode & sub 2 mA mode.
	 */
	void setPowerMode(power_mode_t mode);
	void assertRaise(char* filePath, uint16_t lineNumber);
	void _timerCallback();
};

#endif  /** BOARD_NODE_1_2_H_ */

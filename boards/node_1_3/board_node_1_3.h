/**
 * @file board_node_1_3.h
 * Board definition for Node v1.3.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef BOARD_NODE_1_3_H_
#define BOARD_NODE_1_3_H_

#define SECONDS_BETWEEN_1900_AND_1970 2208988800

#include <time.h>
//#include "gpos/hardware/boards/board.h"
#include "gpos/hardware/components/drivers.h"
#include "gpos/hardware/microcontrollers/msp430f6733.h"
#include "gpos/utils/utils.h"
#include "assert.h"


using namespace msp430f6733;

//class BoardNode13 : public Board
class BoardNode13:public base::TimerUser
{
public:

	/**
	 * The two possible power modes of the PCB.
	 * In each of the modes, the states of certain components,
	 * such as LEDs is slightly different, as in normal mode,
	 * the PCB is running using DVCC supply, while in sub_2_ma mode,
	 * the PCB is running using AUXVCC supply.
	 */
	typedef enum
	{
		normal,
		sub_2_ma
	} power_mode_t;


private:


	/**
	 * Every 60 seconds, the systemTime is synchronized with the RTC.
	 * timeUpdateSw stopwatch is used to ensure that.
	 */
	StopWatch timeUpdateSw;

	/** microcontroller internals */
	Clock _clock;
	Timer _timer;
	//IOPin _redLedPin;
	//IOPin _greenLedPin;
	//IOPin _leftIndicatorPin;
	//IOPin _centerIndicatorPin;
	//IOPin _rightIndicatorPin;

	IOPin _scrollButtonPullUpSupply;
	IOPin _coverTamperPullUpSupply;

	IOPin _rfCtsPin;
	IOPin _rfConfigPin;
	IOPin _rfResetPin;

	IOPin _irShutdownPin;
	IOPin _lcdBacklightPin;
	IOPin _scrollButtonPin;
	IOPin _coverTamperButtonPin;

	

	LCDDriver _lcdDriver;

	UART _rfSerial;
	UART _irSerial;
	SPI _externalFlashSPI;

	/**
	 * Synchronises systemTime with RTC time. This is a non blocking function.
	 * If the RTC is busy, the update fails
	 *
	 * @return true if the RTC was not busy and hence, the update succeeded; false otherwise
	 */
	bool _updateSystemTimeFromRTC();


	/**
	 * The variable keeps account of number of power cycles the
	 * meter has been operating without power.
	 */
    uint8_t noPowerLoopCycle;

    power_mode_t _powerMode;

private:
	/**
	 * Resets the microcontroller
	 */
	void _reset();
    
public:
	// _maxwellSerial is public because it is occasionally used for e-tests
	UART _maxwellSerial;
	/** These IOPins are public, since currently they are used as raw GPIO */
	IOPin maxwellMainsIndicator;
	IOPin maxwellNeutralMissing;
	IOPin maxwellGPIO2;
	IOPin maxwellResetPin;
	IOPin mainVCCControl;

	IOPin relayPin1;
	//IOPin _relayPin2;

	AuxSupply auxSupply;
	Flash infoFlash;
	Watchdog watchdog;
	CRC_Module crcModule;

	/** systemTime keeps track of the time. It is incremented in the _timerCallback
	 * function. Also, every 60 seconds, it is synchronised with the RTC clock.
	 * systemTime maybe made obsolete eventually and we can probably entirely rely on RTC eventually */
	MyTime systemTime;

	//LED redLed;
	//LED greenLed;
	//LED leftIndicator;
	//LED centerIndicator;
	//LED rightIndicator;
	LED lcdBacklight;

	LCD_ESTLCG083 energyMeterLcd;
	RC11XX rfModule;
	IrDA irModule;

	SimpleSerial maxwellComm;
	Flash_W25Q80BV externalFlash;
	PushButton coverTamperButton;
	PushButton scrollButton;
	//LatchingRelay relay;
	RTC rtc;

	BoardNode13();


	/**
	 * Any upper layer can request a reset and the reset will only happen
	 * after two polling cycles of the board update loop.This helps the
	 * upper layers to be informed that a power reset is gonna happen and
	 * can save their context.
	 */
	void requestReset();

	/**
	 * 1. Keeps checking the power supply. If the state of uC needs to
	 * change between normal & sub_2_ma modes, then the uC is reset.
	 *
	 * 2. Also keeps updating the UART serial ports & relay
	 *
	 * 3. Every 60 seconds, synchronises systemTime with RTC time
	 *
	 * 4. Checks for power conditions.If any mismatch, restarts the meter.
	 */
	void update();

	/*
	 * This is used to switch between power modes.
	 * Right now two power modes are supported
	 *
	 * 1. normal mode: when uC is running on mains supply
	 * 2. sub_2_ma mode: when uC is running on NM supply
	 */
	void setPowerMode(power_mode_t mode);

	/**
	 * The assertion mechanism is explained in gp_doc's Assertions.pdf document
	 */
	void assertRaise(char* filePath, uint16_t lineNumber);

	/**
	 * The Board class is a subclass of TimerUser (defined in microcontrollers/base/timer.h).
	 * The Board is also registered with a timer module. Hence, the _timerCallback
	 * function is called in the interrupt service routing of the timer module (at a rate of 4kHz).
	 * This function updates systemTime
	 */
	void _timerCallback();

	/**
	 * Checks the mains pin (pin 8 in maxwell 12 pin connector)
	 * and return true if the pin is high else return false.
	 * @return:true if mains supply present else false
	 */
	static bool  checkMainsSupply();


	/**
	 * Returns the current power mode meter
	 * is operating in.
	 */
	power_mode_t getPowerMode();

	/**
	 * Indicates that the board is going to reset within next two
	 * update(polling) cycles.
	 * @return:true if the meter is gonna restart
	 */
	bool amIrestarting();
};

#endif  /** BOARD_NODE_1_3_H_ */

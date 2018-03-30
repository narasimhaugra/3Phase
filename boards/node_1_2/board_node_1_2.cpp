/**
 * @file board_node_1_2.cpp
 * Board definition for Node v1.2.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "board_node_1_2.h"

using namespace msp430f6733;


BoardNode12::BoardNode12()
	: watchdog(),
	  _clock(),
	  _timer(TIMER_A0),
	  _redLedPin(PORT6, 1, base::output, base::high),
	  _greenLedPin(PORT6, 0, base::output, base::high),
	  _leftIndicatorPin(PORT6, 6, base::output, base::high),
	  _centerIndicatorPin(PORTJ, 3, base::output, base::high),
	  _rightIndicatorPin(PORT5, 5, base::output, base::high),
	  _scrollButtonPullUpSupply(PORTJ, 1, base::output, base::high),
	  _coverTamperPullUpSupply(PORTJ, 0, base::output, base::high),
	  _rfCtsPin(PORT5, 7, base::input, base::high),
	  _rfConfigPin(PORT5, 6, base::output, base::high),
	  _rfResetPin(PORT6, 2, base::output, base::high),
	  _irShutdownPin(PORT6, 7, base::output, base::high),
	  _lcdBacklightPin(PORT6, 3, base::output, base::low),
	  _scrollButtonPin(PORT2, 7, base::input, base::high),
	  _coverTamperButtonPin(PORT2, 4, base::input, base::high),
	  _relayPin1(PORTJ, 2, base::output, base::low),  /** Low to keep relay off during startup */
	  _relayPin2(PORT6, 5, base::output, base::low),
	  _lcdDriver(S12),
	  _rfSerial(USCIA0),
	  _irSerial(USCIA1),
	  _maxwellSerial(USCIA2),
//	  _debugSerial(SOFTSERIAL0),
	  _externalFlashSPI(USCIB0, PORT2, 5),
	  maxwellMainsIndicator(PORT1, 6, base::input, base::high),
	  maxwellNeutralMissing(PORT2, 6,base::input, base::high),
	  maxwellGPIO2(PORT5, 4, base::input, base::low),
	  maxwellResetPin(PORT6, 4, base::output, base::high),
	  infoFlash(&watchdog),
	  redLed(&_redLedPin, inverted),
	  greenLed(&_greenLedPin, inverted),
	  leftIndicator(&_leftIndicatorPin,inverted),
	  centerIndicator(&_centerIndicatorPin, inverted),
	  rightIndicator(&_rightIndicatorPin, inverted),
	  lcdBacklight(&_lcdBacklightPin, noninverted),
	  energyMeterLcd(&_lcdDriver, inverted_sequence),
	  rfModule(&_rfConfigPin, &_rfResetPin, &_rfCtsPin, &_rfSerial),
	  irModule(&_irShutdownPin, &_irSerial),
	  maxwellComm(&_maxwellSerial, 2400),
//	  debugComm(&_debugSerial, 2400),
	  externalFlash(&_externalFlashSPI),
	  coverTamperButton(&_coverTamperButtonPin, high_when_pressed),
	  scrollButton(&_scrollButtonPin, low_when_pressed),
	  relay(&_relayPin2, &_relayPin1, &systemTime),
	  _powerMode(normal),
	  rtc(RTC::polling_mode),
	  timeUpdateSw(&systemTime)
{
	SFRRPCR |= SYSNMI;  /** Disable reset pin by putting it into NMI mode */
	lcdBacklight.turnOff();

	/** Set up time systems */
	systemTime.set(0, 0, 4096, 0);
	bool timeUpdateSucceeded = false;
	uint8_t count = 0;
	while (count < 50)
	{
		if (_updateSystemTimeFromRTC())
		{
			timeUpdateSucceeded = true;
			break;
		}

		count++;
	}
	BOARD_ASSERT(timeUpdateSucceeded);
	timeUpdateSw.reset();
	_timer.setCallback(this);

	_EINT();  /** Enable interrupts */

	StopWatch rfStopWatch(&systemTime);
	rfModule.reset(&rfStopWatch);

	// while transiting from super sleep to normal mode,
	// the RC config pin goes from high to low, and the RC module enters config state
	// Hence, forcefully exiting config mode
	_rfSerial.put('X');

	// the condition failed because the microcontroller was believing that DVCC is present
	// ie, the condition auxSupply.checkOk(DVCC_supply) was saying true
	// setPowerMode(sub_2_ma);

	// If we don't set uC in sub_2_ma mode, then the LCD refuses to work
}


/*
 * Reseting using PMM module is a hard reset. Earlier,
 * watchdog module was used for reseting (watchdog.resetSystem())
 */
void BoardNode12::reset()
{
	PMMCTL0 = ((PMMCTL0 & 0xFF) | PMMPW) | PMMSWBOR;  /** Reset system */
}


void BoardNode12::update()
{
	if(!auxSupply.checkOk(DVCC_supply))
	{
		if(maxwellNeutralMissing.getValue())
		{
			setPowerMode(sub_2_ma);
		}
		else
		{
			reset();
		}
	}
	else
	{
		if(_powerMode == sub_2_ma)
		{
			setPowerMode(normal);
		}
	}

	watchdog.kick();
	_rfSerial.update();
	_irSerial.update();
	_maxwellSerial.update();
	relay.update();

	/** Synchronize the systemTime variable with the RTC */
	if (timeUpdateSw.getApproxElapsedSec() >= 60)
	{
		if (_updateSystemTimeFromRTC())
		{
			timeUpdateSw.reset();
		}
	}
}


void BoardNode12::_timerCallback()
{
	systemTime.addIncrement(1);
}


void BoardNode12::setPowerMode(power_mode_t mode)
{
	switch (mode)
	{
	case normal:
		_powerMode = normal;
		_rightIndicatorPin.setHigh();
		_leftIndicatorPin.setHigh();
		_centerIndicatorPin.setHigh();
		_rfConfigPin.setHigh();
		_rfCtsPin.setHigh();
		_lcdBacklightPin.setHigh();
		_rfResetPin.setHigh();
		_rfSerial.enable();
		break;
	case sub_2_ma:
		_powerMode = sub_2_ma;
		_rightIndicatorPin.setLow();
		_leftIndicatorPin.setLow();
		_centerIndicatorPin.setLow();
		_rfConfigPin.setLow();
		_rfCtsPin.setLow();
		_lcdBacklightPin.setLow();
		_rfResetPin.setLow();
		_rfSerial.disable();
		break;
	}
}


bool BoardNode12::_updateSystemTimeFromRTC()
{
	datetime_t rtcTime;
	struct tm formattedTime;

	if (! rtc.getDatetime(rtcTime))
	{
		return false;
	}
	formattedTime.tm_year = rtcTime.year - 1900;
	formattedTime.tm_mon = rtcTime.month - 1;
	formattedTime.tm_mday = rtcTime.day;
	formattedTime.tm_hour = rtcTime.hour;
	formattedTime.tm_min = rtcTime.minute;
	formattedTime.tm_sec = rtcTime.second;
	formattedTime.tm_isdst = -1;

	uint32_t unixTime = mktime(&formattedTime) - SECONDS_BETWEEN_1900_AND_1970;
	systemTime.setRealTime(unixTime);

	return true;
}


// TODO: Should this functionality be in the UNMI ISR at all? Or should it be in
// the AUX ISR?
#pragma vector=UNMI_VECTOR
__interrupt void unmiInterrupt()
{
	// TODO: This reset should ideally not be in the main body of the ISR - if
	// we use one of the other flags associated with this ISR in the future, it
	// will cause issues. However, I'm confused about why AUXSWNMIE triggers the
	// BUSIFG flag rather than the NMIFG, so I'm just leaving this here for now.
	// PMMCTL0 = ((PMMCTL0 & 0xFF) | PMMPW) | PMMSWBOR;  /** Reset system */
	switch (__even_in_range(SYSUNIV, 0x08))
	{
		case 0x00:  /** No interrupts */
			break;
		case 0x02:  /** NMIFG: Non-maskable interrupt flag */
			break;
		case 0x04:  /** OFIFG: Oscillator fault interrupt flag */
			break;
		case 0x06:  /** ACCVIFG: Access violation flag */
			break;
		case 0x08:  /** BUSIFG: Bus error flag */
			break;
		default:
			break;
	}
}


void BoardNode12::assertRaise(char* filePath, uint16_t lineNumber)
{

	StopWatch assertTimer(&systemTime);
	assertTimer.reset();
	lcdBacklight.turnOn();
	energyMeterLcd.exitBlinkingMode();
	energyMeterLcd.clearAll();


	// Infer filename from filepath
	uint8_t length = 0;
	uint8_t lastSlash = 0;
	char fileName[6];
	while(filePath[length] != '\0')
	{
		length = length + 1;
		if(filePath[length] == '/')
		{
			lastSlash = length;
		}
	}
	uint8_t i;
	for(i=0; i<6; i++)
	{
		fileName[i] = filePath[lastSlash + i + 1] - 32;
	}



	enum
	{
		ERR_STATE,
		FILENAME_STATE,
		LINE_NUMBER_STATE
	} displayState;

	displayState = ERR_STATE;

	enum
	{
		NO_CHAR_RECEIVED,
		FIRST_CHAR_RECEIVED,
		SECOND_CHAR_RECEIVED,
		THIRD_CHAR_RECEIVED
	} parsingState;

	parsingState = NO_CHAR_RECEIVED;
	while(1)
	{
		watchdog.kick();

		// Check if reset assert command has been received
		char commandReceived;
		if (rfModule.recv((uint8_t*)&commandReceived) || irModule.recv((uint8_t*)&commandReceived))
		{
			if(parsingState == NO_CHAR_RECEIVED && commandReceived == 'x')
			{
				parsingState = FIRST_CHAR_RECEIVED;
			}
			if(parsingState == FIRST_CHAR_RECEIVED && commandReceived == '%')
			{
				parsingState = SECOND_CHAR_RECEIVED;
			}
			if(parsingState == SECOND_CHAR_RECEIVED && commandReceived == '?')
			{
				parsingState = THIRD_CHAR_RECEIVED;
				break;
			}
		}


		// Toggle through the display states
		if(assertTimer.getElapsedMilliSec() > 6000)
		{
			if(displayState != ERR_STATE)
			{
				energyMeterLcd.clearAll();
				energyMeterLcd.displayString("ERR   ", 6);
				assertTimer.reset();
			}
			displayState = ERR_STATE;
		}
		else if(assertTimer.getElapsedMilliSec() > 4000)
		{
			if(displayState != LINE_NUMBER_STATE)
			{
				energyMeterLcd.clearAll();
				energyMeterLcd.displayString("L", 1);
				energyMeterLcd.displayIntegerWithoutClearing(lineNumber);
			}
			displayState = LINE_NUMBER_STATE;
		}
		else if(assertTimer.getElapsedMilliSec() > 2000)
		{
			if(displayState != FILENAME_STATE)
			{
				energyMeterLcd.clearAll();
				energyMeterLcd.displayString("F", 1);
				energyMeterLcd.displayString(fileName, 6);
			}
			displayState = FILENAME_STATE;
		}
	}
}

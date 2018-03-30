#include "board_pmu_5_3.h"

using namespace msp430f6733;

BoardPmu53::BoardPmu53()
	: watchdog(),
	  _clock(),
	  _timer(TIMER_A0),
	  _redLedPin(PORT2, 0, base::output, base::high),
	  redLed(&_redLedPin, inverted),
	  _greenLedPin(PORT2, 1, base::output, base::high),
	  greenLed(&_greenLedPin, inverted),
	  _debugSerial(USCIA2),
	  _irSerial(USCIA1),
	  _coverTamperPin(PORT1, 1, base::input, base::high),
	  configModeButton(&_coverTamperPin,low_when_pressed),
	  _lcdDriver(S0),
	  energyMeterLcd(&_lcdDriver, noninverted_sequence),
	  _rfCtsPin(PORT3, 4, base::output, base::high),
	  _rfResetPin(PORT3, 6, base::input, base::high),//not the best way to do it; used to keep output floating
	  _rfConfigPin(PORT3, 5, base::input, base::high), //this should be output high by default
	  _rfSerial(USCIA0),
	  _sd24(),
	  rfModule(&_rfConfigPin, &_rfResetPin, &_rfCtsPin, &_rfSerial),
	  _irShutdownPin(PORT1, 7, base::output, base::high),
	  irModule(&_irShutdownPin, &_irSerial),
	  _lcdBacklightPin(PORT2, 7, base::output, base::low),
	  lcdBacklight(&_lcdBacklightPin, noninverted),
	  _leftIndicatorPin(PORT2, 6, base::output, base::high),
	  _centerIndicatorPin(PORT2, 5, base::output, base::high),
	  _rightIndicatorPin(PORT2, 4, base::output, base::high),
	  leftIndicator(&_leftIndicatorPin,inverted),
	  centerIndicator(&_centerIndicatorPin, inverted),
	  rightIndicator(&_rightIndicatorPin, inverted),
	  infoFlash(&watchdog),
	  debugComm(&_debugSerial, 57600),
	  _relayPin(PORT3, 3, base::output, base::low),
	  relay(&_relayPin, noninverted)
{
	_irSerial.setBaud(57600);
	_debugSerial.setBaud(57600);
	lcdBacklight.turnOff();
	 systemTime.set(0, 0, 4096, 0);
	_timer.setCallback(this);
	_EINT();

	StopWatch rfStopWatch(&systemTime);
	rfModule.reset(&rfStopWatch);
}

void BoardPmu53::update()
{
	watchdog.kick();
	//HACK!
	_sd24.startConversion();
	_rfSerial.update();
	_debugSerial.update();
	_irSerial.update();

}

void BoardPmu53::_timerCallback()
{
	systemTime.addIncrement(1);
}

void BoardPmu53::reset()
{
	watchdog.resetSystem();
}


void BoardPmu53::assertRaise(char* filePath, uint16_t lineNumber)
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


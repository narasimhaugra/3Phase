#include "board_node_1_1.h"

using namespace msp430f6733;

BoardNode11::BoardNode11()
	: watchdog(),
	  _clock(),
	  _timer(TIMER_A0),
	  _redLedPin(PORT6, 1, base::output, base::high),
	  _greenLedPin(PORT6, 0, base::output, base::high),
	  _leftIndicatorPin(PORT1, 6, base::output, base::high),
	  _centerIndicatorPin(PORTJ, 3, base::output, base::high),
	  _rightIndicatorPin(PORT5, 5, base::output, base::high),
	  _debug1Pin(PORTJ, 0, base::output, base::high),
	  _debug2Pin(PORTJ, 1, base::output, base::high),
	  _rfCtsPin(PORT5, 7, base::input, base::high),
	  _rfConfigPin(PORT5, 6, base::output, base::high),
	  _rfResetPin(PORT6, 2, base::output, base::high),
	  _irShutdownPin(PORT2, 6, base::output, base::high),
	  _lcdBacklightPin(PORT2, 7, base::output, base::low),
	  _scrollButtonPin(PORT6, 3, base::input, base::high),
	  _coverTamperButtonPin(PORT2, 4, base::input, base::high),
	  _relayPin(PORTJ, 2, base::output, base::low),  /** Low to keep relay off during startup */
	  _lcdDriver(S12),
	  maxwellBatteryModePin(PORT6, 7, base::input, base::high),
	  maxwellGPIO1(PORT6, 6, base::output, base::low),
	  maxwellGPIO2(PORT6, 5, base::input, base::low),
	  maxwellResetPin(PORT6, 4, base::output, base::high),
	  infoFlash(&watchdog),
	  _rfSerial(USCIA0),
	  _irSerial(USCIA1),
	  _maxwellSerial(USCIA2),
	  _debugSerial(SOFTSERIAL0),
	  _externalFlashSPI(USCIB0, PORT2, 5),
	  redLed(&_redLedPin, inverted),
	  greenLed(&_greenLedPin, inverted),
	  leftIndicator(&_leftIndicatorPin,inverted),
	  centerIndicator(&_centerIndicatorPin, inverted),
	  rightIndicator(&_rightIndicatorPin, inverted),
	  lcdBacklight(&_lcdBacklightPin, noninverted),
	  debug1RedLed(&_debug1Pin, noninverted),
	  debug2GreenLed(&_debug2Pin, noninverted),
	  energyMeterLcd(&_lcdDriver, inverted_sequence),
	  rfModule(&_rfConfigPin, &_rfResetPin, &_rfCtsPin, &_rfSerial),
	  irModule(&_irShutdownPin, &_irSerial),
	  maxwellComm(&_maxwellSerial, 2400),
	  debugComm(&_debugSerial, 2400),
	  externalFlash(&_externalFlashSPI),
	  coverTamperButton(&_coverTamperButtonPin, high_when_pressed),
	  scrollButton(&_scrollButtonPin, low_when_pressed),
	  relay(&maxwellGPIO1, &_relayPin, &systemTime)
{
	SFRRPCR |= SYSNMI;  /** Disable reset pin by putting it into NMI mode */
	lcdBacklight.turnOff();
	 systemTime.set(0, 0, 4096, 0, 19800);
	_timer.setCallback(this);
	_EINT();

	StopWatch rfStopWatch(&systemTime);
	rfModule.reset(&rfStopWatch);
}

void BoardNode11::reset()
{
	watchdog.resetSystem();
}

void BoardNode11::update()
{
	watchdog.kick();
	_rfSerial.update();
	_irSerial.update();
	_maxwellSerial.update();
	relay.update();
}

void BoardNode11::_timerCallback()
{
	systemTime.addIncrement(1);
}

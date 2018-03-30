#ifndef HAL_PMU_5_3_H
#define HAL_PMU_5_3_H

#include "gpos/hardware/boards/board.h"
#include "gpos/hardware/components/drivers.h"
#include "gpos/hardware/microcontrollers/msp430f6733.h"
#include "gpos/utils/utils.h"

using namespace msp430f6733;

class BoardPmu53 : public Board
{

private:
	/** microcontroller internals */
	Clock _clock;
	Timer _timer;
	IOPin _redLedPin;
	IOPin _greenLedPin;
	IOPin _leftIndicatorPin;
	IOPin _centerIndicatorPin;
	IOPin _rightIndicatorPin;
	IOPin _rfCtsPin;
	IOPin _rfConfigPin;
	IOPin _rfResetPin;
	IOPin _irShutdownPin;
	IOPin _lcdBacklightPin;
	IOPin _relayPin;

	LCDDriver _lcdDriver;
public:
	Watchdog watchdog;
	CRC_Module crcModule;
	Flash infoFlash;
	UART _debugSerial;
	UART _rfSerial;
	UART _irSerial;
	SD24 _sd24;

	IOPin _coverTamperPin;

	BoardPmu53();

	MyTime systemTime;
	void _timerCallback();

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
	SimpleSerial debugComm;
	NonLatchingRelay relay;
    PushButton configModeButton;
	void reset();
	void update();
	void assertRaise(char* filePath, uint16_t lineNumber);
};

#endif

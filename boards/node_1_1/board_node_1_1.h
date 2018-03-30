#ifndef BOARD_NODE_1_1_H_
#define BOARD_NODE_1_1_H_

#include "gpos/hardware/boards/board.h"
#include "gpos/hardware/components/drivers.h"
#include "gpos/hardware/microcontrollers/msp430f6733.h"
#include "gpos/utils/utils.h"


using namespace msp430f6733;

class BoardNode11 : public Board
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
	IOPin _debug1Pin;
	IOPin _debug2Pin;
	IOPin _rfCtsPin;
	IOPin _rfConfigPin;
	IOPin _rfResetPin;
	IOPin _irShutdownPin;
	IOPin _lcdBacklightPin;
	IOPin _scrollButtonPin;
	IOPin _coverTamperButtonPin;
	IOPin _relayPin;

	LCDDriver _lcdDriver;
public:
	/** These IOPins are public, since currently they are used as raw GPIO */
	IOPin maxwellBatteryModePin;
	IOPin maxwellGPIO1;
	IOPin maxwellGPIO2;
	IOPin maxwellResetPin;

	Flash infoFlash;
	Watchdog watchdog;
	CRC_Module crcModule;
	UART _rfSerial;
	UART _irSerial;
	UART _maxwellSerial;
	SoftUART _debugSerial;
	SPI _externalFlashSPI;

	BoardNode11();

	MyTime systemTime;
	void _timerCallback();

	/** board specific */
	LED redLed;
	LED greenLed;
	LED leftIndicator;
	LED centerIndicator;
	LED rightIndicator;
	LED lcdBacklight;
	LED debug1RedLed;
	LED debug2GreenLed;
	LCD_ESTLCG083 energyMeterLcd;
	RC11XX rfModule;
	IrDA irModule;
	SimpleSerial debugComm;
	SimpleSerial maxwellComm;
	Flash_W25Q80BV externalFlash;
	PushButton coverTamperButton;
	PushButton scrollButton;
	LatchingRelay relay;

	void reset();
	void update();
};

#endif  /** Board_NODE_1_1_H_ */

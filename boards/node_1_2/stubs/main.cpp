#include "gpos/hardware/boards/node_1_2/board_node_1_2.h"
#include "gpos/utils/time/stop_watch.h"

int main(void)
{
	BoardNode12 board;
	board.watchdog.disable();
	StopWatch sw(&(board.systemTime));

	bool disable = false;

	while(1)
	{
		board.leftIndicator.turnOn();
		sw.delay(500);
		board.leftIndicator.turnOff();

		board.centerIndicator.turnOn();
		sw.delay(500);
		board.centerIndicator.turnOff();

		board.rightIndicator.turnOn();
		sw.delay(500);
		board.rightIndicator.turnOff();

		board.greenLed.turnOn();
		sw.delay(500);
		board.greenLed.turnOff();

		board.redLed.turnOn();
		sw.delay(500);
		board.redLed.turnOff();

		board.update();

		if (disable)
		{
			board.leftIndicator.disable();
			board.centerIndicator.disable();
			board.rightIndicator.disable();
			board.greenLed.disable();
			board.redLed.disable();
		}
		else
		{
			board.leftIndicator.enable();
			board.centerIndicator.enable();
			board.rightIndicator.enable();
			board.greenLed.enable();
			board.redLed.enable();
		}
		disable = ! disable;
	}
}

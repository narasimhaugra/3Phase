/**
 * @file gateway_ping_test.cpp
 *
 * This program is used to test communication between a gateway and a router,
 * without using node-shell. The node board hosting this program would be
 * a gateway which would keep sending a simpleterm packet "get voltage" to a
 * router on address 1.2.3.4. If the router responds back with the voltage, then the
 * gateway would print the voltage on the LCD. The router is an ordinary node board
 * running the standard node_fw firmware.
 *
 * As of now, network 18, channel 5 is used. Note that by default, a RC module is
 * configured as a router. Once you burn this program in the Node, you would have to
 * configure it as a gateway. This can be done either by sending the character 'n'
 * on the IrDA port or by pressing the scroll button.
 *
 * This script can also be used to count the number of packets received. For example,
 * if the character 'r' is sent on the IrDA port, the gateway sends 20 simpleterm
 * packets to the router; and counts the number of received packets.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "../board_node_1_3.h"
#include "base_apps/net/mailbox/letter.h"
#include "gpos/utils/buffer/buffer.h"
#include "base_apps/net/tapframe/tapframe_interface.h"
#include "gpos/utils/serialize/serialize.h"

BoardNode13 board;
TAPFrameInterface rfInterface(0, &(board.rfModule), &(board.systemTime));
uint8_t packetsSent = 0;
uint8_t packetsReceived = 0;


/**
 * Creates a simpleterm packet and with src address 1.2.3.4,
 * and destination address 4.3.2.1. The simpleterm payload
 * is "get voltage". This function is called every 3 seconds in the while(1) loop
 * in main function
 */
void ping()
{
	Letter letter;
	letter.destAddr = 0x04030201;
	letter.srcAddr = 0x01020304;
	letter.srcPort = 4;
	letter.destPort = 4;

	uint8_t payload[42] = "get voltage";
	payload[11] = '\0';
	letter.payload.copyFrom((uint8_t*)(payload), 12);

	StaticBuffer<uint8_t, INTERFACE_MAX_PAYLOAD_LENGTH> buffer;
	letter.writeToSerialStream(buffer);
	rfInterface.sendFrame(buffer);
}

/**
 * This function is continuously called in the while loop. If a new packet  containing
 * voltage measured by router is received, then it is printed on the LCD screen
 */
void recv()
{
	Letter letter;
	StaticBuffer<uint8_t, INTERFACE_MAX_PAYLOAD_LENGTH> buffer;
	while (rfInterface.recvFrame(buffer))
	{
		letter.initFromSerialStream(buffer, rfInterface.getId());
		if ((letter.destAddr == 0x01020304))
		{
			uint8_t payload[42];
			letter.payload.copyTo(payload, 42);
			uint32_t voltage;
			deserialize_uint32_t(&voltage, payload, MAX_PAYLOAD_SIZE, 0);
			packetsReceived++;
			board.energyMeterLcd.displayVoltage(voltage);
		}
	}

}

int main(void)
{
	board.lcdBacklight.turnOn();
	StopWatch startupDelayTimer(&(board.systemTime));
	startupDelayTimer.delay(500);

	board.rfModule.setSystemId(18);
	board.rfModule.setChannel(5);
	board.rfModule.exitConfigMode();
	board.energyMeterLcd.clearAll();

	StopWatch updateTimer(&(board.systemTime));
	push_button_status_t buttonStatus = board.scrollButton.getStatus();

	while(1)
	{
		board.update();
		rfInterface.update();
		recv();

		uint8_t byte = '\0';
		board.irModule.recv(&byte);
		push_button_status_t currentButtonStatus = board.scrollButton.getStatus();
		if (((currentButtonStatus == pressed) && (buttonStatus == released)) ||
				(byte == 'n'))
		{
			board.redLed.turnOff();
			board.greenLed.turnOn();
			if (currentButtonStatus == pressed)
			{
				buttonStatus = pressed;
			}

			updateTimer.reset();
			packetsSent = 0;
			packetsReceived = 0;
			board.rfModule.setNodeType(gateway);
			board.rfModule.exitConfigMode();
			board.energyMeterLcd.clearAll();
		}
		else if (currentButtonStatus == released)
		{
			board.greenLed.turnOff();
			board.redLed.turnOn();
			buttonStatus = released;
		}


		if(byte == 'r')
		{
			updateTimer.reset();
			packetsSent = 0;
			packetsReceived = 0;
		}
		if(packetsSent <= 20)
		{
			if(updateTimer.getElapsedMilliSec() > 3000)
			{
				ping();
				//board.energyMeterLcd.displaySmallSegmentInteger(packetsSent);
				//board.energyMeterLcd.displayInteger(packetsReceived);
				packetsSent++;
				updateTimer.reset();
			}
		}
	}

	return 0;
}

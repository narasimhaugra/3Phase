/**
 * @file tapframe_interface.h
 * Communication interface using TAPFrame protocol over a serial device.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef TAPFRAME_INTERFACE_H_
#define TAPFRAME_INTERFACE_H_

// TODO: Make this timeout dynamic with the baud rate of the serial device
#define TAPFRAME_RECEIVE_TIMEOUT_MS 500

#include "gpos/utils/interface/interface.h"
#include "tapframe_parser.h"
#include "gpos/hardware/components/serial_device/serial_device.h"
#include "gpos/utils/buffer/buffer.h"
#include "gpos/utils/crc/software_crc.h"
#include "gpos/utils/time/mytime.h"
#include "gpos/utils/time/stop_watch.h"


/**
 * Communication interface which parses an incoming serial stream into TAP
 * frames.
 */
class TAPFrameInterface: public Interface
{
protected:
	SerialDevice *_serialDevice;  /* Device on which to send an receive frames */
	StaticBuffer<uint8_t, INTERFACE_MAX_PAYLOAD_LENGTH> _txBuffer;
	StaticBuffer<uint8_t, INTERFACE_MAX_PAYLOAD_LENGTH> _rxBuffer;
	TAPFrameParser _parser;  /* Parser to interpret incoming bytes */
	bool _txBufferComplete;  /* Complete frame is present in tx buffer */
	bool _rxBufferComplete;  /* Complete frame is present in rx buffer */
	StopWatch _rxTimer;  /* Timer to detect receive timeout */

public:
	/**
	 * @param id_ indicates whether the id of the Interface (either IrDA or RC as of now)
	 * @param serialDevice_ is pointer to IrDA or RC11XX module
	 * @param systemTime_ is used to maintain timeouts while parsing incoming TAP frames
	 */
	TAPFrameInterface(interface_t id_, SerialDevice *serialDevice_, MyTime *systemTime_);

	/**
	 * This function is non blocking. The frame is simply copied to the _txBuffer,
	 * which eventually is sent on the serial device in the update() function
	 *
	 * @param frame is the reference to the TAP frame to be sent.
	 * @return true if the frame would be sent on the serial device; false otherwise
	 */
	bool sendFrame(Buffer<uint8_t> &frame);

	/**
	 * @param frame is populated with a new TAP frame (if available)
	 * @return true if a new frame was indeed received
	 */
	bool recvFrame(Buffer<uint8_t> &frame);

	/**
	 * @return true if the TX buffer is not full
	 */
	bool writable();

	/**
	 * @return true if a new frame has been received which has not been read yet.
	 */
	bool readable();

	/**
	 * If there is a frame to be transmitted, this function transmits it to the serial device.
	 * Also, this function keeps reading incoming bytes, and parses it to create a new incoming TAP frame.
	 * This function is called in the environment's update loop
	 */
	void update();
};


#endif /* TAPFRAME_INTERFACE_H_ */

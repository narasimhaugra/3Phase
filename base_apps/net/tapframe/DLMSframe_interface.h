/**
 * @file DLMSframe_interface.h
 * Communication interface using dlms protocol over a serial device.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2016 Gram Power, Inc.
 */

#ifndef DLMS_INTERFACE_H_
#define DLMS_INTERFACE_H_

#include "gpos/utils/interface/interface.h"
#include "gpos/hardware/components/serial_device/serial_device.h"
#include "gpos/utils/buffer/buffer.h"
#include "gpos/utils/time/mytime.h"
#include "gpos/utils/time/stop_watch.h"
#include "tapframe_interface.h"

#define DLMS_RECEIVE_TIMEOUT_MS 10000
#define TAP_TYPE    0x55
#define DLMS_TYPE   0xFF-TAP_TYPE

/**
 * Communication interface which parses an incoming serial stream into HDLC 
 * frames for dlms protocol.
 */
class DLMSFrameInterface : public TAPFrameInterface
{
private:
    uint8_t interfaceProtocol;

public:

	/**
	 * @param id_ indicates whether the id of the Interface (either IrDA or RC as of now)
	 * @param serialDevice_ is pointer to IrDA or RC11XX module
	 * @param systemTime_ is used to maintain timeouts 
	 */
	DLMSFrameInterface(interface_t id_, SerialDevice *serialDevice_, MyTime *systemTime_);

    /**
	 * @param Protocol indicate which communication protocol to apply - dlms or TAP
	 */
    bool ChangeOverProtocol(uint8_t Protocol);

    /**
	 * returns current running communication protocol - dlms or TAP
	 */
    uint8_t GetProtocol(void);

	/**
	 * If there is a frame to be transmitted, this function transmits it to the serial device.
	 * If there is a frame to be received, this function receives it from the serial device.
	 * This function is called in the environment's update loop
	 */
	void update();
};


#endif /* DLMS_INTERFACE_H_*/

/**
 * @file DLMSframe_interface.cpp
 * Communication interface using dlms protocol over a serial device.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2016 Gram Power, Inc.
 */

#include "DLMSframe_interface.h"
#include "gpos/hardware/boards/node_1_3/board_node_1_3.h"
#include "gpos/utils/serialize/serialize.h"

DLMSFrameInterface :: DLMSFrameInterface(interface_t id_, SerialDevice *serialDevice_, MyTime *systemTime_)
    : TAPFrameInterface(id_, serialDevice_, systemTime_) 
{
    interfaceProtocol = DLMS_TYPE;
}

void DLMSFrameInterface :: update()
{
    if (TAP_TYPE == interfaceProtocol)
    {
        TAPFrameInterface :: update();
        return;
    }
    
    // ------------------------------
    // Transmit txBuffer to UART port
    // ------------------------------

    if ( _txBufferComplete && ( _serialDevice->numBytesWriteable() >= _txBuffer.length()) )
    {
        /* Send payload */
        uint8_t byte;
        
        for (uint16_t i = 0; _txBuffer.read(&byte, i); i++)
        {
            _serialDevice->send(byte);
        }

        /*Clear buffer for next transmission*/
        _txBuffer.clear();
        _txBufferComplete = false;
    }

    // ----------------------------------------------------------
    // Look for frames in the incoming byte stream from UART port
    // ----------------------------------------------------------

    uint8_t byte;
    bool isRxData = false;
    
    while (!_rxBufferComplete)
    {
        if (_serialDevice->recv(&byte)) 
        {
            isRxData = true;

            _rxBuffer.push(byte);
        }
        else
        {
            _rxBufferComplete = isRxData;
            break;
        }
    }

    _rxTimer.reset();
}

bool DLMSFrameInterface :: ChangeOverProtocol(uint8_t Protocol)
{
    interfaceProtocol = Protocol;
    
    return true;
}

uint8_t DLMSFrameInterface :: GetProtocol(void)
{
    return interfaceProtocol;
}

/*---------------------------------------------------------------------------
 *  End of file
 *---------------------------------------------------------------------------*/

/**
 * @file tapframe_interface.cpp
 * Communication interface using TAPFrame protocol over a serial device.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "tapframe_interface.h"
#include "gpos/hardware/boards/node_1_3/board_node_1_3.h"
#include "gpos/utils/serialize/serialize.h"

TAPFrameInterface::TAPFrameInterface(interface_t id_, SerialDevice *serialDevice_, MyTime *systemTime_)
	: _parser(_rxBuffer),
	  _txBufferComplete(false),
	  _rxBufferComplete(false),
	  _rxTimer(systemTime_)
{
	_id = id_;
	_serialDevice = serialDevice_;
}


bool TAPFrameInterface::sendFrame(Buffer<uint8_t> &frame)
{
	Buffer<uint8_t> *txBufferRef = &_txBuffer;
	if (! _txBufferComplete)
	{
		*txBufferRef = frame;
		_txBufferComplete = true;
		return true;
	}
	else
	{
		return false;
	}
}


bool TAPFrameInterface::recvFrame(Buffer<uint8_t> &frame)
{
	if (_rxBufferComplete)
	{
		frame = _rxBuffer;
		_parser.reset();
		_rxBufferComplete = false;
		return true;
	}
	else
	{
		return false;
	}
}


bool TAPFrameInterface::writable()
{
	/* If the TX buffer is full then we can't accept any more frames */
	return ! _txBufferComplete;
}


bool TAPFrameInterface::readable()
{
	return _rxBufferComplete;
}


void TAPFrameInterface::update()
{
	/* Transmit txBuffer if it's full */
	/* TODO: Make inverse of parser (formatter) to do this work */
	if (_txBufferComplete &&
			(_serialDevice->numBytesWriteable() >= (_txBuffer.length() + TAPFRAME_HEADER_SIZE)))
	{
		/* Used to store packet without start byte and stop CRC,used for calculating CRC*/
		uint8_t temp_packet[86];

		/* Send start byte */
		_serialDevice->send(TAPFRAME_START_BYTE);

		/* Send payload */
		uint8_t byte;
		for (uint16_t i = 0; _txBuffer.read(&byte, i); i++)
		{
			_serialDevice->send(byte);
			temp_packet[i] = byte;
		}

		uint16_t _crc = 0;
		/**
		 * The CRC module can properly work only for even no of bytes
		 * If the total frame length is odd,then frame length is made
		 * even by adding a zero.
		 */
		if(_txBuffer.length()%2 != 0)
		{
			temp_packet[_txBuffer.length()] = 0;
			_crc = CRC_Module::getCheckValue(temp_packet, _txBuffer.length() + 1);
		}
		else
		{
			_crc = CRC_Module::getCheckValue(temp_packet, _txBuffer.length());
		}

		/*Send MSB of CRC*/
		_serialDevice->send((uint8_t)(((_crc) & 0xFF00) >> 8) & 0xFF);

		/*Send LSB of CRC*/
		_serialDevice->send((uint8_t)((_crc) & 0x00FF));

		/*Clear buffer for next transmission*/
		_txBuffer.clear();
		_txBufferComplete = false;
	}

	/* Look for frames in the incoming byte stream */
	uint8_t byte;
	while ((! _rxBufferComplete) && _serialDevice->recv(&byte))
	{
		uint8_t frameWasInProgress = _parser.frameInProgress();
		_parser.accumulate(byte);

		/* When the parser begins accumulating a prospective frame, start the
		 * receive timer
		 */
		if ((! frameWasInProgress) && _parser.frameInProgress())
		{
			_rxTimer.reset();
		}
		if (_parser.frameComplete())
		{
			_rxBufferComplete = true;
		}
	}

	/* If we have been process a prospective frame for too long (timeout
	 * condition), reset the RX parser
	 */
	if (_rxTimer.getElapsedMilliSec() > TAPFRAME_RECEIVE_TIMEOUT_MS)
	{
		_parser.reset();
	}
}

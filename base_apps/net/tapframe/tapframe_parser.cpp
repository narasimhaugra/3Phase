/**
 * tapframe_parser.cpp
 * Parser which searches for valid TAP Frames in a stream of bytes.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "tapframe_parser.h"
#include "gpos/hardware/boards/node_1_3/board_node_1_3.h"

TAPFrameParser::TAPFrameParser(Buffer<uint8_t> &buffer)
	: _buffer(buffer),
	  _startByteReceived(false),
	  _stopByteReceived(false)
{
}


bool TAPFrameParser::accumulate(uint8_t byte)
{
	/* If a complete frame is held in the buffer, we don't allow another
	 * frame to be accumulated until the current one is cleared
	 */
	if (_stopByteReceived)
	{
		return false;
	}

	uint8_t frameLength;

	/* First, look for the start byte */
	if (! _startByteReceived)
	{
		if (byte == TAPFRAME_START_BYTE)
		{
			_startByteReceived = true;
		}
	}

	/* Next, look for stop byte(matching CRC) if it's time */
	else if ((_buffer.read(&frameLength, TAPFRAME_FRAME_LEN_BYTE_POS)) &&
				(_buffer.length() == (11 + frameLength + 1)))
	{
		uint16_t crcInFrame_ = 0;
		uint8_t temp=0;
		_buffer.read(&temp, 11 + frameLength);
		crcInFrame_ = uint16_t(256*temp + byte);
		uint8_t temp_packet[86];

		for(int i = 0;i< 11 + frameLength;i++)
		{
			_buffer.read(&temp_packet[i], i);
		}

		_buffer.clear();
		_buffer.copyFrom(temp_packet, 11 + frameLength);

		uint16_t _crcComputed = 0;
		/**
		 * The CRC module can properly work only for even no of bytes
		 * If the total frame length is odd,then frame length is made
		 * even by adding a zero.
		 */
		if((11 + frameLength) % 2 != 0)
		{
			temp_packet[11 + frameLength] = 0;
			_crcComputed = CRC_Module::getCheckValue(temp_packet, 11 + frameLength + 1);
		}
		else
		{
			_crcComputed = CRC_Module::getCheckValue(temp_packet, 11 + frameLength);
		}

		/** If the CRC is proper, the frame is complete and accepted else
		 *  it is rejected
		 */
		if (crcInFrame_ == _crcComputed)
		{
			_stopByteReceived = true;
		}
		else
		{
			reset();
		}
	}

	/* Otherwise, this is just part of the packet; put it into the
	 * buffer */
	else
	{
		/* If the buffer is full, something is wrong; reset */
		if (! _buffer.push(byte))
		{
			reset();
		}
	}

	return true;
}


void TAPFrameParser::reset()
{
	_buffer.clear();
	_startByteReceived = false;
	_stopByteReceived = false;
}


bool TAPFrameParser::frameInProgress()
{
	return _startByteReceived;
}


bool TAPFrameParser::frameComplete()
{
	return _stopByteReceived;
}

/**
 * tapframe_parser.h
 * Parser which searches for valid TAP Frames in a stream of bytes.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef TAPFRAME_PARSER_H_
#define TAPFRAME_PARSER_H_

#define TAPFRAME_HEADER_SIZE 2
#define TAPFRAME_FRAME_LEN_BYTE_POS 10
#define TAPFRAME_START_BYTE 0xAA
#define TAPFRAME_STOP_BYTE 0x55

#include "gpos/utils/buffer/buffer.h"
#include "gpos/utils/interface/parser.h"


class TAPFrameParser: public Parser
{
private:
	Buffer<uint8_t> &_buffer;

	/** Is set true when the start byte of the current TAP frame has been received.
	 * Is set false once an entire packet has been successfully parsed and parser
	 * is not waiting to parse the next packet
	 */
	bool _startByteReceived;

	/**
	 * Is set true when the stop byte has been received (which marks a successful parse of
	 * the current TAP frame). Is set false just after that.
	 */
	bool _stopByteReceived;

public:
	/**
	 * @param buffer is the reference to the rxBuffer
	 */
	TAPFrameParser(Buffer<uint8_t> &buffer);

	/**
	 * Adds the byte to the buffer associated with this parser,
	 * and also ensures that the value of the byte is as expected by the TAP frame structure
	 *
	 * @param false if adding the byte to _buffer failed because of unexpected value of byte
	 */
	bool accumulate(uint8_t byte);

	/**
	 * Resets the parsing. ie, now, the parser would expect a start byte in the accumulate() function
	 */
	void reset();

	/**
	 * @return true if a packet is in the middle of being parsed; ie, a few bytes have been
	 * received, but the entire frame has not been received
	 */
	bool frameInProgress();

	/**
	 * @return true if a complete TAP frame has been received successfully
	 */
	bool frameComplete();
};


#endif /* TAPFRAME_PARSER_H_ */

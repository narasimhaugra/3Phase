#ifndef LETTER_H
#define LETTER_H

#include <stdint.h>
#include "gpos/utils/buffer/buffer.h"

typedef uint8_t port_t;
typedef uint32_t address_t;
typedef uint8_t interface_t;

#define MAX_PAYLOAD_SIZE 90
//#define MAX_PAYLOAD_SIZE_1 42
#define HEADER_SIZE 11

/**
 * A Letter is equivalent to a TAP packet, except that the 'interface'
 * field is added to the Letter (which indicates the physical interface
 * (IrDA or RC11XX) from where the letter has been received or is to be sent)
 *
 * The length field in the TAP packet can be inferred from 'payload.length()' function
 */
class Letter
{
private:
	void _clear()
	{
		srcAddr = 0;
		destAddr = 0;
		srcPort = 0;
		destPort = 0;
		interface = 0;
		payload.clear();
	}

public:
	Letter()
		: srcAddr(0),
		  destAddr(0),
		  srcPort(0),
		  destPort(0),
		  interface(0)
	{
	}

	/** to chose from RF, IrDA etc */
	interface_t interface;

	/** the address of the device (another meter on the network)
	 *  from where this letter is be posted. Filled by the PostOffice */
	address_t srcAddr;

	/** the address of the destination device */
	address_t destAddr;

	/** the address of the mailbox where this letter is posted from.
	 *  Filled by MailBox */
	port_t srcPort;

	/** the address of the mailbox where this letter is meant to reach */
	port_t destPort;

	/** This, my friend, is the real content of the letter. Confidential! */
	StaticBuffer<uint8_t, MAX_PAYLOAD_SIZE> payload;

	/**
	 * @param buffer is the serialized representation of the TAP packet which is used
	 * to fill in the member variables of the Letter
	 *
	 * @param interface_ is needed because a TAP packet does not have information
	 * of the interface.
	 */
	bool initFromSerialStream(Buffer<uint8_t> &buffer, interface_t interface_)
	{
		uint8_t payloadLength = 0;

		BytestreamParser parser(buffer);
		if (parser.getUint32(&srcAddr) &&
			parser.getUint32(&destAddr) &&
			parser.getUint8(&srcPort) &&
			parser.getUint8(&destPort) &&
			parser.getUint8(&payloadLength) &&
			parser.bytesRemaining() == payloadLength &&
			parser.getBuffer(payload, payloadLength))
		{
			interface = interface_;
			return true;
		}
		else
		{
			_clear();
			return false;
		}
	}


	/**
	 * @param buffer is populated with the serialised version of the Letter. ie, the contents
	 * of the letter are converted to the serialised representation of a TAP packet
	 *
	 * @return true if the serialization was successful; false otherwise
	 */
	bool writeToSerialStream(Buffer<uint8_t> &buffer)
	{
		BytestreamFormatter formatter(buffer);
		return formatter.putUint32(srcAddr) &&
				formatter.putUint32(destAddr) &&
				formatter.putUint8(srcPort) &&
				formatter.putUint8(destPort) &&
				formatter.putUint8(payload.length()) &&
				formatter.putBuffer(payload);
	}


	/**
	 * When "=" operator is used, copy one letter to another.
	 */
	Letter & operator=(const Letter &letter)
	{
		this->srcPort = letter.srcPort;
		this->srcAddr = letter.srcAddr;
		this->destPort = letter.destPort;
		this->destAddr = letter.destAddr;
		this->interface = letter.interface;
		this->payload = letter.payload;

		return *this;
	}
};

#endif

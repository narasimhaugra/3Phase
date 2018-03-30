/*
 * mailbox.h
 */

#ifndef MAILBOX_H_
#define MAILBOX_H_

#include <stdint.h>
#include "letter.h"

/**
 * Every application has a mailbox where they can post letter and receive letters.
 * As of now, every letter can contain space for only two letters (one to be sent and one to be received);
 */
class Mailbox
{
private:
	/** the port number of this mailbox */
	port_t _myPort;
	bool _txLetterIsNew;
	bool _rxLetterIsNew;
	//Letter _txLetter;
	//Letter _rxLetter;
public:
	Mailbox();

	/**
	 * Supposed to be called by Protocol Applications
	 *
	 * @return false if another mailbox exists with the same port number
	 */
	bool open(port_t myPort_);

	/**
	 * Usually not called.
	 *
	 * Makes the port number associated with this mailbox available to be reused
	 */
	void close();

	/**
	 * Supposed to be called by Protocol Applications
	 *
	 * @param letter is the reference to a Letter whose contents are to be sent on the serial port
	 * @param true if sending the letter succeeded; false otherwise
	 */
	bool sendLetter();

	/**
	 * Supposed to be called by Protocol Applications
	 *
	 * @param letter is reference to a Letter which would be populated with the incoming letter
	 * @param true if a new letter is available to be read by the application
	 */
	bool recvLetter();

	/**
	 * Supposed to be called by NetApp
	 *
	 * @param is the reference to a letter which would be filled with content to be
	 * sent on the serial device
	 * @return true if a new letter was indeed available to be sent on the serial device.
	 */
	bool getOutgoingLetter();

	/**
	 * Supposed to be called by NetApp
	 *
	 * @return true if a new letter is available to be sent on the serial device
	 */
	bool outgoingLetterAvailable();

	/**
	 * Supposed to be called by NetApp
	 *
	 * @return the interface ID of the outgoing letter (to tell whether the letter
	 * is to be sent to the IrDA or RC11XX port.
	 */
	//interface_t getOutgoingLetterInterface();

	/**
	 * Supposed to be called by NetApp
	 *
	 * @return true if the previous rxLetter had been read & hence, this letter
	 * was successfully added to the mailbox.
	 */
	bool putIncomingLetter();

	/**
	 * Supposed to be called by NetApp
	 *
	 * @return true if rxLetter has been read
	 */
	bool canAcceptIncomingLetter();

	/**
	 * Supposed to be called by NetApp
	 *
	 * Returns the TAP port number associated with this mailbox
	 */
	port_t getPort();
};

#endif /* MAILBOX_H */

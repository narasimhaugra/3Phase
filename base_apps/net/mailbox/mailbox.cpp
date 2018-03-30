#include "mailbox.h"

Mailbox::Mailbox()
	: _myPort(0),
	  _txLetterIsNew(false),
	  _rxLetterIsNew(false)
{
}

/** Returns false if another mailbox exists with the same port number */
/** TODO: Implement return functionality */
bool Mailbox::open(port_t myPort_)
{
	_myPort = myPort_;
	return true;
}

bool Mailbox::sendLetter()
{
	if (_txLetterIsNew)
	{
		return false;
	}
	_txLetterIsNew = true;

	return true;
}


bool Mailbox::recvLetter()
{
	if (!_rxLetterIsNew)
	{
		return false;
	}
	_rxLetterIsNew = false;

	return true;
}


bool Mailbox::getOutgoingLetter()
{
	if (!_txLetterIsNew)
	{
		return false;
	}

	_txLetterIsNew = false;
	return true;
}

bool Mailbox::outgoingLetterAvailable()
{
	return _txLetterIsNew;
}


bool Mailbox::putIncomingLetter()
{
	if (_rxLetterIsNew)
	{
		return false;
	}
	_rxLetterIsNew = true;
	return true;
}

bool Mailbox::canAcceptIncomingLetter()
{
	return ! _rxLetterIsNew;
}

port_t Mailbox::getPort()
{
	return _myPort;
}

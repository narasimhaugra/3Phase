/**
 * @file net_app.h
 * Hub which delivers packets between mailboxes and interfaces.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NET_APP_H_
#define NET_APP_H_

#define MAX_NUM_INTERFACES 3
#define MAX_NUM_MAILBOXES 6

#include "net_api.h"
#include "base_apps/net/mailbox/mailbox.h"
#include "gpos/utils/interface/interface.h"
#include "base_apps/nvm_controller/nvm_accessor.h"

#define BROADCAST_OCTET 0xFF


APP(NetApp, Net_API)
private:

	struct nvm_struct
	{
		/**
		 * TAP address of this node
		 */
		address_t myAddr;
	} _nvm;

	NVM_Accessor _nvmAccessor;

	/**
	 * Checks the port number of the input letter and adds it to the appropriate mailbox.
	 * If there is no registered mailbox with the same port number as that of the input letter,
	 * then the input letter gets dropped
	 *
	 * @param letter is the letter which is to be delivered to the appropriate mailbox
	 */
	void _deliverLetter();

	/**
	 * Cyclic iterator is used for mailbox prioritization to ensure that no single
	 * application gets a preference for sending packets on any interface. Refer to
	 * Net_App.pdf for more details
	 */
	//CyclicIterator<Mailbox *> _mailboxIterators[MAX_NUM_INTERFACES];

	/**
	 * List of all registered mailboxes
	 */
	//StaticBuffer<Mailbox*, MAX_NUM_MAILBOXES> _mailboxes;

	/**
	 * List of all registered interfaces
	 */
	//StaticBuffer<Interface*, MAX_NUM_INTERFACES> _interfaces;

	Letter _txLetter;
	Letter _rxLetter;

	Interface * _interfacesArrayPtr[MAX_NUM_INTERFACES];
	Mailbox   * _mailboxesArrayPtr[MAX_NUM_MAILBOXES];

public:

	/**
	 * Tries to add the add the given interface to an internal list of
	 * registered interfaces.
	 *
	 * @return true if adding interface is successful; false otherwise
	 */
	bool addInterface(Interface *interface_);

	/**
	 * Tries to add the add the given mailbox to an internal list of
	 * registered mailboxes.
	 *
	 * @return true if adding mailbox is successful; false otherwise
	 */
	bool addMailBox(Mailbox* mailbox_);

	/**
	 * Returns the previously set address. This function DOES NOT
	 * access RC11XX to get the address of the device.
	 *
	 * @return previously set address
	 *
	 */
	address_t address();

	/**
	 * Sets the given address by update _nvm variable.
	 * Also changes the unique address in the RC11XX device to given argument
	 *
	 * @address is the address of the node.
	 */
	void setAddress(address_t address);

	Letter & getTxLetterPtr();
	Letter & getRxLetterPtr();

	void updateAddress();
ENDAPP


#endif  /** NET_APP_H_ */

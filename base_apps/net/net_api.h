/**
 * @file net_api.h
 * Hub which delivers packets between mailboxes and interfaces.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NET_API_H_
#define NET_API_H_

#include "gpos/application.h"
#include "gpos/utils/interface/interface.h"
#include "base_apps/net/mailbox/mailbox.h"


APP_API(Net_API)
//	virtual void init(address_t myAddr) = 0;
	virtual bool addInterface(Interface *interface_) = 0;
	virtual bool addMailBox(Mailbox* mailbox_) = 0;
	virtual address_t address() = 0;
	virtual void setAddress(address_t address) = 0;
	//virtual void update() = 0;
ENDAPP_API


#endif  /** NET_API_H_ */

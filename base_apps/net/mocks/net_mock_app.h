/**
 * @file net_mock_app.h
 * Mock (gmock) of net app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NET_MOCK_APP_H_
#define NET_MOCK_APP_H_

#include "gmock/gmock.h"
#include "../net_api.h"



class NetMockApp : Net_API
{

public:
    // MOCK METHODS GO HERE
  MOCK_METHOD0(update, void());
	MOCK_METHOD1(addInterface, bool(Interface *interface_));
	MOCK_METHOD1(addMailBox, bool(Mailbox* mailbox_));
	MOCK_METHOD0(address, address_t());
	MOCK_METHOD1(setAddress, void(address_t address));
};


#endif  /** NET_MOCK_APP_H_ */

/**
 * @file net_app.cpp
 * Hub which delivers packets between mailboxes and interfaces.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "net_app.h"
#include "environment.h"


CONSTRUCT(NetApp)
    , _nvmAccessor(&_nvm, sizeof(_nvm))
{
    env->nvmController.registerAccessor(&_nvmAccessor);
    
    uint8_t i;
    
    for ( i = 0; i < MAX_NUM_INTERFACES; i++ )
    {
        _interfacesArrayPtr[i] = NULL;
    }
    
    for ( i = 0; i < MAX_NUM_MAILBOXES; i++ )
    {
        _mailboxesArrayPtr[i] = NULL;
    }
}

/**
 * Iterates through all registered interfaces and checks for outgoing and incoming letters
 * on this interface. Sends off outgoing letters on the appropriate interface, and converts
 * incoming buffer frames into letters and delivers the letters to appropriate mailboxes.
 */
void NetApp::update()
{
    Interface *currentInterface;
    Mailbox *currentMailbox;
    StaticBuffer<uint8_t, INTERFACE_MAX_PAYLOAD_LENGTH> buffer;
    //Letter letter;

    for (uint16_t i = 0; i < MAX_NUM_INTERFACES; i++)
    {
        // Receive letters
        //_interfaces.read(&currentInterface, i);
        currentInterface = _interfacesArrayPtr[i];

        if (currentInterface != NULL)
        {
            if (currentInterface->readable())
            {
                while (currentInterface->recvFrame(buffer))
                {
                    if (currentInterface->GetProtocol() != DLMS_TYPE)
                    {
                        _rxLetter.initFromSerialStream(buffer, currentInterface->getId());
                        if ((_rxLetter.destAddr == _nvm.myAddr) || ((_rxLetter.destAddr & 0xFF) == BROADCAST_OCTET))
                        {
                            env->health.resetProtocolConter();
                            _deliverLetter();
                        }
                    }
                    else
                    {
                        _rxLetter.interface = 1;
                        _rxLetter.destAddr = 0;
                        _rxLetter.destPort = 11;  // send to dlms_server_app only

                        _rxLetter.payload.clear();
                        uint8_t byte;
                        uint16_t i = 0;
                        while (buffer.read(&byte, i))
                        {
                            _rxLetter.payload.push(byte);
                            i++;
                        }
                        _deliverLetter();
                    }
                }
            }
            // Send letters
            uint8_t mailbox_index = 0;
            while (currentInterface->writable() && _mailboxesArrayPtr[mailbox_index])
            {
                currentMailbox = _mailboxesArrayPtr[mailbox_index];
                if (_txLetter.interface == currentInterface->getId()
                        && currentMailbox->outgoingLetterAvailable())
                {
                    currentMailbox->getOutgoingLetter();
                    if (currentInterface->GetProtocol() != DLMS_TYPE)
                    {
                        _txLetter.writeToSerialStream(buffer);
                    }
                    else
                    {
                        uint8_t byte;
                        uint16_t i = 0;
                        buffer.clear();
                        while (_txLetter.payload.read(&byte, i))
                        {
                            buffer.push(byte);
                            i++;
                        }
                    }
                    currentInterface->sendFrame(buffer);
                }
                mailbox_index++;
            }
        }
    }
}


bool NetApp::addMailBox(Mailbox* mailbox_)
{
    uint8_t i = 0;
    for (i = 0; i < MAX_NUM_MAILBOXES; i++)
    {
        if (NULL == _mailboxesArrayPtr[i])
        {
            _mailboxesArrayPtr[i] = mailbox_;
            return true;
        }
    }
    if (MAX_NUM_MAILBOXES <= i)
    {
        return false;
    }
    return false;
}


bool NetApp::addInterface(Interface* interface_)
{
    uint8_t i = 0;
    for (i = 0; i < MAX_NUM_INTERFACES; i++)
    {
        if (NULL == _interfacesArrayPtr[i])
        {
            _interfacesArrayPtr[i] = interface_;
            return true;
        }
    }
    if (MAX_NUM_INTERFACES <= i)
    {
        return false;
    }
    return false;
}


address_t NetApp::address()
{
    return _nvm.myAddr;
}


void NetApp::setAddress(address_t address)
{
    //env->board.rfModule.set(set_uniqueId,(uint32_t)address);
    //env->board.rfModule.exitConfigMode();
    _nvm.myAddr = address;
    _nvmAccessor.markDirty();
}


void NetApp::_deliverLetter()
{

    uint8_t i = 0;
    while (_mailboxesArrayPtr[i])
    {
        if (_mailboxesArrayPtr[i]->getPort() == _rxLetter.destPort)
        {
            _mailboxesArrayPtr[i]->putIncomingLetter();
            break;
        }
        i++;
        if (MAX_NUM_MAILBOXES <= i)
        {
            break;
        }
    }
    i++;
}

Letter& NetApp::getTxLetterPtr()
{
    return _txLetter;
}

Letter& NetApp::getRxLetterPtr()
{
    return _rxLetter;
}
void NetApp::updateAddress()
{
    uint8_t buf[4];
    env->board.rfModule.get(45, buf, 4);
    uint32_t address = (uint32_t) (((uint32_t)buf[0]) << 0) |
                       (((uint32_t)buf[1]) << 8) |
                       (((uint32_t)buf[2]) << 16) |
                       (((uint32_t)buf[3]) << 24);
    env->board.rfModule.exitConfigMode();
    _nvm.myAddr = address;
    _nvmAccessor.markDirty();
}
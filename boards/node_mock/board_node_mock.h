#ifndef BOARD_NODE_MOCK_H
#define BOARD_NODE_MOCK_H

#include "gpos/hardware/boards/board.h"
#include "gpos/utils/utils.h"
#include "gpos/hardware/components/led/mocks/led_mock.h"
#include "gpos/hardware/components/simple_serial/mocks/simple_serial_mock.h"
#include "gpos/hardware/components/radio/mocks/rc11xx_mock.h"
#include "gpos/hardware/microcontrollers/base/mocks/flash_mock.h"
#include "gpos/hardware/microcontrollers/base/mocks/crc_module_mock.h"
#include "gpos/hardware/components/relay/mocks/relay_mock.h"

class BoardNodeMock : public Board
{
public:
  LEDMock greenLed;
  SimpleSerialMock debugComm;
  RC11XXMock rfModule;
  RelayMock relay;
  base::FlashMock infoFlash;
  base::CRC_ModuleMock crcModule;

  MOCK_METHOD0(reset, void());
  MOCK_METHOD0(update, void());
  MOCK_METHOD0(_timerCallback, void());

	MyTime systemTime;
};

#endif

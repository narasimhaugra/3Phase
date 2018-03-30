/**
 * @file ext_NVM_handler.h
 * Handles data storage in external NVM.
 * This app acts as a bridge between the driver level and APP level
 * abstraction by providing cleaner API's to store data in external
 * NVM.The handler provides the following functions:
 *  1. RAM synchronisation
 *  2. Error detection
 *  3. Error correction
 *
 *  NOTE:
 *  Be aware that the flash is powered using main VCC
 *  hence any application that uses external NVM & runs
 *  even when node is powered using aux VCC should be
 *  cognizant about the fact that the external NVM write
 *  requests will be rejected if no power to flash.
 *
 *  @Author:Sudeep
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2015 Gram Power, Inc.
 */


#ifndef EXT_NVM_HANDLER_APP_H_
#define EXT_NVM_HANDLER_APP_H_

#include "ext_NVM_handler_api.h"
#include "gpos/utils/buffer/buffer.h"
#include "gpos/hardware/components/memory/flash_w25q80bv.h"
#include "gpos/hardware/microcontrollers/msp430f6733/crc_module.h"

//constant definitions
#define MAX_NO_STRUCT_REGISTRATIONS 5
//#define EXT_FLASH_STORAGE_START_ADDRESS 0x0ff000
#define EXT_FLASH_STORAGE_START_ADDRESS 0x6F000    //block 16 start
#define DUPLICATE_PAGE_RELATIVE_ADDRESS 4096        //note this page is in the next sector
#define NEXT_PAGE_RELATIVE_ADDRESS 256              // this page is the page next to the current page
#define PAGE_SIZE 256
#define CRC_START_OFFSET 580
#define MAX_MEMORY_SIZE 580
#define EXT_NVM_CRC_SIZE 2

APP(ExtNVMHandlerApp,ExtNVMHandler_API)

private:

//false if NVM is corrupt
bool _NVMvalid;

bool _NVMvalidated;

struct structHandler {
  uint16_t _offset;
  uint8_t _length;
  void* _ramAddress;
};

uint8_t _noOfRegistrations;

/**
 * This buffer is kind of resource manager which keeps account
 * of all the structs registered with ext_NVM_handler
 */
StaticBuffer< structHandler, MAX_NO_STRUCT_REGISTRATIONS> sHandler;

/**
 * The pointer for flash object.The pointer
 * is initialised in the constructor.
 */
Flash_W25Q80BV *flash;

/**
 * Shared flag
 */
bool _flashUpdateRequested;

/**
 * It validates the CRC of external flash storage section 1.
 * If the section 1 is corrupt it uses the redundant copy in
 * section 2 to initialise section 1.If both section 1 & section 2
 * are corrupt then it returns false.
 * @return:status of section 1
 */
bool validateFlashData();

/**
 * Updates the flash with the data in the registered structs.
 * The API should be called whenever anything needs to be saved
 * in the external NVM.
 */
void doFlashUpdate();

/**
 * This API loads everything from flash to the registered structs.
 * This acts as a helper function to regStruct() as this would load
 * contents of the flash to the registerd struct.
 * @param 1:start address of the struct
 * @param 2:relative address in external NVM
 * @param 3:length of data
 */
bool updateFromFlash(void *,uint16_t,uint8_t);

/**
 * Returns the absolute address from the offset.
 * @return:absolute address
 */
uint32_t getRealAddress(uint16_t);

public:

/**
 * Constructor
 * @param 1:pointer to Environment
 * @param 2:pointer to external flash
 */
ExtNVMHandlerApp(Environment *,Flash_W25Q80BV *);

/**
 * Registers a struct with the ext_NVM_handler
 * @param 1:The address of start of struct
 * @param 2:The length of struct
 * @return :True if successfully registered.
 */
bool regStruct(void *,uint8_t);

/**
 * Requests to update the flash in the coming update cycle.
 * @return:Currently returns true by default.
 *
 * TODO:Avoid frequent flash updates as it would reduce
 * the execution speed.Return false if update request is rejected
 */
bool requestFlashUpdate();

/**
 * Lets know to the external world if the APP is ready to be used
 * @return: true if read
 */
bool ready();

/**
 * Lets know the external world on flash sanity(corrupt or not)
 * @return: true if everything is fine.
 */
bool isFlashSane();

/**
 * This forces the app to assume that flash is valid even if it is not.
 * Mainly used for initialization purposes
 */
void forceNvmValid();

ENDAPP

#endif
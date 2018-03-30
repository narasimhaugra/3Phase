/**
 * @file ext_NVM_handler.cpp
 *
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */


#include "ext_NVM_handler_app.h"
#include "environment.h"


ExtNVMHandlerApp::ExtNVMHandlerApp(Environment *_env,Flash_W25Q80BV *fl)
:env(_env)
,flash(fl)
,_flashUpdateRequested(false)
,_NVMvalid(false)
,_NVMvalidated(false)
{
	//_NVMvalid = validateFlashData();
}


UPDATE(ExtNVMHandlerApp)
{
   if(!_NVMvalidated)
   {
	 if(ready())
	 {
       _NVMvalid = validateFlashData();

      //If the power went down during validation then
      //the validate() flash data would not yield correct result

        _NVMvalidated = true;
      }
   }
   else
   {

	   if(!_NVMvalid)
	   {
		 //APP_ASSERT(false);
		 //_NVMvalid = true;
		 //doFlashUpdate();
	   }

	   else if(_flashUpdateRequested)
	   {
		   //do update only if the flash is sane
		   if(ready())
		   {
			// env->logger.print("flash updating",14);
		     doFlashUpdate();
		     _flashUpdateRequested = false;
		   }
	   }
   }

}

bool ExtNVMHandlerApp::regStruct(void *address,uint8_t length)
{
	if(!_NVMvalid)
	{
	   return false;
	}
	structHandler temp;
	volatile uint16_t nextRelativeAddress_ = 0;

	//iterate to find the next address
	for(uint8_t i=0;sHandler.read(&temp,i);i++)
	{
		nextRelativeAddress_ = nextRelativeAddress_ + temp._length;
	}

	//Sanity to check weather the struct fits into memory
	if((nextRelativeAddress_ + length) > MAX_MEMORY_SIZE)
	{
//		APP_ASSERT(false);
		return false;      
	}

	temp._length = length;
	temp._offset = nextRelativeAddress_;
	temp._ramAddress = address;

	sHandler.push(temp);

	updateFromFlash(address,nextRelativeAddress_,length);

    _noOfRegistrations++;

   return true;
}

bool ExtNVMHandlerApp::requestFlashUpdate()
{
	_flashUpdateRequested = true;
	return true;
}

void ExtNVMHandlerApp::doFlashUpdate()
{
	structHandler temp_;
	uint8_t temp_buffer_[MAX_MEMORY_SIZE];
	uint16_t calculatedCRC_ = 0;

	flash->eraseSector(EXT_FLASH_STORAGE_START_ADDRESS);

    //used to store the total size of all extNvm structs
    uint16_t memory_size = 0;
    
	//iterate through sHandler and copy each struct inside a single array
	for(uint8_t i=0;sHandler.read(&temp_,i);i++)
	{
        for (uint8_t j=0;j<temp_._length;j++)
        {
            temp_buffer_[memory_size] = *((uint8_t *)temp_._ramAddress + j);
            memory_size++;
        }
	}

    //used to store the number of pages that need to be programmed
    uint8_t pageCount = MAX_MEMORY_SIZE/PAGE_SIZE;
    
    //program pages of full 256 bytes of data
    for (uint8_t i=0;i<pageCount;i++)
    {     
        flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + i * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + i * PAGE_SIZE,PAGE_SIZE);
    }
    
    //program additional remaining data, which is less than a page size
    if (pageCount%PAGE_SIZE)
    {
        flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + pageCount * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + pageCount * PAGE_SIZE,MAX_MEMORY_SIZE - pageCount * PAGE_SIZE);
    }
    
	//put CRC into section 1
    flash->readData(EXT_FLASH_STORAGE_START_ADDRESS,temp_buffer_,MAX_MEMORY_SIZE);
    calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);
	flash->programPage(getRealAddress(CRC_START_OFFSET),(uint8_t *)(&calculatedCRC_),EXT_NVM_CRC_SIZE);

    //if power went after the first write, then exit as storing the duplicate is point less.
	if(!ready())
	{
		return;
	}

	/**duplicate section handling**/
	flash->eraseSector(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS);

     memory_size = 0;
    
    //iterate through sHandler and copy each struct inside a single array
	for(uint8_t i=0;sHandler.read(&temp_,i);i++)
	{
        for (uint8_t j=0;j<temp_._length;j++)
        {
            temp_buffer_[memory_size] = *((uint8_t *)temp_._ramAddress + j);
            memory_size++;
        }
	}
    
    //program pages of full 256 bytes of data
    for (uint8_t i=0;i<pageCount;i++)
    {     
        flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + i * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + i * PAGE_SIZE,PAGE_SIZE);
    }
    
    //program additional remaining data, which is less than a page size
    if (pageCount%PAGE_SIZE)
    {
        flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + pageCount * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + pageCount * PAGE_SIZE,MAX_MEMORY_SIZE - pageCount * PAGE_SIZE);
    }
    
	flash->programPage(getRealAddress(CRC_START_OFFSET + DUPLICATE_PAGE_RELATIVE_ADDRESS),(uint8_t *)(&calculatedCRC_),EXT_NVM_CRC_SIZE);

	if(!validateFlashData())
	{
		_NVMvalid = false;
	}
}

bool ExtNVMHandlerApp::updateFromFlash(void* address,uint16_t relativeAddress_,uint8_t length)
{
    flash->readData(getRealAddress(relativeAddress_),(uint8_t*)address,length);
    return true;
}

uint32_t ExtNVMHandlerApp::getRealAddress(uint16_t offset)
{
    return (EXT_FLASH_STORAGE_START_ADDRESS + offset);
}

bool ExtNVMHandlerApp::validateFlashData()
{
   uint8_t temp_buffer_[MAX_MEMORY_SIZE];

   //represents the calculated CRC from NVM
   uint16_t calculatedCRC_ = 0;

   //copy of calculatedCRC_
   uint16_t crcCpy;

   //The CRC retrieved from NVM
   uint16_t CRCfromFlash;

   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS,temp_buffer_,MAX_MEMORY_SIZE);

   calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);

   crcCpy = calculatedCRC_;

   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS + MAX_MEMORY_SIZE,(uint8_t *)(&CRCfromFlash),EXT_NVM_CRC_SIZE);

   //section 1 corrupt
   if(CRCfromFlash != crcCpy)
   { 
	   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS,temp_buffer_,MAX_MEMORY_SIZE);
	   calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);
	   crcCpy = calculatedCRC_;
	   //retrieve CRC from flash section 2
	   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS + MAX_MEMORY_SIZE + DUPLICATE_PAGE_RELATIVE_ADDRESS,(uint8_t *)(&CRCfromFlash),
			                  EXT_NVM_CRC_SIZE);

	   //both sections are corrupt
	   if(CRCfromFlash != crcCpy)
	   {
		   _NVMvalid = false;
		   return false;
	   }
	   else
	   {
            //copy section 2 to section 1
            flash->eraseSector(EXT_FLASH_STORAGE_START_ADDRESS);
           
            //used to store the number of pages that need to be programmed
            uint8_t pageCount = MAX_MEMORY_SIZE/PAGE_SIZE;
    
            //program pages of full 256 bytes of data
            for (uint8_t i=0;i<pageCount;i++)
            {     
                flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + i * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + i * PAGE_SIZE,PAGE_SIZE);
                flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + i * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + i * PAGE_SIZE,PAGE_SIZE);
            }
    
            //program additional remaining data, which is less than a page size
            if (pageCount%PAGE_SIZE)
            {
                flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + pageCount * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + pageCount * PAGE_SIZE,MAX_MEMORY_SIZE - pageCount * PAGE_SIZE);
                flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + pageCount * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + pageCount * PAGE_SIZE,MAX_MEMORY_SIZE - pageCount * PAGE_SIZE);
            }
		         
           calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);
		   flash->programPage(getRealAddress(CRC_START_OFFSET),(uint8_t *)(&calculatedCRC_),EXT_NVM_CRC_SIZE);
		   flash->programPage(getRealAddress(CRC_START_OFFSET + DUPLICATE_PAGE_RELATIVE_ADDRESS),(uint8_t *)(&calculatedCRC_),EXT_NVM_CRC_SIZE);
	   }

   }

   //section 2 handling
   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS,temp_buffer_,MAX_MEMORY_SIZE);
   calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);
   crcCpy = calculatedCRC_;
   //retrieve CRC from flash section 2
   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS + MAX_MEMORY_SIZE + DUPLICATE_PAGE_RELATIVE_ADDRESS,(uint8_t *)(&CRCfromFlash),
		                  EXT_NVM_CRC_SIZE);
   //update section 2 if corrupt
   if(CRCfromFlash != crcCpy)
   { 
	   flash->readData(EXT_FLASH_STORAGE_START_ADDRESS,temp_buffer_,MAX_MEMORY_SIZE);
	   //copy section 1 to section 2
	   flash->eraseSector(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS);
	   
        //used to store the number of pages that need to be programmed
        uint8_t pageCount = MAX_MEMORY_SIZE/PAGE_SIZE;
    
        //program pages of full 256 bytes of data
        for (uint8_t i=0;i<pageCount;i++)
        {     
            flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + i * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + i * PAGE_SIZE,PAGE_SIZE);
        }
    
        //program additional remaining data, which is less than a page size
        if (pageCount%PAGE_SIZE)
        {
            flash->programPage(EXT_FLASH_STORAGE_START_ADDRESS + DUPLICATE_PAGE_RELATIVE_ADDRESS + pageCount * NEXT_PAGE_RELATIVE_ADDRESS,temp_buffer_ + pageCount * PAGE_SIZE,MAX_MEMORY_SIZE - pageCount * PAGE_SIZE);
        }
	   
       calculatedCRC_ = CRC_Module::getCheckValue(temp_buffer_,MAX_MEMORY_SIZE);
	   flash->programPage(getRealAddress(CRC_START_OFFSET + DUPLICATE_PAGE_RELATIVE_ADDRESS),(uint8_t *)(&calculatedCRC_),EXT_NVM_CRC_SIZE);
   }

   return true;
}

bool ExtNVMHandlerApp::ready()
{
  //do supply check for 20 cycles (200 * 20 samples)
  for(uint8_t i=0;i<20;i++)
  {
	if(!env->board.checkMainsSupply())
	{
		return false;
	}
  }
   return true;//(env->ndHandler.isStartUpCheckDone());
}

bool ExtNVMHandlerApp::isFlashSane()
{
   return _NVMvalid;
}

void ExtNVMHandlerApp::forceNvmValid()
{
  _NVMvalid = true;
  doFlashUpdate();
}
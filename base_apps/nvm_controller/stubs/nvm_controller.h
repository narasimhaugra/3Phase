#include <stdio.h>
#include <iostream>

//to have a intialization address
const static uint16_t fixed_val_location = 0;

    class nvmControllerStubApp
    {
      public:
      nvmControllerStubApp()
      :registerAccessor_i_1((NVM_Accessor *)&fixed_val_location)
      {
  
      }

      NVM_Accessor *registerAccessor_i_1;
      bool registerAccessor_o_1;
      bool registerAccessor(NVM_Accessor *_nvmAccesor)
      {
        registerAccessor_i_1 = _nvmAccesor; 
	    return registerAccessor_o_1;
      }
  


  };

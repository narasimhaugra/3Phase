

    class extNvmMockApp
    {
      public:
      void* regStruct_i_1;
      uint8_t regStruct_i_2;
      bool regStruct_o_1;
      //TODO:implementation incomplete(do when required)
      bool regStruct(void* address,uint8_t length)
      {
        return regStruct_o_1;
      }

      bool requestFlashUpdate_o_1;
      bool requestFlashUpdate()
      {
	    return requestFlashUpdate_o_1;
      }
    };

#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/boards/board.cpp"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/boards/board.h"



#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/irda/irda.h"



#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdint.h"
/*****************************************************************************/
/* STDINT.H v4.2.1                                                           */
/*                                                                           */
/* Copyright (c) 2002-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/



/* 7.18.1.1 Exact-width integer types */

    typedef   signed char    int8_t;
    typedef unsigned char   uint8_t;
    typedef          int    int16_t;
    typedef unsigned int   uint16_t;
    typedef          long   int32_t;
    typedef unsigned long  uint32_t;


    typedef          long long  int64_t;
    typedef unsigned long long uint64_t;

/* 7.18.1.2 Minimum-width integer types */

    typedef  int8_t   int_least8_t;
    typedef uint8_t  uint_least8_t;

    typedef  int16_t  int_least16_t;
    typedef uint16_t uint_least16_t;
    typedef  int32_t  int_least32_t;
    typedef uint32_t uint_least32_t;


    typedef  int64_t  int_least64_t;
    typedef uint64_t uint_least64_t;

/* 7.18.1.3 Fastest minimum-width integer types */

    typedef  int16_t  int_fast8_t;
    typedef uint16_t uint_fast8_t;
    typedef  int16_t  int_fast16_t;
    typedef uint16_t uint_fast16_t;

    typedef  int32_t  int_fast32_t;
    typedef uint32_t uint_fast32_t;


    typedef  int64_t  int_fast64_t;
    typedef uint64_t uint_fast64_t;

/* 7.18.1.4 Integer types capable of holding object pointers */

    typedef          long intptr_t;
    typedef unsigned long uintptr_t;





/* 7.18.1.5 Greatest-width integer types */
    typedef          long long intmax_t;
    typedef unsigned long long uintmax_t;

/* 
   According to footnotes in the 1999 C standard, "C++ implementations
   should define these macros only when __STDC_LIMIT_MACROS is defined
   before <stdint.h> is included." 
*/
#line 218 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdint.h"

#line 5 "/home/anay/grampower/gpos_fw/gpos/hardware/components/irda/irda.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/serial_device/serial_device.h"
/**
 * @file serial_device.h
 * Interface for devices which communicate byte-by-byte.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */






class SerialDevice
{
public:
	/**
	 * Send one byte over the serial interface.
	 *
	 * @param byte The byte to send.
	 * @return true if the byte was accepted by the device, otherwise false.
	 */
	virtual bool send(uint8_t byte) = 0;

	/**
	 * Receive one byte from the serial interface.
	 *
	 * Note that if the function returns false, the value of "byte" is undetermined.
	 *
	 * @param byte Pointer to a place to put the received byte.
	 * @return true if a byte was available and placed in *byte, otherwise false.
	 */
	virtual bool recv(uint8_t *byte) = 0;

	/**
	 * Discern whether bytes are available for reading.
	 *
	 * @return true if bytes are available to be read from the device, false otherwise.
	 */
	virtual bool readable() = 0;

	/**
	 * Return the number of bytes which may be written to this serial device now.
	 */
	virtual uint8_t numBytesWriteable() = 0;
};

#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/components/irda/irda.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/uart.h"



#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/system.h"
#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/uart.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/flash.h"
/**
 * @file flash.h
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */




#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdbool.h"
/* stdbool.h standard header */
#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"
/* yvals.h values header for conforming compilers on various systems */
#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdarg.h"
/*****************************************************************************/
/* stdarg.h   v4.2.1                                                         */
/*                                                                           */
/* Copyright (c) 1996-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/






namespace std {




typedef char *va_list;


} /* namespace std */




/*****************************************************************************/
/* On the MSP430, the stack grows down (towards 0x0), and arguments are      */
/* pushed in reverse order, so later arguments are at higher addresses.      */
/*****************************************************************************/

/*****************************************************************************/
/* VA_START(va_list ap, parmN)                                               */
/*                                                                           */
/*   Set "ap" to point to the address of the next argument past parmN.       */
/*   So add the size of parmN to the address of parmN.                       */
/*                                                                           */
/*   NOTES -must use the address of the level 1 symbol (via va_parmadr).     */
/*         -must account for "chars", which are widened to "ints".           */
/*                                                                           */
/*****************************************************************************/
#line 84 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdarg.h"
/*****************************************************************************/
/* VA_ARG(va_list, type)                                                     */
/*                                                                           */
/*   Return next argument (currently pointed to by "va_list", and set the    */
/*   argument pointer to point to the next argument after current one.       */
/*                                                                           */
/*   Notes -must handle variables passed by reference (_va_argref())         */
/*         -must round up chars.                                             */
/*                                                                           */
/*****************************************************************************/











using std::va_list;




#line 5 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"



/* You can predefine (on the compile command line, for example):

_ALT_NS=1 -- to use namespace _Dinkum_std for C++
_ALT_NS=2 -- to use namespace _Dinkum_std for C++ and C
_C_AS_CPP -- to compile C library as C++
_C_IN_NS -- to define C names in std/_Dinkum_std instead of global namespace
_C99 -- to turn ON C99 library support
_ABRCPP -- to turn ON Abridged C++ dialect (implies _ECPP)
_ECPP -- to turn ON Embedded C++ dialect
_NO_EX -- to turn OFF use of try/throw
_NO_MT -- to turn OFF thread synchronization
_NO_NS -- to turn OFF use of namespace declarations
_STL_DB (or _STLP_DEBUG) -- to turn ON iterator/range debugging
__NO_LONG_LONG -- to define _Longlong as long, not long long

You can change (in this header):

_ADDED_C_LIB -- from 1 to 0 to omit declarations for C extensions
_COMPILER_TLS -- from 0 to 1 if _TLS_QUAL is not nil
_EXFAIL -- from 1 to any nonzero value for EXIT_FAILURE
_FILE_OP_LOCKS -- from 0 to 1 for file atomic locks
_GLOBAL_LOCALE -- from 0 to 1 for shared locales instead of per-thread
_HAS_IMMUTABLE_SETS -- from 1 to 0 to permit alterable set elements
_HAS_STRICT_CONFORMANCE -- from 0 to 1 to disable nonconforming extensions
_HAS_TRADITIONAL_IOSTREAMS -- from 1 to 0 to omit old iostreams functions
_HAS_TRADITIONAL_ITERATORS -- from 0 to 1 for vector/string pointer iterators
_HAS_TRADITIONAL_POS_TYPE -- from 0 to 1 for streampos same as streamoff
_HAS_TRADITIONAL_STL -- from 1 to 0 to omit old STL functions
_IOSTREAM_OP_LOCKS -- from 0 to 1 for iostream atomic locks
_TLS_QUAL -- from nil to compiler TLS qualifier, such as __declspec(thread)
_USE_EXISTING_SYSTEM_NAMES -- from 1 to 0 to disable mappings (_Open to open)

Include directories needed to compile with Dinkum C:

C -- include/c
C99 -- include/c (define _C99)
Embedded C++ -- include/c include/embedded (define _ECPP)
Abridged C++ -- include/c include/embedded include (define _ABRCPP)
Standard C++ -- include/c include
Standard C++ with export -- include/c include/export include
	(--export --template_dir=lib/export)

Include directories needed to compile with native C:

C -- none
C99 -- N/A
Embedded C++ -- include/embedded (define _ECPP)
Abridged C++ -- include/embedded include (define _ABRCPP)
Standard C++ -- include
Standard C++ with export -- include/export include
	(--export --template_dir=lib/export)
 */

#line 77 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

 /* targets with "native" mode libraries don't support C9X */


 /* TI RTS supports the C9X snprintf() and vsnprintf() functions */










#line 104 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"





		/* DETERMINE MACHINE TYPE */


   /* _C99_MATH must be defined for using Dinkum Math */




#line 124 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"


		/* DETERMINE _Ptrdifft AND _Sizet FROM MACHINE TYPE */

typedef long _Int32t;
typedef unsigned long _Uint32t;


typedef  int  _Ptrdifft;





typedef  unsigned _Sizet;








#line 155 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"
















		/* EXCEPTION CONTROL */
#line 179 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"



		/* NAMING PROPERTIES */
/* #define _STD_LINKAGE	defines C names as extern "C++" */
/* #define _STD_USING	defines C names in namespace std or _Dinkum_std */










 













		/* THREAD AND LOCALE CONTROL */
#line 225 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"
 




		/* THREAD-LOCAL STORAGE */



#line 244 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"













		/* NAMESPACE CONTROL */




namespace std {}





#line 277 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"






#line 299 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"












#line 317 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"





#line 341 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

#line 360 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

#line 374 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"


namespace std {
typedef bool _Bool;
}


		/* VC++ COMPILER PARAMETERS */







        /* defined(__NO_LONG_LONG) && !defined (_MSC_VER) && ! TI 32 bit processor*/






		/* MAKE MINGW LOOK LIKE WIN32 HEREAFTER */



namespace std {
		/* FLOATING-POINT PROPERTIES */
#line 409 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

		/* INTEGER PROPERTIES */





#line 422 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"






typedef long long _Longlong;
typedef unsigned long long _ULonglong;

#line 437 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

		/* wchar_t AND wint_t PROPERTIES */











typedef wchar_t _Wchart;
typedef wchar_t _Wintt;


#line 483 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

		/* POINTER PROPERTIES */


		/* signal PROPERTIES */




		/* stdarg PROPERTIES */
typedef ::std:: va_list _Va_list;

#line 509 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"
		/* stdlib PROPERTIES */


extern "C" {
void _Atexit(void (*)(void));
}

		/* stdio PROPERTIES */









typedef char _Sysch_t;

		/* STORAGE ALIGNMENT PROPERTIES */


		/* time PROPERTIES */


}

		/* MULTITHREAD PROPERTIES */
#line 552 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

		/* LOCK MACROS */






#line 567 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"


namespace std {
extern "C++" {	// in case of _C_AS_CPP
		// CLASS _Lockit
class _Lockit
	{	// lock while object in existence -- MUST NEST
public:




	explicit _Lockit()
		{	// do nothing
		}

	explicit _Lockit(int)
		{	// do nothing
		}

	~_Lockit()
		{	// do nothing
		}

#line 617 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

public:
	_Lockit(const _Lockit&);			// not defined
	_Lockit& operator=(const _Lockit&);	// not defined
	};

class _Mutex
	{	// lock under program control
public:


    void _Lock()
		{	// do nothing
		}

	void _Unlock()
		{	// do nothing
	}

#line 647 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

	};
}	// extern "C++"
}


		/* MISCELLANEOUS MACROS */











#line 675 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"

#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/linkage.h"
/*****************************************************************************/
/* linkage.h   v4.2.1                                                        */
/*                                                                           */
/* Copyright (c) 1998-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/




/* No modifiers are needed to access code or data */





/*--------------------------------------------------------------------------*/
/* Define _IDECL ==> how inline functions are declared                      */
/*--------------------------------------------------------------------------*/
#line 59 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/linkage.h"

#line 678 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"
#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/_lock.h"
/*****************************************************************************/
/*  _lock.h v4.2.1                                                           */
/*                                                                           */
/* Copyright (c) 2000-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/







extern "C" {


 void _nop();

extern  void (  *_lock)();
extern  void (*_unlock)();

 void _register_lock  (void (  *lock)());
 void _register_unlock(void (*unlock)());





} /* extern "C" */


#line 680 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/yvals.h"





/*
 * Copyright (c) 1992-2004 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V4.02:1476 */

#line 6 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdbool.h"


namespace std {



#line 29 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/stdbool.h"

}


/*
 * Copyright (c) 1992-2004 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V4.02:1476 */
#line 15 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/flash.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/system.h"
#line 17 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/flash.h"


namespace base
{

class Flash
{
public:
	/**
	 * Erase the flash segment which contains "addr".
	 *
	 * @param addr Address contained within the flash segment to erase.
	 * @return true if flash segment exists and was erased, false otherwise.
	 */
	virtual bool eraseSegment(void *addr) = 0;

	/**
	 * Read "len" bytes from flash into "buffer" starting at "startAddr".
	 *
	 * @param startAddr The first address from which to read.
	 * @param buffer Buffer into which to write bytes.
	 * @param len Number of bytes to read.
	 *
	 * @return Number of bytes read.
	 */
	virtual uint16_t read(void *startAddr, void *buffer, uint16_t len) = 0;

	/**
	 * Write "len" bytes into flash from "buffer" starting at "startAddr".
	 *
	 * @param startAddr The first address to which to write.
	 * @param buffer Buffer from which to read bytes.
	 * @param len Number of bytes to write.
	 *
	 * @return Number of bytes written.
	 */
	virtual uint16_t write(void *startAddr, void *buffer, uint16_t len) = 0;

	/**
	 * Get total flash size in bytes.
	 *
	 * @return Total flash size in bytes.
	 */
	virtual uint32_t length() = 0;
	
    /**
     * Get the CRC of a flash block. Implementing this in the memory driver
     * rather than forcing users to implement means we can compute the CRC
     * without reading the entire block into memory first.
     */
    uint16_t getCRC(void *addr, uint16_t len);
};

}


#line 2 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/iopin.h"
/*
 * base/iopin.h
 * Gram Power Inc.
 *
 * This class is a generic representation of IO pins of any microcontroller.
 */




#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/system.h"
#line 13 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/iopin.h"

namespace base
{


typedef enum pin_direction
{
	input,
	output
} pin_direction;


typedef enum pin_state
{
	low,
	high
};


class IOPin
{

public:

	virtual void init(uint8_t portNumber_, uint8_t pinNumber_, pin_direction dir_, pin_state initial_state_) = 0;

	virtual void setDirection(pin_direction dir) = 0;

	virtual void setHigh(void) = 0;

	virtual void setLow(void) = 0;

	virtual void toggle(void) = 0;

	virtual bool getValue(void) = 0;
};


}

#line 3 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/clock.h"



namespace base
{

class Clock
{

};

}

#line 4 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/lcd_driver.h"
/*
 * lcd_driver.h
 * Gram Power Inc.
 *
 * A representative interface for all microcontrollers which have
 * an internal LCD driver
 */






namespace base
{

class LCDDriver
{
public:
	virtual volatile uint8_t* getLCDMemoryPointer()=0;
	virtual void turnOn()=0;
	virtual void turnOff()=0;
	virtual void enterBlinkingMode()=0;
	virtual void exitBlinkingMode()=0;
};

}


#line 5 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/timer.h"





namespace base
{

class TimerUser
{
public:
	virtual void _timerCallback() = 0;
};

class Timer
{


public:

	virtual void setCallback(TimerUser *user) = 0;

	virtual void setCallbackFrequency(uint32_t hertz) = 0;
};

}

#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/uart.h"
#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/watchdog.h"



namespace base
{

class Watchdog
{
public:

	virtual void kick() = 0;
	virtual void disable() = 0;
	virtual void enable() = 0;
	virtual bool enabled() = 0;
};

}

#line 8 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/spi.h"



#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/system.h"
#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base/spi.h"


namespace base
{

class SPI
{

public:
	//SPI(base::serial_module_t serialModule, uint8_t csPinPortNumber, uint8_t csPinPinNumber){};
	virtual uint8_t send(uint8_t byte) = 0;
	virtual void setCsPin() = 0;
	virtual void clearCsPin() = 0;
};

}

#line 9 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/../base.h"
#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/uart.h"

namespace base
{

class UART
{

public:

	virtual void update() = 0;

	virtual void setBaud(uint32_t baud) = 0;

	virtual void useEnablePin(base::IOPin* enablePin_) = 0;

	virtual void useCtsPin(base::IOPin* ctsPin_) = 0;

	virtual bool put(uint8_t c) = 0;

	virtual bool get(uint8_t *c) = 0;

	virtual bool writeable() = 0;

	virtual bool readable() = 0;

	virtual uint8_t numBytesWriteable() = 0;

	virtual bool bytesPendingToTransmit() = 0;

	virtual bool readFull() = 0;

	virtual void flushInput() = 0;

	virtual void flushOutput() = 0;

	virtual void configureAsIrDA() = 0;
};

}

#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/components/irda/irda.h"

class IrDA: public SerialDevice
{
public:
	base::UART* _uart;
	base::IOPin* _shutdownPin;
	IrDA(base::IOPin* shutdownPin_, base::UART* uart_);
	bool send(uint8_t byte);
	bool recv(uint8_t* byte);
	bool readable();
	uint8_t numBytesWriteable();
};

#line 2 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/lcd/lcd_est_lcg_083.h"
/*
 * lcd_est_lcg_083.h
 * Gram Power Inc.
 *
 * A generic implementation of EST-LCG-083-STN LCD
 * This LCD can either be driven using a LCD driver built inside a microcontroller (example, msp430)
 * or, the LCD can be driven using an external driver.
 * As of now, only the microcontrollers which have an internal LCD driver are supported here;
 * Support for external drivers would be implemented once the need is felt!
 *
 * Example usage:
 * 			LCDDriver _lcdDriver;
 * 			LCD_ESTLCG083 lcd(&_lcdDriver);
 * 			lcd.setColon();
 */


/*
 * TODO: As of now, mem[] is accessed directlty using hardcoded numbers;
 * but these numbers actually depend upon the way the LCD is connected to the
 * microcontroller
 */




#line 35 "/home/anay/grampower/gpos_fw/gpos/hardware/components/lcd/lcd_est_lcg_083.h"

#line 74 "/home/anay/grampower/gpos_fw/gpos/hardware/components/lcd/lcd_est_lcg_083.h"

#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/lcd/energy_meter_lcd.h"
/*
 * energy_meter_lcd.h
 * Gram Power Inc.
 *
 * EnergyMeterLCD
 *
 */






/** The LCD pins can be connected to the microcontroller in either a inverted sequence
 * (when uC is on bottom layer) or in non inverted sequence (when uC is on top layer)
 * TODO: As of now, the driver has been implemented only for noninverted sequence.
 * To implement the driver for inverted sequence, we need to so do something like:
 * 	old: mem[0] = 0x34 => new: mem[9] = 0x43
 */
typedef enum lcd_connection_sequence
{
	inverted_sequence,
	noninverted_sequence
} lcd_connection_sequence_t;


/**
 * Various types of symbols which can be displayed on the LCD.
 */
typedef enum lcd_symbol
{
    symbol_ok,
    symbol_time,
    symbol_date,
    symbol_earth,
    symbol_rev,
    symbol_nm,
    symbol_mag,
    symbol_tod,
    symbol_md,
    symbol_r,
    symbol_y,
    symbol_b
} lcd_symbol_t;


/**
 * Unlike lcd_symbol_t, measurement symbols cannot co-exist.
 * Only one of the measurement symbols can be displayed at a time on the LCD.
 * symbol_off signifies that no measurement symbol is being displayed
 */
typedef enum lcd_measurement_symbol
{
	symbol_wh,
    symbol_kwh,
    symbol_kva,
    symbol_volts,
    symbol_amps,
    symbol_watts,
    symbol_va,
    symbol_var,
    symbol_off
} lcd_measurement_symbol_t;


/**
 * this struct is used by displayFloat() function.
 * If numberOfDecimalPartDigits == 2 implies that a number like 5.4 would
 * be displayed as 5.04
 */
typedef struct disp_float_t
{
	int32_t integerPart;
	int32_t decimalPart;
	uint8_t numberOfDecimalPartDigits;
}disp_float_t;

/**
 * this struct is used by displayTime()
 */
typedef struct disp_time_t
{
	uint8_t hours;
	uint8_t minutes;
	uint8_t seconds;
}disp_time_t;

/**
 * this struct is used by displayDate()
 */
typedef struct disp_date_t
{
	uint8_t year;
	uint8_t month;
	uint8_t day;
}disp_date_t;


/**
 * EnergyMeterLCD is an abstract class which is inherited by classes which represent
 * physical LCDs.
 */
class EnergyMeterLCD
{
protected:

	/** this function is similar to displayInteger(), except that it does not erase anything on the screen */
	void _displayIntegerHelper(int32_t num);

	/** is an indicator signifying the manner in which LCD pins are connected to microcontroller pins */
	lcd_connection_sequence_t _connectionSequence;

public:

	/** clears everything on screen */
	virtual void clearAll()=0;

	/** char can be ascii codes for digits, alphabets or certain special characters like hypen.
	 * Returns false if it is not possible to display the character */
	virtual bool setChar(uint8_t position, char c)=0;

	/** similar to setChar(), except that you can directly pass the digit instead of the digit's ascii code.
	 * Returns false if position is out of bound or digit is out of bound */
	virtual bool setDigit(uint8_t position, uint8_t digit)=0;

	/** similar to setChar except that it can only display alphabet.
	 * Avoid using this function. Instead, always use setChar */
	virtual bool setAlphabet(uint8_t position, char c)=0;

	virtual void clearDynamicSection()=0;
	virtual void clearStaticSection()=0;

	/** makes the input measurement symbol visible, and erases the previous measurement symbol
	 * as measurement symbols cannot coexist */
	virtual void setMeasurementSymbol(lcd_measurement_symbol_t symbol)=0;

	/** makes the input symbol visible, does not erase any other symbol as lcd_symbol_t can coexist */
	virtual void setSymbol(lcd_symbol_t symbol)=0;

	/** clears the input symbol */
	virtual void clearSymbol(lcd_symbol_t symbol)=0;

	/** makes the LCD blick with a certain period (which is hardcoded for now) */
	virtual void enterBlinkingMode()=0;

	/** stops LCD blinking */
	virtual void exitBlinkingMode()=0;

	/** turns on a dot (period) at the specified position.
	 * Returns false if position is out of bound */
	virtual bool setDot(uint8_t position)=0;

	/** clears the dot (period) from the specified position.
	 * TODO: convert this into a bool return type*/
	virtual void clearDot(uint8_t position)=0;

	/** turns on the colons which can be used to display things like time or data */
	virtual void setColon(void)=0;

	/** clears the colons */
	virtual void clearColon(void)=0;

	/** characters/digits are represented using seven segment display.
	 * this function clears anything displayed on the seven segment at the given position
	 */
	virtual void clearSevenSegmentPosition(uint8_t position)=0;

	/** turns on all possible display on the screen */
	virtual void setAll()=0;




	/** this is a wrapper around setDigit. For example, this allows to display an integer in the range
	 * -99999 to 999999 (assuming the lCD has 6 seven segment positions */
	bool displayInteger(int32_t num);

	/**
	 * Allows to display floating point numbers as specified in disp_float_t.
	 */
	bool displayFloat(disp_float_t);

	/** a wrapper around setChar() */
	void displayString(char* string, uint8_t len);

	/** this function is used by displayDate() and displayTime().
	 * Allows to display strings such as "12:34:56". */
	void displayColonedTriplet(uint8_t firstPart, uint8_t secondPart, uint8_t thirdPart);

	/** clears any integer or float or coloned triplet from the screen */
	void clearNumber();

	/** displays given voltage as a floating point number, and also sets the appropriate measurement symbol.
	 * The value is displayed with just one decimal point. Example, -32455 mV would be displayed as -32.4 V.
	 * TODO: return error if not able to display */
	void displayVoltage(int32_t milliVolts);

	/** displays given current as a floating point number, and also sets the appropriate measurement symbol.
	 * Value is displayed with just one decimal point; Example, 324 mA would be displayed as 0.3 A.
	 * TODO: return error if not able to display*/
	void displayCurrent(int32_t milliAmps);

	/** displays given voltage as a floating point number, and also sets the appropriate measurement symbol.
	 * Value is displayed in watts
	 * TODO: return error if not able to display active power */
	void displayActivePower(int32_t milliWatts);

	/** displays time in the format "hh:mm:ss". Also turns on the Time symbol
	 * TODO: return error if not able to display time */
	void displayTime(disp_time_t time);

	/** displays date in the format "dd:mm:yy". Also turns on Date symbol.
	 * TODO: return error if not able to display date */
	void displayDate(disp_date_t date);

};
#line 79 "/home/anay/grampower/gpos_fw/gpos/hardware/components/lcd/lcd_est_lcg_083.h"


/**
 * TODO: have private variables for number of seven segment characters, number of dots etc.
 * As of now, these values have been hardcoded in the implementation
 */
class LCD_ESTLCG083 : public EnergyMeterLCD 
{

private:
	base::LCDDriver* _lcdDriver;
	uint8_t mem[10];
	volatile uint8_t* lcdmem;
	lcd_connection_sequence_t _connectionSequence;
	void _handleSequence();

public:

	LCD_ESTLCG083(base::LCDDriver* lcdDriver_, lcd_connection_sequence_t connectionSequence_);

	void setSymbol(lcd_symbol_t symbol);

	void clearSymbol(lcd_symbol_t symbol);

	void setMeasurementSymbol(lcd_measurement_symbol_t symbol);

	void clearMeasurementSymbol(void);

	void clearSevenSegmentPosition(uint8_t position);

	bool setDigit(uint8_t position, uint8_t digit);

	bool setAlphabet(uint8_t position, char c);

	bool setChar(uint8_t position, char c);

	bool setDot(uint8_t position);

	void clearDot(uint8_t position);

	void setColon(void);

	void clearColon(void);

	void enterBlinkingMode(void);

	void exitBlinkingMode(void);

	void setAll();

	void clearAll();

	void clearDynamicSection();

	void clearStaticSection();

	static uint32_t digitTable[10];

	static uint32_t alphabetTable[26];
};

#line 3 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/led/led.h"
/*
 * led.h
 *
 * Generic Driver for LEDs along with its driving circuitry.
 * Gram Power Inc.
 *
 * Example usage:
 * 		IOPin pin(PORT2, 1, base::output)
 * 		LED redLed(&pin, inverted)
 * 		redLed.turnOn();
 *
 */




#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/binary_logic.h"
/**
 * @file binary_logic.h
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */





typedef enum logic
{
	inverted,
	noninverted
} logic_t;

typedef enum binary_state
{
	on,
	off
} binary_state_t;


#line 19 "/home/anay/grampower/gpos_fw/gpos/hardware/components/led/led.h"


class LED
{
private:
	/** the microcontroller pin driving the LED */
	base::IOPin* _ioPin;

	/** either inverted or noninverted;
	 * inverted configuration implies that LED glows when microcontroller pin is driven low */
	logic_t _logic ;
	binary_state_t state;

public:

	LED(base::IOPin* ioPin_, logic_t logic);

	void turnOn();

	void turnOff();

	void toggle();
};

#line 4 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/memory/flash_w25q80bv.h"
/**
 * @file flash_w25q80bv.h
 * Driver for the Winbond W25Q80BV SPI flash chip.
 *
 *  @section LICENSE
 *  [Standard license info]
 *
 *  Copyright 2014 Gram Power, Inc.
 */

/**
 * QUESTIONS:
 * 1. for eraseSector, does addr have to be the *start* address of the sector?
 *    or can you specify any address within the sector?
 */







#line 34 "/home/anay/grampower/gpos_fw/gpos/hardware/components/memory/flash_w25q80bv.h"






class Flash_W25Q80BV
{
private:
	base::SPI *spi;
	void _sendAddr(uint32_t addr);

public:
	/**
	 * Initialize the flash chip controller.
	 */
	Flash_W25Q80BV(base::SPI *spi_);

	/**
	 * Fetch the chip's manufacturer and device ID.
	 *
	 * @param manufacturer Pointer to a variable in which to put manufacturer
	 * @param deviceId Pointer to a variable in which to put device ID
	 */
	void getManufacturerAndDeviceId(uint8_t *manufacturer, uint8_t *deviceId);

	/**
	 * Program part or all of a page.
	 *
	 * IMPORTANT: Will only program a single page - if len would take the
	 * programming to the next page, it will wrap to the beginning of the
	 * current page instead (see datasheet section on Page Program).
	 *
	 * @param addr Address of the page to be programmed.
	 * @param data Pointer to an array of data to be programmed.
	 * @param len Number of bytes to take from "data" and program to page.
	 */
	void programPage(uint32_t addr, uint8_t *data, uint16_t len);

	/**
	 * Read a section of the memory.
	 *
	 * @param addr Address of the first byte to be read.
	 * @param data Pointer to an array for the read bytes to be stored in.
	 * @param len Number of bytes to read.
	 */
	void readData(uint32_t addr, uint8_t *data, uint32_t len);

	/**
	 * Erase a 4k sector of memory (the smallest chunk that can be erased).
	 *
	 * @param addr Address of the sector to be erased. TODO: Elaborate
	 */
	void eraseSector(uint32_t addr);

	/**
	 * Erase a 32k block of memory.
	 *
	 * @param addr Address of the block to be erased. TODO: Elaborate
	 */
	void erase32kBlock(uint32_t addr);

	/**
	 * Erase a 64k block of memory.
	 *
	 * @param addr Address of the block to be erased. TODO: Elaborate
	 */
	void erase64kBlock(uint32_t addr);

	/**
	 * Erase the entire chip's memory.
	 */
	void eraseChip();

	/**
	 * Return whether the chip is busy programming or erasing as per the BUSY
	 * bit in the Status Register.
	 *
	 * During programming and erasing most operations, including programming,
	 * erasing, and reading memory, are not available.
	 */
	bool busy();
};

#line 5 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/crc_module.h"
/**
 * @file crc_module.h
 * Uses the hardware CRC module to compute CRCs.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */







namespace msp430f6733
{

class CRC_Module
{
public:
	static uint16_t getCheckValue(uint8_t *data, uint16_t len);
};

}


#line 2 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/flash.h"
/**
 * @file flash.h
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */




#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/string.h"
/*****************************************************************************/
/* string.h   v4.2.1                                                         */
/*                                                                           */
/* Copyright (c) 1993-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/






//----------------------------------------------------------------------------
// <cstring> IS RECOMMENDED OVER <string.h>.  <string.h> IS PROVIDED FOR
// COMPATIBILITY WITH C AND THIS USAGE IS DEPRECATED IN C++
//----------------------------------------------------------------------------
extern "C" namespace std
{

 






typedef unsigned size_t;




#line 69 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/string.h"

 size_t  strlen(const char *_string);

 char *strcpy(char *_dest, const char *_src);
 char *strncpy(char *_to, const char *_from, size_t _n);
 char *strcat(char *_string1, const char *_string2);
 char *strncat(char *_to, const char *_from, size_t _n);
 char *strchr(const char *_string, int _c);
 char *strrchr(const char *_string, int _c);

 int  strcmp(const char *_string1, const char *_string2);
 int  strncmp(const char *_string1, const char *_string2, size_t _n);

 int     strcoll(const char *_string1, const char *_string2);
 size_t  strxfrm(char *_to, const char *_from, size_t _n);
 char   *strpbrk(const char *_string, const char *_chs);
 size_t  strspn(const char *_string, const char *_chs);
 size_t  strcspn(const char *_string, const char *_chs);
 char   *strstr(const char *_string1, const char *_string2);
 char   *strtok(char *_str1, const char *_str2);
 char   *strerror(int _errno);
 char   *strdup(const char *string);


 void   *memmove(void *_s1, const void *_s2, size_t _n);
 void   *memcpy(void *_s1, const void *_s2, size_t _n);

 int     memcmp(const void *_cs, const void *_ct, size_t _n);
 void   *memchr(const void *_cs, int _c, size_t _n);

   void   *memset(void *_mem, int _ch, size_t _n);



} /* extern "C" namespace std */


#line 313 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/string.h"




using std::size_t;
using std::strlen;
using std::strcpy;
using std::strncpy;
using std::strcat;
using std::strncat;
using std::strchr;
using std::strrchr;
using std::strcmp;
using std::strncmp;
using std::strcoll;
using std::strxfrm;
using std::strpbrk;
using std::strspn;
using std::strcspn;
using std::strstr;
using std::strtok;
using std::strerror;
using std::strdup;
using std::memmove;
using std::memcpy;
using std::memcmp;
using std::memchr;
using std::memset;




#line 15 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/flash.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/watchdog.h"





namespace msp430f6733
{
class Watchdog : public base::Watchdog
{
private:
	bool _enabled;

public:
	Watchdog();

	void kick();
	void disable();
	void enable();
	bool enabled();

	/** Specialized to this uC */
	void resetSystem();
};
}
#line 18 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/flash.h"


namespace msp430f6733
{

class Flash : public base::Flash
{
private:
	static const uint32_t FLASH_TOTAL_LEN_BYTES;
	static const uint32_t FLASH_BEGINNING_ADDR;
	static const uint32_t FLASH_ENDING_ADDR;
	static const uint32_t INFO_SEG_A_ADDR;
	static const uint32_t INFO_SEG_B_ADDR;
	static const uint32_t INFO_SEG_C_ADDR;
	static const uint32_t INFO_SEG_D_ADDR;
	static const uint32_t INFO_SEG_LEN_BYTES;

	/**
	 * We need a reference to the watchdog because it needs to be shut
	 * off during flash writes
	 */
	// TODO: should this actually be done by the application code?
	Watchdog *_watchdog;

	uint16_t _writeSingleSegment(void *realAddr, void *buffer, uint16_t len);
	void *_getRealFromVirtualAddr(void *virtualAddr);

public:
	Flash(Watchdog *watchdog);
	bool eraseSegment(void *addr);
	uint16_t read(void *srcAddr, void *destBuffer, uint16_t len);
	uint16_t write(void *destAddr, void *srcBuffer, uint16_t len);
	bool addressValid(void *addr);
	uint32_t length();
	uint16_t getCRC(void *addr, uint16_t len);
};

}


#line 3 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"




#line 1 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
/* ============================================================================ */
/* Copyright (c) 2013, Texas Instruments Incorporated                           */
/*  All rights reserved.                                                        */
/*                                                                              */
/*  Redistribution and use in source and binary forms, with or without          */
/*  modification, are permitted provided that the following conditions          */
/*  are met:                                                                    */
/*                                                                              */
/*  *  Redistributions of source code must retain the above copyright           */
/*     notice, this list of conditions and the following disclaimer.            */
/*                                                                              */
/*  *  Redistributions in binary form must reproduce the above copyright        */
/*     notice, this list of conditions and the following disclaimer in the      */
/*     documentation and/or other materials provided with the distribution.     */
/*                                                                              */
/*  *  Neither the name of Texas Instruments Incorporated nor the names of      */
/*     its contributors may be used to endorse or promote products derived      */
/*     from this software without specific prior written permission.            */
/*                                                                              */
/*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" */
/*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,       */
/*  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR      */
/*  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR            */
/*  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,       */
/*  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,         */
/*  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; */
/*  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,    */
/*  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR     */
/*  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,              */
/*  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                          */
/* ============================================================================ */

/********************************************************************
*
* Standard register and bit definitions for the Texas Instruments
* MSP430 microcontroller.
*
* This file supports assembler and C development for the
* MSP430F6733 device.
*
* Texas Instruments, Version 1.3
*
* Rev. 1.0, Initial Release
* Rev. 1.1, Added missing LCD Registers
* Rev. 1.2, Fixed typo in LCD_C (VLCD) definitions
* Rev. 1.3, Removed not available Bits SD24BINCHx
*
********************************************************************/







extern "C" {



/*----------------------------------------------------------------------------*/
/* PERIPHERAL FILE MAP                                                        */
/*----------------------------------------------------------------------------*/


/* External references resolved by a device-specific linker command file */


//#define SFR_20BIT(address)  extern volatile unsigned int address
typedef void (* __SFR_FARPTR)();






/************************************************************
* STANDARD BITS
************************************************************/

#line 96 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* STATUS REGISTER BITS
************************************************************/

#line 110 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Low Power Modes coded with Bits 4-7 in SR */

#line 127 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1 "/opt/ti/ccsv5/ccs_base/msp430/include/in430.h"
/*----------------------------------------------------------------------------*/
/* in430.h      - Intrinsic function prototypes and convenience mapping       */
/*                macros for migrating code from the IAR platform.            */
/*                                                                            */
/*  Ver | dd mmm yyyy | Who  | Description of changes                         */
/* =====|=============|======|=============================================   */
/*  0.01| 06 Apr 2004 | A.D. | First Prototype                                */
/*  0.02| 22 Jun 2004 | A.D. | File reformatted                               */
/*                                                                            */
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/* COMPILER INTRINSIC FUNCTIONS                                               */
/*----------------------------------------------------------------------------*/

void _enable_interrupts(void); 
void _disable_interrupts(void); 
unsigned short _bic_SR_register(unsigned short mask);
unsigned short _bic_SR_register_on_exit(unsigned short mask); 
unsigned short _bis_SR_register(unsigned short mask); 
unsigned short _bis_SR_register_on_exit(unsigned short mask);
unsigned short _get_SR_register(void); 
unsigned short _get_SR_register_on_exit(void); 
unsigned short _swap_bytes(unsigned short src); 
void _nop(void); 
void _never_executed(void);

/*----------------------------------------------------------------------------*/
/* INTRINSIC MAPPING FOR IAR V1.XX                                            */
/*----------------------------------------------------------------------------*/

#line 43 "/opt/ti/ccsv5/ccs_base/msp430/include/in430.h"

/*----------------------------------------------------------------------------*/
/* INTRINSIC MAPPING FOR IAR V2.XX/V3.XX                                      */
/*----------------------------------------------------------------------------*/

#line 58 "/opt/ti/ccsv5/ccs_base/msp430/include/in430.h"

#line 129 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
#line 1 "/opt/ti/ccsv5/tools/compiler/msp430_4.2.1/include/intrinsics.h"
/*****************************************************************************/
/*  INTRINSICS.H v4.2.1                                                      */
/*                                                                           */
/* Copyright (c) 2005-2013 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/

extern "C"
{


void           _nop(void);
void           _enable_interrupts(void);
void           _disable_interrupts(void);
unsigned short _swap_bytes(unsigned short a);
unsigned short _bic_SR_register(unsigned short a);
unsigned short _bic_SR_register_on_exit(unsigned short a);
unsigned short _bis_SR_register(unsigned short);
unsigned short _bis_SR_register_on_exit(unsigned short a);
unsigned short _get_SR_register(void); 
unsigned short _get_SR_register_on_exit(void);
void           _never_executed(void );

unsigned short _bcd_add_short(unsigned short, unsigned short);
unsigned long  _bcd_add_long(unsigned long, unsigned long);

unsigned int   _even_in_range(unsigned int, unsigned int);
void           _op_code(unsigned short);
void           _data20_write_char(unsigned long, unsigned char);
void           _data20_write_short(unsigned long, unsigned short);
void           _data20_write_long(unsigned long, unsigned long);
unsigned char  _data20_read_char(unsigned long);
unsigned short _data20_read_short(unsigned long);
unsigned long  _data20_read_long(unsigned long);
unsigned short _get_interrupt_state(void);
void           _set_interrupt_state(unsigned short);
unsigned short _get_SP_register(void);
void           _set_SP_register(unsigned short);


} /* extern "C" */


 
#line 130 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 142 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* CPU
************************************************************/



/************************************************************
* PERIPHERAL FILE MAP
************************************************************/

/************************************************************
* ADC10_A
************************************************************/




extern volatile unsigned int ADC10CTL0;                         /* ADC10 Control 0 */
extern volatile unsigned char ADC10CTL0_L;                        /* ADC10 Control 0 */
extern volatile unsigned char ADC10CTL0_H;                        /* ADC10 Control 0 */
extern volatile unsigned int ADC10CTL1;                         /* ADC10 Control 1 */
extern volatile unsigned char ADC10CTL1_L;                        /* ADC10 Control 1 */
extern volatile unsigned char ADC10CTL1_H;                        /* ADC10 Control 1 */
extern volatile unsigned int ADC10CTL2;                         /* ADC10 Control 2 */
extern volatile unsigned char ADC10CTL2_L;                        /* ADC10 Control 2 */
extern volatile unsigned char ADC10CTL2_H;                        /* ADC10 Control 2 */
extern volatile unsigned int ADC10LO;                           /* ADC10 Window Comparator High Threshold */
extern volatile unsigned char ADC10LO_L;                          /* ADC10 Window Comparator High Threshold */
extern volatile unsigned char ADC10LO_H;                          /* ADC10 Window Comparator High Threshold */
extern volatile unsigned int ADC10HI;                           /* ADC10 Window Comparator High Threshold */
extern volatile unsigned char ADC10HI_L;                          /* ADC10 Window Comparator High Threshold */
extern volatile unsigned char ADC10HI_H;                          /* ADC10 Window Comparator High Threshold */
extern volatile unsigned int ADC10MCTL0;                        /* ADC10 Memory Control 0 */
extern volatile unsigned char ADC10MCTL0_L;                       /* ADC10 Memory Control 0 */
extern volatile unsigned char ADC10MCTL0_H;                       /* ADC10 Memory Control 0 */
extern volatile unsigned int ADC10MEM0;                         /* ADC10 Conversion Memory 0 */
extern volatile unsigned char ADC10MEM0_L;                        /* ADC10 Conversion Memory 0 */
extern volatile unsigned char ADC10MEM0_H;                        /* ADC10 Conversion Memory 0 */
extern volatile unsigned int ADC10IE;                           /* ADC10 Interrupt Enable */
extern volatile unsigned char ADC10IE_L;                          /* ADC10 Interrupt Enable */
extern volatile unsigned char ADC10IE_H;                          /* ADC10 Interrupt Enable */
extern volatile unsigned int ADC10IFG;                          /* ADC10 Interrupt Flag */
extern volatile unsigned char ADC10IFG_L;                         /* ADC10 Interrupt Flag */
extern volatile unsigned char ADC10IFG_H;                         /* ADC10 Interrupt Flag */
extern volatile unsigned int ADC10IV;                           /* ADC10 Interrupt Vector Word */
extern volatile unsigned char ADC10IV_L;                          /* ADC10 Interrupt Vector Word */
extern volatile unsigned char ADC10IV_H;                          /* ADC10 Interrupt Vector Word */

/* ADC10CTL0 Control Bits */
#line 200 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10CTL0 Control Bits */





/* ADC10CTL0 Control Bits */





#line 229 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10CTL1 Control Bits */
#line 243 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10CTL1 Control Bits */
#line 253 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10CTL1 Control Bits */















#line 278 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* ADC10CTL2 Control Bits */
#line 291 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10CTL2 Control Bits */





/* ADC10CTL2 Control Bits */












/* ADC10MCTL0 Control Bits */
#line 319 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10MCTL0 Control Bits */
#line 328 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 345 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 354 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10IE Interrupt Enable Bits */
#line 362 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10IE Interrupt Enable Bits */
#line 370 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10IFG Interrupt Flag Bits */
#line 378 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10IFG Interrupt Flag Bits */
#line 386 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* ADC10IV Definitions */
#line 395 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* Auxilary Supply
************************************************************/




extern volatile unsigned int AUXCTL0;                           /* Auxiliary Supply Control register 0 */
extern volatile unsigned char AUXCTL0_L;                          /* Auxiliary Supply Control register 0 */
extern volatile unsigned char AUXCTL0_H;                          /* Auxiliary Supply Control register 0 */
extern volatile unsigned int AUXCTL1;                           /* Auxiliary Supply Control register 1 */
extern volatile unsigned char AUXCTL1_L;                          /* Auxiliary Supply Control register 1 */
extern volatile unsigned char AUXCTL1_H;                          /* Auxiliary Supply Control register 1 */
extern volatile unsigned int AUXCTL2;                           /* Auxiliary Supply Control register 2 */
extern volatile unsigned char AUXCTL2_L;                          /* Auxiliary Supply Control register 2 */
extern volatile unsigned char AUXCTL2_H;                          /* Auxiliary Supply Control register 2 */

extern volatile unsigned int AUX2CHCTL;                         /* AUX2 Charger Control register */
extern volatile unsigned char AUX2CHCTL_L;                        /* AUX2 Charger Control register */
extern volatile unsigned char AUX2CHCTL_H;                        /* AUX2 Charger Control register */
extern volatile unsigned int AUX3CHCTL;                         /* AUX3 Charger Control register */
extern volatile unsigned char AUX3CHCTL_L;                        /* AUX3 Charger Control register */
extern volatile unsigned char AUX3CHCTL_H;                        /* AUX3 Charger Control register */
extern volatile unsigned int AUXADCCTL;                         /* AUX ADC Control */
extern volatile unsigned char AUXADCCTL_L;                        /* AUX ADC Control */
extern volatile unsigned char AUXADCCTL_H;                        /* AUX ADC Control */
extern volatile unsigned int AUXIFG;                            /* AUX Interrupt Flag */
extern volatile unsigned char AUXIFG_L;                           /* AUX Interrupt Flag */
extern volatile unsigned char AUXIFG_H;                           /* AUX Interrupt Flag */
extern volatile unsigned int AUXIE;                             /* AUX Interrupt Enable */
extern volatile unsigned char AUXIE_L;                            /* AUX Interrupt Enable */
extern volatile unsigned char AUXIE_H;                            /* AUX Interrupt Enable */
extern volatile unsigned int AUXIV;                             /* AUX Interrupt Vector Word  */
extern volatile unsigned char AUXIV_L;                            /* AUX Interrupt Vector Word  */
extern volatile unsigned char AUXIV_H;                            /* AUX Interrupt Vector Word  */

/* AUXCTL0 Control Bits */





/* AUXCTL0 Control Bits */








/* AUXCTL1 Control Bits */
#line 455 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXCTL1 Control Bits */





/* AUXCTL1 Control Bits */




/* AUXCTL2 Control Bits */
#line 479 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXCTL2 Control Bits */
#line 487 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXCTL2 Control Bits */






#line 503 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 512 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 521 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* AUXADCCTL Control Bits */






/* AUXADCCTL Control Bits */






#line 549 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* AUXxCHCTL Control Bits */






/* AUXxCHCTL Control Bits */


















/* AUXIFG Control Bits */
#line 590 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXIFG Control Bits */
#line 599 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXIFG Control Bits */


/* AUXIE Control Bits */
#line 613 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXIE Control Bits */
#line 623 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* AUXIE Control Bits */


/* AUXIV Definitions */
#line 637 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/*************************************************************
* Backup RAM Module
*************************************************************/




extern volatile unsigned int BAKMEM0;                           /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM0_L;                          /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM0_H;                          /* Battery Backup Memory 0 */
extern volatile unsigned int BAKMEM1;                           /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM1_L;                          /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM1_H;                          /* Battery Backup Memory 0 */
extern volatile unsigned int BAKMEM2;                           /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM2_L;                          /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM2_H;                          /* Battery Backup Memory 0 */
extern volatile unsigned int BAKMEM3;                           /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM3_L;                          /* Battery Backup Memory 0 */
extern volatile unsigned char BAKMEM3_H;                          /* Battery Backup Memory 0 */

/*************************************************************
* CRC Module
*************************************************************/




extern volatile unsigned int CRCDI;                             /* CRC Data In Register */
extern volatile unsigned char CRCDI_L;                            /* CRC Data In Register */
extern volatile unsigned char CRCDI_H;                            /* CRC Data In Register */
extern volatile unsigned int CRCDIRB;                           /* CRC data in reverse byte Register */
extern volatile unsigned char CRCDIRB_L;                          /* CRC data in reverse byte Register */
extern volatile unsigned char CRCDIRB_H;                          /* CRC data in reverse byte Register */
extern volatile unsigned int CRCINIRES;                         /* CRC Initialisation Register and Result Register */
extern volatile unsigned char CRCINIRES_L;                        /* CRC Initialisation Register and Result Register */
extern volatile unsigned char CRCINIRES_H;                        /* CRC Initialisation Register and Result Register */
extern volatile unsigned int CRCRESR;                           /* CRC reverse result Register */
extern volatile unsigned char CRCRESR_L;                          /* CRC reverse result Register */
extern volatile unsigned char CRCRESR_H;                          /* CRC reverse result Register */

/************************************************************
* DMA_X
************************************************************/




extern volatile unsigned int DMACTL0;                           /* DMA Module Control 0 */
extern volatile unsigned char DMACTL0_L;                          /* DMA Module Control 0 */
extern volatile unsigned char DMACTL0_H;                          /* DMA Module Control 0 */
extern volatile unsigned int DMACTL1;                           /* DMA Module Control 1 */
extern volatile unsigned char DMACTL1_L;                          /* DMA Module Control 1 */
extern volatile unsigned char DMACTL1_H;                          /* DMA Module Control 1 */
extern volatile unsigned int DMACTL2;                           /* DMA Module Control 2 */
extern volatile unsigned char DMACTL2_L;                          /* DMA Module Control 2 */
extern volatile unsigned char DMACTL2_H;                          /* DMA Module Control 2 */
extern volatile unsigned int DMACTL3;                           /* DMA Module Control 3 */
extern volatile unsigned char DMACTL3_L;                          /* DMA Module Control 3 */
extern volatile unsigned char DMACTL3_H;                          /* DMA Module Control 3 */
extern volatile unsigned int DMACTL4;                           /* DMA Module Control 4 */
extern volatile unsigned char DMACTL4_L;                          /* DMA Module Control 4 */
extern volatile unsigned char DMACTL4_H;                          /* DMA Module Control 4 */
extern volatile unsigned int DMAIV;                             /* DMA Interrupt Vector Word */
extern volatile unsigned char DMAIV_L;                            /* DMA Interrupt Vector Word */
extern volatile unsigned char DMAIV_H;                            /* DMA Interrupt Vector Word */

extern volatile unsigned int DMA0CTL;                           /* DMA Channel 0 Control */
extern volatile unsigned char DMA0CTL_L;                          /* DMA Channel 0 Control */
extern volatile unsigned char DMA0CTL_H;                          /* DMA Channel 0 Control */
extern __SFR_FARPTR DMA0SA;                            /* DMA Channel 0 Source Address */
extern volatile unsigned int DMA0SAL;                           /* DMA Channel 0 Source Address */
extern __SFR_FARPTR DMA0DA;                            /* DMA Channel 0 Destination Address */
extern volatile unsigned int DMA0DAL;                           /* DMA Channel 0 Destination Address */
extern volatile unsigned int DMA0SZ;                            /* DMA Channel 0 Transfer Size */

extern volatile unsigned int DMA1CTL;                           /* DMA Channel 1 Control */
extern volatile unsigned char DMA1CTL_L;                          /* DMA Channel 1 Control */
extern volatile unsigned char DMA1CTL_H;                          /* DMA Channel 1 Control */
extern __SFR_FARPTR DMA1SA;                            /* DMA Channel 1 Source Address */
extern volatile unsigned int DMA1SAL;                           /* DMA Channel 1 Source Address */
extern __SFR_FARPTR DMA1DA;                            /* DMA Channel 1 Destination Address */
extern volatile unsigned int DMA1DAL;                           /* DMA Channel 1 Destination Address */
extern volatile unsigned int DMA1SZ;                            /* DMA Channel 1 Transfer Size */

extern volatile unsigned int DMA2CTL;                           /* DMA Channel 2 Control */
extern volatile unsigned char DMA2CTL_L;                          /* DMA Channel 2 Control */
extern volatile unsigned char DMA2CTL_H;                          /* DMA Channel 2 Control */
extern __SFR_FARPTR DMA2SA;                            /* DMA Channel 2 Source Address */
extern volatile unsigned int DMA2SAL;                           /* DMA Channel 2 Source Address */
extern __SFR_FARPTR DMA2DA;                            /* DMA Channel 2 Destination Address */
extern volatile unsigned int DMA2DAL;                           /* DMA Channel 2 Destination Address */
extern volatile unsigned int DMA2SZ;                            /* DMA Channel 2 Transfer Size */

/* DMACTL0 Control Bits */
#line 742 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* DMACTL0 Control Bits */






/* DMACTL0 Control Bits */






/* DMACTL01 Control Bits */






/* DMACTL01 Control Bits */






/* DMACTL4 Control Bits */




/* DMACTL4 Control Bits */




/* DMAxCTL Control Bits */
#line 797 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* DMAxCTL Control Bits */
#line 807 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* DMAxCTL Control Bits */
#line 816 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
















#line 840 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* DMAIV Definitions */





#line 879 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 912 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 945 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 978 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1011 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1044 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/*************************************************************
* Flash Memory
*************************************************************/




extern volatile unsigned int FCTL1;                             /* FLASH Control 1 */
extern volatile unsigned char FCTL1_L;                            /* FLASH Control 1 */
extern volatile unsigned char FCTL1_H;                            /* FLASH Control 1 */
//sfrbw    FCTL2                  (0x0142)  /* FLASH Control 2 */
extern volatile unsigned int FCTL3;                             /* FLASH Control 3 */
extern volatile unsigned char FCTL3_L;                            /* FLASH Control 3 */
extern volatile unsigned char FCTL3_H;                            /* FLASH Control 3 */
extern volatile unsigned int FCTL4;                             /* FLASH Control 4 */
extern volatile unsigned char FCTL4_L;                            /* FLASH Control 4 */
extern volatile unsigned char FCTL4_H;                            /* FLASH Control 4 */

#line 1069 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* FCTL1 Control Bits */
//#define RESERVED            (0x0001)  /* Reserved */


//#define RESERVED            (0x0008)  /* Reserved */
//#define RESERVED            (0x0010)  /* Reserved */




/* FCTL1 Control Bits */
//#define RESERVED            (0x0001)  /* Reserved */


//#define RESERVED            (0x0008)  /* Reserved */
//#define RESERVED            (0x0010)  /* Reserved */




/* FCTL3 Control Bits */
#line 1098 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0080)  /* Reserved */

/* FCTL3 Control Bits */
#line 1108 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0080)  /* Reserved */

/* FCTL4 Control Bits */





/* FCTL4 Control Bits */





/************************************************************
* LCD_C
************************************************************/




extern volatile unsigned int LCDCCTL0;                          /* LCD_C Control Register 0 */
extern volatile unsigned char LCDCCTL0_L;                         /* LCD_C Control Register 0 */
extern volatile unsigned char LCDCCTL0_H;                         /* LCD_C Control Register 0 */
extern volatile unsigned int LCDCCTL1;                          /* LCD_C Control Register 1 */
extern volatile unsigned char LCDCCTL1_L;                         /* LCD_C Control Register 1 */
extern volatile unsigned char LCDCCTL1_H;                         /* LCD_C Control Register 1 */
extern volatile unsigned int LCDCBLKCTL;                        /* LCD_C blinking control register */
extern volatile unsigned char LCDCBLKCTL_L;                       /* LCD_C blinking control register */
extern volatile unsigned char LCDCBLKCTL_H;                       /* LCD_C blinking control register */
extern volatile unsigned int LCDCMEMCTL;                        /* LCD_C memory control register */
extern volatile unsigned char LCDCMEMCTL_L;                       /* LCD_C memory control register */
extern volatile unsigned char LCDCMEMCTL_H;                       /* LCD_C memory control register */
extern volatile unsigned int LCDCVCTL;                          /* LCD_C Voltage Control Register */
extern volatile unsigned char LCDCVCTL_L;                         /* LCD_C Voltage Control Register */
extern volatile unsigned char LCDCVCTL_H;                         /* LCD_C Voltage Control Register */
extern volatile unsigned int LCDCPCTL0;                         /* LCD_C Port Control Register 0 */
extern volatile unsigned char LCDCPCTL0_L;                        /* LCD_C Port Control Register 0 */
extern volatile unsigned char LCDCPCTL0_H;                        /* LCD_C Port Control Register 0 */
extern volatile unsigned int LCDCPCTL1;                         /* LCD_C Port Control Register 1 */
extern volatile unsigned char LCDCPCTL1_L;                        /* LCD_C Port Control Register 1 */
extern volatile unsigned char LCDCPCTL1_H;                        /* LCD_C Port Control Register 1 */
extern volatile unsigned int LCDCPCTL2;                         /* LCD_C Port Control Register 2 */
extern volatile unsigned char LCDCPCTL2_L;                        /* LCD_C Port Control Register 2 */
extern volatile unsigned char LCDCPCTL2_H;                        /* LCD_C Port Control Register 2 */
extern volatile unsigned int LCDCCPCTL;                         /* LCD_C Charge Pump Control Register 3 */
extern volatile unsigned char LCDCCPCTL_L;                        /* LCD_C Charge Pump Control Register 3 */
extern volatile unsigned char LCDCCPCTL_H;                        /* LCD_C Charge Pump Control Register 3 */
extern volatile unsigned int LCDCIV;                            /* LCD_C Interrupt Vector Register */

// LCDCCTL0
#line 1165 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0040)  /* LCD_C RESERVED */
#line 1175 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCTL0
#line 1183 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0040)  /* LCD_C RESERVED */


// LCDCCTL0
//#define RESERVED            (0x0040)  /* LCD_C RESERVED */
#line 1196 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1209 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1274 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Display modes coded with Bits 2-4 */
#line 1284 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCTL1
#line 1294 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCTL1





// LCDCCTL1





// LCDCBLKCTL
#line 1316 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCBLKCTL
#line 1326 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






// LCDCMEMCTL




// LCDCMEMCTL




// LCDCVCTL
#line 1357 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCVCTL
#line 1367 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCVCTL
#line 1375 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Reference voltage source select for the regulated charge pump */





/* Charge pump voltage selections */
#line 1399 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1416 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL0
#line 1434 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL0
#line 1444 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL0
#line 1454 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL1
#line 1472 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL1
#line 1482 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL1
#line 1492 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL2
#line 1510 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL2
#line 1520 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCPCTL2
#line 1530 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCPCTL
#line 1541 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCPCTL
#line 1551 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// LCDCCPCTL


extern volatile unsigned char LCDM1;                              /* LCD Memory 1 */
#line 1562 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
extern volatile unsigned char LCDM2;                              /* LCD Memory 2 */
extern volatile unsigned char LCDM3;                              /* LCD Memory 3 */
extern volatile unsigned char LCDM4;                              /* LCD Memory 4 */
extern volatile unsigned char LCDM5;                              /* LCD Memory 5 */
extern volatile unsigned char LCDM6;                              /* LCD Memory 6 */
extern volatile unsigned char LCDM7;                              /* LCD Memory 7 */
extern volatile unsigned char LCDM8;                              /* LCD Memory 8 */
extern volatile unsigned char LCDM9;                              /* LCD Memory 9 */
extern volatile unsigned char LCDM10;                             /* LCD Memory 10 */
extern volatile unsigned char LCDM11;                             /* LCD Memory 11 */
extern volatile unsigned char LCDM12;                             /* LCD Memory 12 */
extern volatile unsigned char LCDM13;                             /* LCD Memory 13 */
extern volatile unsigned char LCDM14;                             /* LCD Memory 14 */
extern volatile unsigned char LCDM15;                             /* LCD Memory 15 */
extern volatile unsigned char LCDM16;                             /* LCD Memory 16 */
extern volatile unsigned char LCDM17;                             /* LCD Memory 17 */
extern volatile unsigned char LCDM18;                             /* LCD Memory 18 */
extern volatile unsigned char LCDM19;                             /* LCD Memory 19 */
extern volatile unsigned char LCDM20;                             /* LCD Memory 20 */
extern volatile unsigned char LCDM21;                             /* LCD Memory 21 */
extern volatile unsigned char LCDM22;                             /* LCD Memory 22 */
extern volatile unsigned char LCDM23;                             /* LCD Memory 23 */
extern volatile unsigned char LCDM24;                             /* LCD Memory 24 */
extern volatile unsigned char LCDM25;                             /* LCD Memory 25 */
extern volatile unsigned char LCDM26;                             /* LCD Memory 26 */
extern volatile unsigned char LCDM27;                             /* LCD Memory 27 */
extern volatile unsigned char LCDM28;                             /* LCD Memory 28 */
extern volatile unsigned char LCDM29;                             /* LCD Memory 29 */
extern volatile unsigned char LCDM30;                             /* LCD Memory 30 */
extern volatile unsigned char LCDM31;                             /* LCD Memory 31 */
extern volatile unsigned char LCDM32;                             /* LCD Memory 32 */
extern volatile unsigned char LCDM33;                             /* LCD Memory 33 */
extern volatile unsigned char LCDM34;                             /* LCD Memory 34 */
extern volatile unsigned char LCDM35;                             /* LCD Memory 35 */
extern volatile unsigned char LCDM36;                             /* LCD Memory 36 */
extern volatile unsigned char LCDM37;                             /* LCD Memory 37 */
extern volatile unsigned char LCDM38;                             /* LCD Memory 38 */
extern volatile unsigned char LCDM39;                             /* LCD Memory 39 */
extern volatile unsigned char LCDM40;                             /* LCD Memory 40 */

extern volatile unsigned char LCDBM1;                             /* LCD Blinking Memory 1 */
#line 1609 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
extern volatile unsigned char LCDBM2;                             /* LCD Blinking Memory 2 */
extern volatile unsigned char LCDBM3;                             /* LCD Blinking Memory 3 */
extern volatile unsigned char LCDBM4;                             /* LCD Blinking Memory 4 */
extern volatile unsigned char LCDBM5;                             /* LCD Blinking Memory 5 */
extern volatile unsigned char LCDBM6;                             /* LCD Blinking Memory 6 */
extern volatile unsigned char LCDBM7;                             /* LCD Blinking Memory 7 */
extern volatile unsigned char LCDBM8;                             /* LCD Blinking Memory 8 */
extern volatile unsigned char LCDBM9;                             /* LCD Blinking Memory 9 */
extern volatile unsigned char LCDBM10;                            /* LCD Blinking Memory 10 */
extern volatile unsigned char LCDBM11;                            /* LCD Blinking Memory 11 */
extern volatile unsigned char LCDBM12;                            /* LCD Blinking Memory 12 */
extern volatile unsigned char LCDBM13;                            /* LCD Blinking Memory 13 */
extern volatile unsigned char LCDBM14;                            /* LCD Blinking Memory 14 */
extern volatile unsigned char LCDBM15;                            /* LCD Blinking Memory 15 */
extern volatile unsigned char LCDBM16;                            /* LCD Blinking Memory 16 */
extern volatile unsigned char LCDBM17;                            /* LCD Blinking Memory 17 */
extern volatile unsigned char LCDBM18;                            /* LCD Blinking Memory 18 */
extern volatile unsigned char LCDBM19;                            /* LCD Blinking Memory 19 */
extern volatile unsigned char LCDBM20;                            /* LCD Blinking Memory 20 */

/* LCDCIV Definitions */






/************************************************************
* HARDWARE MULTIPLIER 32Bit
************************************************************/




extern volatile unsigned int MPY;                               /* Multiply Unsigned/Operand 1 */
extern volatile unsigned char MPY_L;                              /* Multiply Unsigned/Operand 1 */
extern volatile unsigned char MPY_H;                              /* Multiply Unsigned/Operand 1 */
extern volatile unsigned int MPYS;                              /* Multiply Signed/Operand 1 */
extern volatile unsigned char MPYS_L;                             /* Multiply Signed/Operand 1 */
extern volatile unsigned char MPYS_H;                             /* Multiply Signed/Operand 1 */
extern volatile unsigned int MAC;                               /* Multiply Unsigned and Accumulate/Operand 1 */
extern volatile unsigned char MAC_L;                              /* Multiply Unsigned and Accumulate/Operand 1 */
extern volatile unsigned char MAC_H;                              /* Multiply Unsigned and Accumulate/Operand 1 */
extern volatile unsigned int MACS;                              /* Multiply Signed and Accumulate/Operand 1 */
extern volatile unsigned char MACS_L;                             /* Multiply Signed and Accumulate/Operand 1 */
extern volatile unsigned char MACS_H;                             /* Multiply Signed and Accumulate/Operand 1 */
extern volatile unsigned int OP2;                               /* Operand 2 */
extern volatile unsigned char OP2_L;                              /* Operand 2 */
extern volatile unsigned char OP2_H;                              /* Operand 2 */
extern volatile unsigned int RESLO;                             /* Result Low Word */
extern volatile unsigned char RESLO_L;                            /* Result Low Word */
extern volatile unsigned char RESLO_H;                            /* Result Low Word */
extern volatile unsigned int RESHI;                             /* Result High Word */
extern volatile unsigned char RESHI_L;                            /* Result High Word */
extern volatile unsigned char RESHI_H;                            /* Result High Word */
extern volatile unsigned int SUMEXT;                            /* Sum Extend */
extern volatile unsigned char SUMEXT_L;                           /* Sum Extend */
extern volatile unsigned char SUMEXT_H;                           /* Sum Extend */

extern volatile unsigned int MPY32L;                            /* 32-bit operand 1 - multiply - low word */
extern volatile unsigned char MPY32L_L;                           /* 32-bit operand 1 - multiply - low word */
extern volatile unsigned char MPY32L_H;                           /* 32-bit operand 1 - multiply - low word */
extern volatile unsigned int MPY32H;                            /* 32-bit operand 1 - multiply - high word */
extern volatile unsigned char MPY32H_L;                           /* 32-bit operand 1 - multiply - high word */
extern volatile unsigned char MPY32H_H;                           /* 32-bit operand 1 - multiply - high word */
extern volatile unsigned int MPYS32L;                           /* 32-bit operand 1 - signed multiply - low word */
extern volatile unsigned char MPYS32L_L;                          /* 32-bit operand 1 - signed multiply - low word */
extern volatile unsigned char MPYS32L_H;                          /* 32-bit operand 1 - signed multiply - low word */
extern volatile unsigned int MPYS32H;                           /* 32-bit operand 1 - signed multiply - high word */
extern volatile unsigned char MPYS32H_L;                          /* 32-bit operand 1 - signed multiply - high word */
extern volatile unsigned char MPYS32H_H;                          /* 32-bit operand 1 - signed multiply - high word */
extern volatile unsigned int MAC32L;                            /* 32-bit operand 1 - multiply accumulate - low word */
extern volatile unsigned char MAC32L_L;                           /* 32-bit operand 1 - multiply accumulate - low word */
extern volatile unsigned char MAC32L_H;                           /* 32-bit operand 1 - multiply accumulate - low word */
extern volatile unsigned int MAC32H;                            /* 32-bit operand 1 - multiply accumulate - high word */
extern volatile unsigned char MAC32H_L;                           /* 32-bit operand 1 - multiply accumulate - high word */
extern volatile unsigned char MAC32H_H;                           /* 32-bit operand 1 - multiply accumulate - high word */
extern volatile unsigned int MACS32L;                           /* 32-bit operand 1 - signed multiply accumulate - low word */
extern volatile unsigned char MACS32L_L;                          /* 32-bit operand 1 - signed multiply accumulate - low word */
extern volatile unsigned char MACS32L_H;                          /* 32-bit operand 1 - signed multiply accumulate - low word */
extern volatile unsigned int MACS32H;                           /* 32-bit operand 1 - signed multiply accumulate - high word */
extern volatile unsigned char MACS32H_L;                          /* 32-bit operand 1 - signed multiply accumulate - high word */
extern volatile unsigned char MACS32H_H;                          /* 32-bit operand 1 - signed multiply accumulate - high word */
extern volatile unsigned int OP2L;                              /* 32-bit operand 2 - low word */
extern volatile unsigned char OP2L_L;                             /* 32-bit operand 2 - low word */
extern volatile unsigned char OP2L_H;                             /* 32-bit operand 2 - low word */
extern volatile unsigned int OP2H;                              /* 32-bit operand 2 - high word */
extern volatile unsigned char OP2H_L;                             /* 32-bit operand 2 - high word */
extern volatile unsigned char OP2H_H;                             /* 32-bit operand 2 - high word */
extern volatile unsigned int RES0;                              /* 32x32-bit result 0 - least significant word */
extern volatile unsigned char RES0_L;                             /* 32x32-bit result 0 - least significant word */
extern volatile unsigned char RES0_H;                             /* 32x32-bit result 0 - least significant word */
extern volatile unsigned int RES1;                              /* 32x32-bit result 1 */
extern volatile unsigned char RES1_L;                             /* 32x32-bit result 1 */
extern volatile unsigned char RES1_H;                             /* 32x32-bit result 1 */
extern volatile unsigned int RES2;                              /* 32x32-bit result 2 */
extern volatile unsigned char RES2_L;                             /* 32x32-bit result 2 */
extern volatile unsigned char RES2_H;                             /* 32x32-bit result 2 */
extern volatile unsigned int RES3;                              /* 32x32-bit result 3 - most significant word */
extern volatile unsigned char RES3_L;                             /* 32x32-bit result 3 - most significant word */
extern volatile unsigned char RES3_H;                             /* 32x32-bit result 3 - most significant word */
extern volatile unsigned int MPY32CTL0;                         /* MPY32 Control Register 0 */
extern volatile unsigned char MPY32CTL0_L;                        /* MPY32 Control Register 0 */
extern volatile unsigned char MPY32CTL0_H;                        /* MPY32 Control Register 0 */

#line 1729 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* MPY32CTL0 Control Bits */

//#define RESERVED            (0x0002)  /* Reserved */
#line 1741 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* MPY32CTL0 Control Bits */

//#define RESERVED            (0x0002)  /* Reserved */
#line 1751 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* MPY32CTL0 Control Bits */
//#define RESERVED            (0x0002)  /* Reserved */



#line 1765 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* DIGITAL I/O Port1/2 Pull up / Pull down Resistors
************************************************************/
#line 1778 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

extern volatile unsigned int PAIN;                              /* Port A Input */
extern volatile unsigned char PAIN_L;                             /* Port A Input */
extern volatile unsigned char PAIN_H;                             /* Port A Input */
extern volatile unsigned int PAOUT;                             /* Port A Output */
extern volatile unsigned char PAOUT_L;                            /* Port A Output */
extern volatile unsigned char PAOUT_H;                            /* Port A Output */
extern volatile unsigned int PADIR;                             /* Port A Direction */
extern volatile unsigned char PADIR_L;                            /* Port A Direction */
extern volatile unsigned char PADIR_H;                            /* Port A Direction */
extern volatile unsigned int PAREN;                             /* Port A Resistor Enable */
extern volatile unsigned char PAREN_L;                            /* Port A Resistor Enable */
extern volatile unsigned char PAREN_H;                            /* Port A Resistor Enable */
extern volatile unsigned int PADS;                              /* Port A Drive Strenght */
extern volatile unsigned char PADS_L;                             /* Port A Drive Strenght */
extern volatile unsigned char PADS_H;                             /* Port A Drive Strenght */
extern volatile unsigned int PASEL;                             /* Port A Selection */
extern volatile unsigned char PASEL_L;                            /* Port A Selection */
extern volatile unsigned char PASEL_H;                            /* Port A Selection */
extern volatile unsigned int PAIES;                             /* Port A Interrupt Edge Select */
extern volatile unsigned char PAIES_L;                            /* Port A Interrupt Edge Select */
extern volatile unsigned char PAIES_H;                            /* Port A Interrupt Edge Select */
extern volatile unsigned int PAIE;                              /* Port A Interrupt Enable */
extern volatile unsigned char PAIE_L;                             /* Port A Interrupt Enable */
extern volatile unsigned char PAIE_H;                             /* Port A Interrupt Enable */
extern volatile unsigned int PAIFG;                             /* Port A Interrupt Flag */
extern volatile unsigned char PAIFG_L;                            /* Port A Interrupt Flag */
extern volatile unsigned char PAIFG_H;                            /* Port A Interrupt Flag */


extern volatile unsigned int P1IV;                              /* Port 1 Interrupt Vector Word */
extern volatile unsigned int P2IV;                              /* Port 2 Interrupt Vector Word */
#line 1819 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

//Definitions for P1IV
#line 1830 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1840 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

//Definitions for P2IV
#line 1851 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* DIGITAL I/O Port3/4 Pull up / Pull down Resistors
************************************************************/
#line 1865 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

extern volatile unsigned int PBIN;                              /* Port B Input */
extern volatile unsigned char PBIN_L;                             /* Port B Input */
extern volatile unsigned char PBIN_H;                             /* Port B Input */
extern volatile unsigned int PBOUT;                             /* Port B Output */
extern volatile unsigned char PBOUT_L;                            /* Port B Output */
extern volatile unsigned char PBOUT_H;                            /* Port B Output */
extern volatile unsigned int PBDIR;                             /* Port B Direction */
extern volatile unsigned char PBDIR_L;                            /* Port B Direction */
extern volatile unsigned char PBDIR_H;                            /* Port B Direction */
extern volatile unsigned int PBREN;                             /* Port B Resistor Enable */
extern volatile unsigned char PBREN_L;                            /* Port B Resistor Enable */
extern volatile unsigned char PBREN_H;                            /* Port B Resistor Enable */
extern volatile unsigned int PBDS;                              /* Port B Drive Strenght */
extern volatile unsigned char PBDS_L;                             /* Port B Drive Strenght */
extern volatile unsigned char PBDS_H;                             /* Port B Drive Strenght */
extern volatile unsigned int PBSEL;                             /* Port B Selection */
extern volatile unsigned char PBSEL_L;                            /* Port B Selection */
extern volatile unsigned char PBSEL_H;                            /* Port B Selection */


#line 1892 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1899 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* DIGITAL I/O Port5/6 Pull up / Pull down Resistors
************************************************************/
#line 1913 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

extern volatile unsigned int PCIN;                              /* Port C Input */
extern volatile unsigned char PCIN_L;                             /* Port C Input */
extern volatile unsigned char PCIN_H;                             /* Port C Input */
extern volatile unsigned int PCOUT;                             /* Port C Output */
extern volatile unsigned char PCOUT_L;                            /* Port C Output */
extern volatile unsigned char PCOUT_H;                            /* Port C Output */
extern volatile unsigned int PCDIR;                             /* Port C Direction */
extern volatile unsigned char PCDIR_L;                            /* Port C Direction */
extern volatile unsigned char PCDIR_H;                            /* Port C Direction */
extern volatile unsigned int PCREN;                             /* Port C Resistor Enable */
extern volatile unsigned char PCREN_L;                            /* Port C Resistor Enable */
extern volatile unsigned char PCREN_H;                            /* Port C Resistor Enable */
extern volatile unsigned int PCDS;                              /* Port C Drive Strenght */
extern volatile unsigned char PCDS_L;                             /* Port C Drive Strenght */
extern volatile unsigned char PCDS_H;                             /* Port C Drive Strenght */
extern volatile unsigned int PCSEL;                             /* Port C Selection */
extern volatile unsigned char PCSEL_L;                            /* Port C Selection */
extern volatile unsigned char PCSEL_H;                            /* Port C Selection */


#line 1940 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1947 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* DIGITAL I/O Port7/8 Pull up / Pull down Resistors
************************************************************/
#line 1961 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

extern volatile unsigned int PDIN;                              /* Port D Input */
extern volatile unsigned char PDIN_L;                             /* Port D Input */
extern volatile unsigned char PDIN_H;                             /* Port D Input */
extern volatile unsigned int PDOUT;                             /* Port D Output */
extern volatile unsigned char PDOUT_L;                            /* Port D Output */
extern volatile unsigned char PDOUT_H;                            /* Port D Output */
extern volatile unsigned int PDDIR;                             /* Port D Direction */
extern volatile unsigned char PDDIR_L;                            /* Port D Direction */
extern volatile unsigned char PDDIR_H;                            /* Port D Direction */
extern volatile unsigned int PDREN;                             /* Port D Resistor Enable */
extern volatile unsigned char PDREN_L;                            /* Port D Resistor Enable */
extern volatile unsigned char PDREN_H;                            /* Port D Resistor Enable */
extern volatile unsigned int PDDS;                              /* Port D Drive Strenght */
extern volatile unsigned char PDDS_L;                             /* Port D Drive Strenght */
extern volatile unsigned char PDDS_H;                             /* Port D Drive Strenght */
extern volatile unsigned int PDSEL;                             /* Port D Selection */
extern volatile unsigned char PDSEL_L;                            /* Port D Selection */
extern volatile unsigned char PDSEL_H;                            /* Port D Selection */


#line 1988 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 1995 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* DIGITAL I/O Port9 Pull up / Pull down Resistors
************************************************************/
#line 2006 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

extern volatile unsigned int PEIN;                              /* Port E Input */
extern volatile unsigned char PEIN_L;                             /* Port E Input */
extern volatile unsigned char PEIN_H;                             /* Port E Input */
extern volatile unsigned int PEOUT;                             /* Port E Output */
extern volatile unsigned char PEOUT_L;                            /* Port E Output */
extern volatile unsigned char PEOUT_H;                            /* Port E Output */
extern volatile unsigned int PEDIR;                             /* Port E Direction */
extern volatile unsigned char PEDIR_L;                            /* Port E Direction */
extern volatile unsigned char PEDIR_H;                            /* Port E Direction */
extern volatile unsigned int PEREN;                             /* Port E Resistor Enable */
extern volatile unsigned char PEREN_L;                            /* Port E Resistor Enable */
extern volatile unsigned char PEREN_H;                            /* Port E Resistor Enable */
extern volatile unsigned int PEDS;                              /* Port E Drive Strenght */
extern volatile unsigned char PEDS_L;                             /* Port E Drive Strenght */
extern volatile unsigned char PEDS_H;                             /* Port E Drive Strenght */
extern volatile unsigned int PESEL;                             /* Port E Selection */
extern volatile unsigned char PESEL_L;                            /* Port E Selection */
extern volatile unsigned char PESEL_H;                            /* Port E Selection */


#line 2033 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* DIGITAL I/O PortJ Pull up / Pull down Resistors
************************************************************/




extern volatile unsigned int PJIN;                              /* Port J Input */
extern volatile unsigned char PJIN_L;                             /* Port J Input */
extern volatile unsigned char PJIN_H;                             /* Port J Input */
extern volatile unsigned int PJOUT;                             /* Port J Output */
extern volatile unsigned char PJOUT_L;                            /* Port J Output */
extern volatile unsigned char PJOUT_H;                            /* Port J Output */
extern volatile unsigned int PJDIR;                             /* Port J Direction */
extern volatile unsigned char PJDIR_L;                            /* Port J Direction */
extern volatile unsigned char PJDIR_H;                            /* Port J Direction */
extern volatile unsigned int PJREN;                             /* Port J Resistor Enable */
extern volatile unsigned char PJREN_L;                            /* Port J Resistor Enable */
extern volatile unsigned char PJREN_H;                            /* Port J Resistor Enable */
extern volatile unsigned int PJDS;                              /* Port J Drive Strenght */
extern volatile unsigned char PJDS_L;                             /* Port J Drive Strenght */
extern volatile unsigned char PJDS_H;                             /* Port J Drive Strenght */
extern volatile unsigned int PJSEL;                             /* Port J Selection */
extern volatile unsigned char PJSEL_L;                            /* Port J Selection */
extern volatile unsigned char PJSEL_H;                            /* Port J Selection */

/************************************************************
* PORT MAPPING CONTROLLER
************************************************************/




extern volatile unsigned int PMAPKEYID;                         /* Port Mapping Key register */
extern volatile unsigned char PMAPKEYID_L;                        /* Port Mapping Key register */
extern volatile unsigned char PMAPKEYID_H;                        /* Port Mapping Key register */
extern volatile unsigned int PMAPCTL;                           /* Port Mapping control register */
extern volatile unsigned char PMAPCTL_L;                          /* Port Mapping control register */
extern volatile unsigned char PMAPCTL_H;                          /* Port Mapping control register */





/* PMAPCTL Control Bits */



/* PMAPCTL Control Bits */



/************************************************************
* PORT 1 MAPPING CONTROLLER
************************************************************/




extern volatile unsigned int P1MAP01;                           /* Port P1.0/1 mapping register */
extern volatile unsigned char P1MAP01_L;                          /* Port P1.0/1 mapping register */
extern volatile unsigned char P1MAP01_H;                          /* Port P1.0/1 mapping register */
extern volatile unsigned int P1MAP23;                           /* Port P1.2/3 mapping register */
extern volatile unsigned char P1MAP23_L;                          /* Port P1.2/3 mapping register */
extern volatile unsigned char P1MAP23_H;                          /* Port P1.2/3 mapping register */
extern volatile unsigned int P1MAP45;                           /* Port P1.4/5 mapping register */
extern volatile unsigned char P1MAP45_L;                          /* Port P1.4/5 mapping register */
extern volatile unsigned char P1MAP45_H;                          /* Port P1.4/5 mapping register */
extern volatile unsigned int P1MAP67;                           /* Port P1.6/7 mapping register */
extern volatile unsigned char P1MAP67_L;                          /* Port P1.6/7 mapping register */
extern volatile unsigned char P1MAP67_H;                          /* Port P1.6/7 mapping register */

#line 2115 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* PORT 2 MAPPING CONTROLLER
************************************************************/




extern volatile unsigned int P2MAP01;                           /* Port P2.0/1 mapping register */
extern volatile unsigned char P2MAP01_L;                          /* Port P2.0/1 mapping register */
extern volatile unsigned char P2MAP01_H;                          /* Port P2.0/1 mapping register */
extern volatile unsigned int P2MAP23;                           /* Port P2.2/3 mapping register */
extern volatile unsigned char P2MAP23_L;                          /* Port P2.2/3 mapping register */
extern volatile unsigned char P2MAP23_H;                          /* Port P2.2/3 mapping register */
extern volatile unsigned int P2MAP45;                           /* Port P2.4/5 mapping register */
extern volatile unsigned char P2MAP45_L;                          /* Port P2.4/5 mapping register */
extern volatile unsigned char P2MAP45_H;                          /* Port P2.4/5 mapping register */
extern volatile unsigned int P2MAP67;                           /* Port P2.6/7 mapping register */
extern volatile unsigned char P2MAP67_L;                          /* Port P2.6/7 mapping register */
extern volatile unsigned char P2MAP67_H;                          /* Port P2.6/7 mapping register */

#line 2144 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* PORT 3 MAPPING CONTROLLER
************************************************************/




extern volatile unsigned int P3MAP01;                           /* Port P3.0/1 mapping register */
extern volatile unsigned char P3MAP01_L;                          /* Port P3.0/1 mapping register */
extern volatile unsigned char P3MAP01_H;                          /* Port P3.0/1 mapping register */
extern volatile unsigned int P3MAP23;                           /* Port P3.2/3 mapping register */
extern volatile unsigned char P3MAP23_L;                          /* Port P3.2/3 mapping register */
extern volatile unsigned char P3MAP23_H;                          /* Port P3.2/3 mapping register */
extern volatile unsigned int P3MAP45;                           /* Port P3.4/5 mapping register */
extern volatile unsigned char P3MAP45_L;                          /* Port P3.4/5 mapping register */
extern volatile unsigned char P3MAP45_H;                          /* Port P3.4/5 mapping register */
extern volatile unsigned int P3MAP67;                           /* Port P3.6/7 mapping register */
extern volatile unsigned char P3MAP67_L;                          /* Port P3.6/7 mapping register */
extern volatile unsigned char P3MAP67_H;                          /* Port P3.6/7 mapping register */

#line 2173 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2215 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* PMM - Power Management System
************************************************************/




extern volatile unsigned int PMMCTL0;                           /* PMM Control 0 */
extern volatile unsigned char PMMCTL0_L;                          /* PMM Control 0 */
extern volatile unsigned char PMMCTL0_H;                          /* PMM Control 0 */
extern volatile unsigned int PMMCTL1;                           /* PMM Control 1 */
extern volatile unsigned char PMMCTL1_L;                          /* PMM Control 1 */
extern volatile unsigned char PMMCTL1_H;                          /* PMM Control 1 */
extern volatile unsigned int SVSMHCTL;                          /* SVS and SVM high side control register */
extern volatile unsigned char SVSMHCTL_L;                         /* SVS and SVM high side control register */
extern volatile unsigned char SVSMHCTL_H;                         /* SVS and SVM high side control register */
extern volatile unsigned int SVSMLCTL;                          /* SVS and SVM low side control register */
extern volatile unsigned char SVSMLCTL_L;                         /* SVS and SVM low side control register */
extern volatile unsigned char SVSMLCTL_H;                         /* SVS and SVM low side control register */
extern volatile unsigned int SVSMIO;                            /* SVSIN and SVSOUT control register */
extern volatile unsigned char SVSMIO_L;                           /* SVSIN and SVSOUT control register */
extern volatile unsigned char SVSMIO_H;                           /* SVSIN and SVSOUT control register */
extern volatile unsigned int PMMIFG;                            /* PMM Interrupt Flag */
extern volatile unsigned char PMMIFG_L;                           /* PMM Interrupt Flag */
extern volatile unsigned char PMMIFG_H;                           /* PMM Interrupt Flag */
extern volatile unsigned int PMMRIE;                            /* PMM and RESET Interrupt Enable */
extern volatile unsigned char PMMRIE_L;                           /* PMM and RESET Interrupt Enable */
extern volatile unsigned char PMMRIE_H;                           /* PMM and RESET Interrupt Enable */
extern volatile unsigned int PM5CTL0;                           /* PMM Power Mode 5 Control Register 0 */
extern volatile unsigned char PM5CTL0_L;                          /* PMM Power Mode 5 Control Register 0 */
extern volatile unsigned char PM5CTL0_H;                          /* PMM Power Mode 5 Control Register 0 */




/* PMMCTL0 Control Bits */
#line 2258 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* PMMCTL0 Control Bits */
#line 2266 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* PMMCTL1 Control Bits */




/* PMMCTL1 Control Bits */




/* SVSMHCTL Control Bits */
#line 2297 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SVSMHCTL Control Bits */
#line 2306 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SVSMHCTL Control Bits */
#line 2315 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2324 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* SVSMLCTL Control Bits */
#line 2345 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SVSMLCTL Control Bits */
#line 2354 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SVSMLCTL Control Bits */
#line 2363 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2372 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* SVSMIO Control Bits */






/* SVSMIO Control Bits */




/* SVSMIO Control Bits */



/* PMMIFG Control Bits */
#line 2407 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* PMMIFG Control Bits */
#line 2415 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* PMMIFG Control Bits */
#line 2423 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"



/* PMMIE and RESET Control Bits */
#line 2437 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* PMMIE and RESET Control Bits */
#line 2445 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* PMMIE and RESET Control Bits */





/* PM5CTL0 Power Mode 5 Control Bits */


/* PM5CTL0 Power Mode 5 Control Bits */




/*************************************************************
* RAM Control Module
*************************************************************/




extern volatile unsigned int RCCTL0;                            /* Ram Controller Control Register */
extern volatile unsigned char RCCTL0_L;                           /* Ram Controller Control Register */
extern volatile unsigned char RCCTL0_H;                           /* Ram Controller Control Register */

/* RCCTL0 Control Bits */





/* RCCTL0 Control Bits */







/************************************************************
* Shared Reference
************************************************************/




extern volatile unsigned int REFCTL0;                           /* REF Shared Reference control register 0 */
extern volatile unsigned char REFCTL0_L;                          /* REF Shared Reference control register 0 */
extern volatile unsigned char REFCTL0_H;                          /* REF Shared Reference control register 0 */

/* REFCTL0 Control Bits */


//#define RESERVED            (0x0004)  /* Reserved */



//#define RESERVED            (0x0040)  /* Reserved */





//#define RESERVED            (0x1000)  /* Reserved */
//#define RESERVED            (0x2000)  /* Reserved */
//#define RESERVED            (0x4000)  /* Reserved */
//#define RESERVED            (0x8000)  /* Reserved */

/* REFCTL0 Control Bits */


//#define RESERVED            (0x0004)  /* Reserved */



//#define RESERVED            (0x0040)  /* Reserved */

//#define RESERVED            (0x1000)  /* Reserved */
//#define RESERVED            (0x2000)  /* Reserved */
//#define RESERVED            (0x4000)  /* Reserved */
//#define RESERVED            (0x8000)  /* Reserved */

/* REFCTL0 Control Bits */
//#define RESERVED            (0x0004)  /* Reserved */
//#define RESERVED            (0x0040)  /* Reserved */




//#define RESERVED            (0x1000)  /* Reserved */
//#define RESERVED            (0x2000)  /* Reserved */
//#define RESERVED            (0x4000)  /* Reserved */
//#define RESERVED            (0x8000)  /* Reserved */






/************************************************************
* Real Time Clock
************************************************************/




extern volatile unsigned int RTCCTL0;                           /* Real Timer Clock Control 0/Key */
extern volatile unsigned char RTCCTL0_L;                          /* Real Timer Clock Control 0/Key */
extern volatile unsigned char RTCCTL0_H;                          /* Real Timer Clock Control 0/Key */
extern volatile unsigned int RTCCTL13;                          /* Real Timer Clock Control 1/3 */
extern volatile unsigned char RTCCTL13_L;                         /* Real Timer Clock Control 1/3 */
extern volatile unsigned char RTCCTL13_H;                         /* Real Timer Clock Control 1/3 */


extern volatile unsigned int RTCOCAL;                           /* Real Timer Clock Offset Calibartion */
extern volatile unsigned char RTCOCAL_L;                          /* Real Timer Clock Offset Calibartion */
extern volatile unsigned char RTCOCAL_H;                          /* Real Timer Clock Offset Calibartion */
extern volatile unsigned int RTCTCMP;                           /* Real Timer Temperature Compensation */
extern volatile unsigned char RTCTCMP_L;                          /* Real Timer Temperature Compensation */
extern volatile unsigned char RTCTCMP_H;                          /* Real Timer Temperature Compensation */
extern volatile unsigned int RTCPS0CTL;                         /* Real Timer Prescale Timer 0 Control */
extern volatile unsigned char RTCPS0CTL_L;                        /* Real Timer Prescale Timer 0 Control */
extern volatile unsigned char RTCPS0CTL_H;                        /* Real Timer Prescale Timer 0 Control */
extern volatile unsigned int RTCPS1CTL;                         /* Real Timer Prescale Timer 1 Control */
extern volatile unsigned char RTCPS1CTL_L;                        /* Real Timer Prescale Timer 1 Control */
extern volatile unsigned char RTCPS1CTL_H;                        /* Real Timer Prescale Timer 1 Control */
extern volatile unsigned int RTCPS;                             /* Real Timer Prescale Timer Control */
extern volatile unsigned char RTCPS_L;                            /* Real Timer Prescale Timer Control */
extern volatile unsigned char RTCPS_H;                            /* Real Timer Prescale Timer Control */
extern volatile unsigned int RTCIV;                             /* Real Time Clock Interrupt Vector */
extern volatile unsigned int RTCTIM0;                           /* Real Time Clock Time 0 */
extern volatile unsigned char RTCTIM0_L;                          /* Real Time Clock Time 0 */
extern volatile unsigned char RTCTIM0_H;                          /* Real Time Clock Time 0 */
extern volatile unsigned int RTCTIM1;                           /* Real Time Clock Time 1 */
extern volatile unsigned char RTCTIM1_L;                          /* Real Time Clock Time 1 */
extern volatile unsigned char RTCTIM1_H;                          /* Real Time Clock Time 1 */
extern volatile unsigned int RTCDATE;                           /* Real Time Clock Date */
extern volatile unsigned char RTCDATE_L;                          /* Real Time Clock Date */
extern volatile unsigned char RTCDATE_H;                          /* Real Time Clock Date */
extern volatile unsigned int RTCYEAR;                           /* Real Time Clock Year */
extern volatile unsigned char RTCYEAR_L;                          /* Real Time Clock Year */
extern volatile unsigned char RTCYEAR_H;                          /* Real Time Clock Year */
extern volatile unsigned int RTCAMINHR;                         /* Real Time Clock Alarm Min/Hour */
extern volatile unsigned char RTCAMINHR_L;                        /* Real Time Clock Alarm Min/Hour */
extern volatile unsigned char RTCAMINHR_H;                        /* Real Time Clock Alarm Min/Hour */
extern volatile unsigned int RTCADOWDAY;                        /* Real Time Clock Alarm day of week/day */
extern volatile unsigned char RTCADOWDAY_L;                       /* Real Time Clock Alarm day of week/day */
extern volatile unsigned char RTCADOWDAY_H;                       /* Real Time Clock Alarm day of week/day */
extern volatile unsigned int BIN2BCD;                           /* Real Time Binary-to-BCD conversion register */
extern volatile unsigned int BCD2BIN;                           /* Real Time BCD-to-binary conversion register */

#line 2610 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCCTL0 Control Bits */
#line 2620 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCCTL0 Control Bits */
#line 2630 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"




/* RTCCTL13 Control Bits */
#line 2645 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCCTL13 Control Bits */
#line 2655 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCCTL13 Control Bits */



#line 2667 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2676 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* RTCOCAL Control Bits */
#line 2692 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCOCAL Control Bits */
#line 2702 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCOCAL Control Bits */


/* RTCTCMP Control Bits */
#line 2718 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCTCMP Control Bits */
#line 2728 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCTCMP Control Bits */






/* RTCPS0CTL Control Bits */
//#define Reserved          (0x0080)
//#define Reserved          (0x0040)
//#define Reserved          (0x0020)






/* RTCPS0CTL Control Bits */
//#define Reserved          (0x0080)
//#define Reserved          (0x0040)
//#define Reserved          (0x0020)






#line 2764 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTCPS1CTL Control Bits */
//#define Reserved          (0x0080)
//#define Reserved          (0x0040)
//#define Reserved          (0x0020)






/* RTCPS1CTL Control Bits */
//#define Reserved          (0x0080)
//#define Reserved          (0x0040)
//#define Reserved          (0x0020)






#line 2793 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* RTC Definitions */
#line 2802 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Legacy Definitions */
#line 2811 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* SD24_B - Sigma Delta 24 Bit
************************************************************/





extern volatile unsigned int SD24BCTL0;                         /* SD24B Control Register 0 */
extern volatile unsigned char SD24BCTL0_L;                        /* SD24B Control Register 0 */
extern volatile unsigned char SD24BCTL0_H;                        /* SD24B Control Register 0 */
extern volatile unsigned int SD24BCTL1;                         /* SD24B Control Register 1 */
extern volatile unsigned char SD24BCTL1_L;                        /* SD24B Control Register 1 */
extern volatile unsigned char SD24BCTL1_H;                        /* SD24B Control Register 1 */
extern volatile unsigned int SD24BTRGCTL;                       /* SD24B Trigger Control Register */
extern volatile unsigned char SD24BTRGCTL_L;                      /* SD24B Trigger Control Register */
extern volatile unsigned char SD24BTRGCTL_H;                      /* SD24B Trigger Control Register */
extern volatile unsigned int SD24BTRGOSR;                       /* SD24B Trigger OSR Control Register */
extern volatile unsigned char SD24BTRGOSR_L;                      /* SD24B Trigger OSR Control Register */
extern volatile unsigned char SD24BTRGOSR_H;                      /* SD24B Trigger OSR Control Register */
extern volatile unsigned int SD24BTRGPRE;                       /* SD24B Trigger Preload Register */
extern volatile unsigned char SD24BTRGPRE_L;                      /* SD24B Trigger Preload Register */
extern volatile unsigned char SD24BTRGPRE_H;                      /* SD24B Trigger Preload Register */
extern volatile unsigned int SD24BIFG;                          /* SD24B Interrupt Flag Register */
extern volatile unsigned char SD24BIFG_L;                         /* SD24B Interrupt Flag Register */
extern volatile unsigned char SD24BIFG_H;                         /* SD24B Interrupt Flag Register */
extern volatile unsigned int SD24BIE;                           /* SD24B Interrupt Enable Register */
extern volatile unsigned char SD24BIE_L;                          /* SD24B Interrupt Enable Register */
extern volatile unsigned char SD24BIE_H;                          /* SD24B Interrupt Enable Register */
extern volatile unsigned int SD24BIV;                           /* SD24B Interrupt Vector Register */
extern volatile unsigned char SD24BIV_L;                          /* SD24B Interrupt Vector Register */
extern volatile unsigned char SD24BIV_H;                          /* SD24B Interrupt Vector Register */

extern volatile unsigned int SD24BCCTL0;                        /* SD24B Channel 0 Control Register */
extern volatile unsigned char SD24BCCTL0_L;                       /* SD24B Channel 0 Control Register */
extern volatile unsigned char SD24BCCTL0_H;                       /* SD24B Channel 0 Control Register */
extern volatile unsigned int SD24BINCTL0;                       /* SD24B Channel 0 Input Control Register */
extern volatile unsigned char SD24BINCTL0_L;                      /* SD24B Channel 0 Input Control Register */
extern volatile unsigned char SD24BINCTL0_H;                      /* SD24B Channel 0 Input Control Register */
extern volatile unsigned int SD24BOSR0;                         /* SD24B Channel 0 OSR Control Register */
extern volatile unsigned char SD24BOSR0_L;                        /* SD24B Channel 0 OSR Control Register */
extern volatile unsigned char SD24BOSR0_H;                        /* SD24B Channel 0 OSR Control Register */
extern volatile unsigned int SD24BPRE0;                         /* SD24B Channel 0 Preload Register */
extern volatile unsigned char SD24BPRE0_L;                        /* SD24B Channel 0 Preload Register */
extern volatile unsigned char SD24BPRE0_H;                        /* SD24B Channel 0 Preload Register */
extern volatile unsigned int SD24BCCTL1;                        /* SD24B Channel 1 Control Register */
extern volatile unsigned char SD24BCCTL1_L;                       /* SD24B Channel 1 Control Register */
extern volatile unsigned char SD24BCCTL1_H;                       /* SD24B Channel 1 Control Register */
extern volatile unsigned int SD24BINCTL1;                       /* SD24B Channel 1 Input Control Register */
extern volatile unsigned char SD24BINCTL1_L;                      /* SD24B Channel 1 Input Control Register */
extern volatile unsigned char SD24BINCTL1_H;                      /* SD24B Channel 1 Input Control Register */
extern volatile unsigned int SD24BOSR1;                         /* SD24B Channel 1 OSR Control Register */
extern volatile unsigned char SD24BOSR1_L;                        /* SD24B Channel 1 OSR Control Register */
extern volatile unsigned char SD24BOSR1_H;                        /* SD24B Channel 1 OSR Control Register */
extern volatile unsigned int SD24BPRE1;                         /* SD24B Channel 1 Preload Register */
extern volatile unsigned char SD24BPRE1_L;                        /* SD24B Channel 1 Preload Register */
extern volatile unsigned char SD24BPRE1_H;                        /* SD24B Channel 1 Preload Register */
extern volatile unsigned int SD24BCCTL2;                        /* SD24B Channel 2 Control Register */
extern volatile unsigned char SD24BCCTL2_L;                       /* SD24B Channel 2 Control Register */
extern volatile unsigned char SD24BCCTL2_H;                       /* SD24B Channel 2 Control Register */
extern volatile unsigned int SD24BINCTL2;                       /* SD24B Channel 2 Input Control Register */
extern volatile unsigned char SD24BINCTL2_L;                      /* SD24B Channel 2 Input Control Register */
extern volatile unsigned char SD24BINCTL2_H;                      /* SD24B Channel 2 Input Control Register */
extern volatile unsigned int SD24BOSR2;                         /* SD24B Channel 2 OSR Control Register */
extern volatile unsigned char SD24BOSR2_L;                        /* SD24B Channel 2 OSR Control Register */
extern volatile unsigned char SD24BOSR2_H;                        /* SD24B Channel 2 OSR Control Register */
extern volatile unsigned int SD24BPRE2;                         /* SD24B Channel 2 Preload Register */
extern volatile unsigned char SD24BPRE2_L;                        /* SD24B Channel 2 Preload Register */
extern volatile unsigned char SD24BPRE2_H;                        /* SD24B Channel 2 Preload Register */

extern volatile unsigned int SD24BMEML0;                        /* SD24B Channel 0 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML0_L;                       /* SD24B Channel 0 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML0_H;                       /* SD24B Channel 0 Conversion Memory Low word */
extern volatile unsigned int SD24BMEMH0;                        /* SD24B Channel 0 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH0_L;                       /* SD24B Channel 0 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH0_H;                       /* SD24B Channel 0 Conversion Memory High Word */
extern volatile unsigned int SD24BMEML1;                        /* SD24B Channel 1 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML1_L;                       /* SD24B Channel 1 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML1_H;                       /* SD24B Channel 1 Conversion Memory Low word */
extern volatile unsigned int SD24BMEMH1;                        /* SD24B Channel 1 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH1_L;                       /* SD24B Channel 1 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH1_H;                       /* SD24B Channel 1 Conversion Memory High Word */
extern volatile unsigned int SD24BMEML2;                        /* SD24B Channel 2 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML2_L;                       /* SD24B Channel 2 Conversion Memory Low word */
extern volatile unsigned char SD24BMEML2_H;                       /* SD24B Channel 2 Conversion Memory Low word */
extern volatile unsigned int SD24BMEMH2;                        /* SD24B Channel 2 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH2_L;                       /* SD24B Channel 2 Conversion Memory High Word */
extern volatile unsigned char SD24BMEMH2_H;                       /* SD24B Channel 2 Conversion Memory High Word */

/* SD24BCTL0 */
#line 2916 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2923 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2932 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2941 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 2950 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SD24BCTL1 */
#line 2960 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"











#line 2980 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SD24BTRGCTL */
#line 2989 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"










#line 3015 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SD24BIFG */
#line 3023 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"









/* SD24BIE */
#line 3039 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"









/* SD24BIV Definitions */
#line 3055 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SD24BCCTLx */
#line 3066 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"





#line 3077 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"














/* SD24BINCTLx */












#line 3112 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"






/* SD24BOSRx */
#line 3130 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 3139 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"





/* SD24BTRGOSR */

#line 3152 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


/************************************************************
* SFR - Special Function Register Module
************************************************************/




extern volatile unsigned int SFRIE1;                            /* Interrupt Enable 1 */
extern volatile unsigned char SFRIE1_L;                           /* Interrupt Enable 1 */
extern volatile unsigned char SFRIE1_H;                           /* Interrupt Enable 1 */

/* SFRIE1 Control Bits */


//#define Reserved          (0x0004)








//#define Reserved          (0x0004)






extern volatile unsigned int SFRIFG1;                           /* Interrupt Flag 1 */
extern volatile unsigned char SFRIFG1_L;                          /* Interrupt Flag 1 */
extern volatile unsigned char SFRIFG1_H;                          /* Interrupt Flag 1 */
/* SFRIFG1 Control Bits */


//#define Reserved          (0x0004)


//#define Reserved          (0x0020)





//#define Reserved          (0x0004)


//#define Reserved          (0x0020)



extern volatile unsigned int SFRRPCR;                           /* RESET Pin Control Register */
extern volatile unsigned char SFRRPCR_L;                          /* RESET Pin Control Register */
extern volatile unsigned char SFRRPCR_H;                          /* RESET Pin Control Register */
/* SFRRPCR Control Bits */










/************************************************************
* SYS - System Module
************************************************************/




extern volatile unsigned int SYSCTL;                            /* System control */
extern volatile unsigned char SYSCTL_L;                           /* System control */
extern volatile unsigned char SYSCTL_H;                           /* System control */
extern volatile unsigned int SYSBSLC;                           /* Boot strap configuration area */
extern volatile unsigned char SYSBSLC_L;                          /* Boot strap configuration area */
extern volatile unsigned char SYSBSLC_H;                          /* Boot strap configuration area */
extern volatile unsigned int SYSJMBC;                           /* JTAG mailbox control */
extern volatile unsigned char SYSJMBC_L;                          /* JTAG mailbox control */
extern volatile unsigned char SYSJMBC_H;                          /* JTAG mailbox control */
extern volatile unsigned int SYSJMBI0;                          /* JTAG mailbox input 0 */
extern volatile unsigned char SYSJMBI0_L;                         /* JTAG mailbox input 0 */
extern volatile unsigned char SYSJMBI0_H;                         /* JTAG mailbox input 0 */
extern volatile unsigned int SYSJMBI1;                          /* JTAG mailbox input 1 */
extern volatile unsigned char SYSJMBI1_L;                         /* JTAG mailbox input 1 */
extern volatile unsigned char SYSJMBI1_H;                         /* JTAG mailbox input 1 */
extern volatile unsigned int SYSJMBO0;                          /* JTAG mailbox output 0 */
extern volatile unsigned char SYSJMBO0_L;                         /* JTAG mailbox output 0 */
extern volatile unsigned char SYSJMBO0_H;                         /* JTAG mailbox output 0 */
extern volatile unsigned int SYSJMBO1;                          /* JTAG mailbox output 1 */
extern volatile unsigned char SYSJMBO1_L;                         /* JTAG mailbox output 1 */
extern volatile unsigned char SYSJMBO1_H;                         /* JTAG mailbox output 1 */

extern volatile unsigned int SYSBERRIV;                         /* Bus Error vector generator */
extern volatile unsigned char SYSBERRIV_L;                        /* Bus Error vector generator */
extern volatile unsigned char SYSBERRIV_H;                        /* Bus Error vector generator */
extern volatile unsigned int SYSUNIV;                           /* User NMI vector generator */
extern volatile unsigned char SYSUNIV_L;                          /* User NMI vector generator */
extern volatile unsigned char SYSUNIV_H;                          /* User NMI vector generator */
extern volatile unsigned int SYSSNIV;                           /* System NMI vector generator */
extern volatile unsigned char SYSSNIV_L;                          /* System NMI vector generator */
extern volatile unsigned char SYSSNIV_H;                          /* System NMI vector generator */
extern volatile unsigned int SYSRSTIV;                          /* Reset vector generator */
extern volatile unsigned char SYSRSTIV_L;                         /* Reset vector generator */
extern volatile unsigned char SYSRSTIV_H;                         /* Reset vector generator */

/* SYSCTL Control Bits */

//#define RESERVED            (0x0002)  /* SYS - Reserved */

//#define RESERVED            (0x0008)  /* SYS - Reserved */


//#define RESERVED            (0x0040)  /* SYS - Reserved */
//#define RESERVED            (0x0080)  /* SYS - Reserved */
//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */
//#define RESERVED            (0x4000)  /* SYS - Reserved */
//#define RESERVED            (0x8000)  /* SYS - Reserved */

/* SYSCTL Control Bits */

//#define RESERVED            (0x0002)  /* SYS - Reserved */

//#define RESERVED            (0x0008)  /* SYS - Reserved */


//#define RESERVED            (0x0040)  /* SYS - Reserved */
//#define RESERVED            (0x0080)  /* SYS - Reserved */
//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */
//#define RESERVED            (0x4000)  /* SYS - Reserved */
//#define RESERVED            (0x8000)  /* SYS - Reserved */

/* SYSBSLC Control Bits */



//#define RESERVED            (0x0008)  /* SYS - Reserved */
//#define RESERVED            (0x0010)  /* SYS - Reserved */
//#define RESERVED            (0x0020)  /* SYS - Reserved */
//#define RESERVED            (0x0040)  /* SYS - Reserved */
//#define RESERVED            (0x0080)  /* SYS - Reserved */
//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */



/* SYSBSLC Control Bits */



//#define RESERVED            (0x0008)  /* SYS - Reserved */
//#define RESERVED            (0x0010)  /* SYS - Reserved */
//#define RESERVED            (0x0020)  /* SYS - Reserved */
//#define RESERVED            (0x0040)  /* SYS - Reserved */
//#define RESERVED            (0x0080)  /* SYS - Reserved */
//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */

/* SYSBSLC Control Bits */
//#define RESERVED            (0x0008)  /* SYS - Reserved */
//#define RESERVED            (0x0010)  /* SYS - Reserved */
//#define RESERVED            (0x0020)  /* SYS - Reserved */
//#define RESERVED            (0x0040)  /* SYS - Reserved */
//#define RESERVED            (0x0080)  /* SYS - Reserved */
//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */



/* SYSJMBC Control Bits */





//#define RESERVED            (0x0020)  /* SYS - Reserved */


//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */
//#define RESERVED            (0x4000)  /* SYS - Reserved */
//#define RESERVED            (0x8000)  /* SYS - Reserved */

/* SYSJMBC Control Bits */





//#define RESERVED            (0x0020)  /* SYS - Reserved */


//#define RESERVED            (0x0100)  /* SYS - Reserved */
//#define RESERVED            (0x0200)  /* SYS - Reserved */
//#define RESERVED            (0x0400)  /* SYS - Reserved */
//#define RESERVED            (0x0800)  /* SYS - Reserved */
//#define RESERVED            (0x1000)  /* SYS - Reserved */
//#define RESERVED            (0x2000)  /* SYS - Reserved */
//#define RESERVED            (0x4000)  /* SYS - Reserved */
//#define RESERVED            (0x8000)  /* SYS - Reserved */

/* SYSUNIV Definitions */






/* SYSSNIV Definitions */
#line 3401 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* SYSRSTIV Definitions */
#line 3420 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* Timer0_A3
************************************************************/




extern volatile unsigned int TA0CTL;                            /* Timer0_A3 Control */
extern volatile unsigned int TA0CCTL0;                          /* Timer0_A3 Capture/Compare Control 0 */
extern volatile unsigned int TA0CCTL1;                          /* Timer0_A3 Capture/Compare Control 1 */
extern volatile unsigned int TA0CCTL2;                          /* Timer0_A3 Capture/Compare Control 2 */
extern volatile unsigned int TA0R;                              /* Timer0_A3 */
extern volatile unsigned int TA0CCR0;                           /* Timer0_A3 Capture/Compare 0 */
extern volatile unsigned int TA0CCR1;                           /* Timer0_A3 Capture/Compare 1 */
extern volatile unsigned int TA0CCR2;                           /* Timer0_A3 Capture/Compare 2 */
extern volatile unsigned int TA0IV;                             /* Timer0_A3 Interrupt Vector Word */
extern volatile unsigned int TA0EX0;                            /* Timer0_A3 Expansion Register 0 */

/* TAxCTL Control Bits */
#line 3449 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 3475 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* TAxCCTLx Control Bits */
#line 3492 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 3509 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* TAxEX0 Control Bits */




#line 3523 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* T0A3IV Definitions */
#line 3533 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Legacy Defines */




/************************************************************
* Timer1_A2
************************************************************/




extern volatile unsigned int TA1CTL;                            /* Timer1_A2 Control */
extern volatile unsigned int TA1CCTL0;                          /* Timer1_A2 Capture/Compare Control 0 */
extern volatile unsigned int TA1CCTL1;                          /* Timer1_A2 Capture/Compare Control 1 */
extern volatile unsigned int TA1R;                              /* Timer1_A2 */
extern volatile unsigned int TA1CCR0;                           /* Timer1_A2 Capture/Compare 0 */
extern volatile unsigned int TA1CCR1;                           /* Timer1_A2 Capture/Compare 1 */
extern volatile unsigned int TA1IV;                             /* Timer1_A2 Interrupt Vector Word */
extern volatile unsigned int TA1EX0;                            /* Timer1_A2 Expansion Register 0 */

/* Bits are already defined within the Timer0_Ax */

/* TA1IV Definitions */
#line 3565 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Legacy Defines */



/************************************************************
* Timer2_A2
************************************************************/




extern volatile unsigned int TA2CTL;                            /* Timer2_A2 Control */
extern volatile unsigned int TA2CCTL0;                          /* Timer2_A2 Capture/Compare Control 0 */
extern volatile unsigned int TA2CCTL1;                          /* Timer2_A2 Capture/Compare Control 1 */
extern volatile unsigned int TA2R;                              /* Timer2_A2 */
extern volatile unsigned int TA2CCR0;                           /* Timer2_A2 Capture/Compare 0 */
extern volatile unsigned int TA2CCR1;                           /* Timer2_A2 Capture/Compare 1 */
extern volatile unsigned int TA2IV;                             /* Timer2_A2 Interrupt Vector Word */
extern volatile unsigned int TA2EX0;                            /* Timer2_A2 Expansion Register 0 */

/* Bits are already defined within the Timer0_Ax */

/* TA2IV Definitions */
#line 3596 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Legacy Defines */



/************************************************************
* Timer3_A2
************************************************************/




extern volatile unsigned int TA3CTL;                            /* Timer3_A2 Control */
extern volatile unsigned int TA3CCTL0;                          /* Timer3_A2 Capture/Compare Control 0 */
extern volatile unsigned int TA3CCTL1;                          /* Timer3_A2 Capture/Compare Control 1 */
extern volatile unsigned int TA3R;                              /* Timer3_A2 */
extern volatile unsigned int TA3CCR0;                           /* Timer3_A2 Capture/Compare 0 */
extern volatile unsigned int TA3CCR1;                           /* Timer3_A2 Capture/Compare 1 */
extern volatile unsigned int TA3IV;                             /* Timer3_A2 Interrupt Vector Word */
extern volatile unsigned int TA3EX0;                            /* Timer3_A2 Expansion Register 0 */

/* Bits are already defined within the Timer0_Ax */

/* TA3IV Definitions */
#line 3627 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* Legacy Defines */



/************************************************************
* UNIFIED CLOCK SYSTEM
************************************************************/




extern volatile unsigned int UCSCTL0;                           /* UCS Control Register 0 */
extern volatile unsigned char UCSCTL0_L;                          /* UCS Control Register 0 */
extern volatile unsigned char UCSCTL0_H;                          /* UCS Control Register 0 */
extern volatile unsigned int UCSCTL1;                           /* UCS Control Register 1 */
extern volatile unsigned char UCSCTL1_L;                          /* UCS Control Register 1 */
extern volatile unsigned char UCSCTL1_H;                          /* UCS Control Register 1 */
extern volatile unsigned int UCSCTL2;                           /* UCS Control Register 2 */
extern volatile unsigned char UCSCTL2_L;                          /* UCS Control Register 2 */
extern volatile unsigned char UCSCTL2_H;                          /* UCS Control Register 2 */
extern volatile unsigned int UCSCTL3;                           /* UCS Control Register 3 */
extern volatile unsigned char UCSCTL3_L;                          /* UCS Control Register 3 */
extern volatile unsigned char UCSCTL3_H;                          /* UCS Control Register 3 */
extern volatile unsigned int UCSCTL4;                           /* UCS Control Register 4 */
extern volatile unsigned char UCSCTL4_L;                          /* UCS Control Register 4 */
extern volatile unsigned char UCSCTL4_H;                          /* UCS Control Register 4 */
extern volatile unsigned int UCSCTL5;                           /* UCS Control Register 5 */
extern volatile unsigned char UCSCTL5_L;                          /* UCS Control Register 5 */
extern volatile unsigned char UCSCTL5_H;                          /* UCS Control Register 5 */
extern volatile unsigned int UCSCTL6;                           /* UCS Control Register 6 */
extern volatile unsigned char UCSCTL6_L;                          /* UCS Control Register 6 */
extern volatile unsigned char UCSCTL6_H;                          /* UCS Control Register 6 */
extern volatile unsigned int UCSCTL7;                           /* UCS Control Register 7 */
extern volatile unsigned char UCSCTL7_L;                          /* UCS Control Register 7 */
extern volatile unsigned char UCSCTL7_H;                          /* UCS Control Register 7 */
extern volatile unsigned int UCSCTL8;                           /* UCS Control Register 8 */
extern volatile unsigned char UCSCTL8_L;                          /* UCS Control Register 8 */
extern volatile unsigned char UCSCTL8_H;                          /* UCS Control Register 8 */

/* UCSCTL0 Control Bits */
//#define RESERVED            (0x0001)    /* RESERVED */
//#define RESERVED            (0x0002)    /* RESERVED */
//#define RESERVED            (0x0004)    /* RESERVED */
#line 3681 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL0 Control Bits */
//#define RESERVED            (0x0001)    /* RESERVED */
//#define RESERVED            (0x0002)    /* RESERVED */
//#define RESERVED            (0x0004)    /* RESERVED */





//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL0 Control Bits */
//#define RESERVED            (0x0001)    /* RESERVED */
//#define RESERVED            (0x0002)    /* RESERVED */
//#define RESERVED            (0x0004)    /* RESERVED */





//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL1 Control Bits */

//#define RESERVED            (0x0002)    /* RESERVED */
//#define RESERVED            (0x0004)    /* RESERVED */
//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL1 Control Bits */

//#define RESERVED            (0x0002)    /* RESERVED */
//#define RESERVED            (0x0004)    /* RESERVED */
//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

#line 3755 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL2 Control Bits */
#line 3767 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */



//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL2 Control Bits */
#line 3783 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL2 Control Bits */


//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */



//#define RESERVED            (0x8000)    /* RESERVED */

#line 3811 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL3 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL3 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

#line 3873 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL4 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */



//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL4 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL4 Control Bits */
//#define RESERVED            (0x0008)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */



//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

#line 3933 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 3948 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 3963 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL5 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */



//#define RESERVED            (0x0800)    /* RESERVED */



//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL5 Control Bits */



//#define RESERVED            (0x0008)    /* RESERVED */



//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL5 Control Bits */
//#define RESERVED            (0x0008)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */



//#define RESERVED            (0x0800)    /* RESERVED */



//#define RESERVED            (0x8000)    /* RESERVED */

#line 4020 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 4035 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 4050 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 4065 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL6 Control Bits */
#line 4076 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */

//#define RESERVED            (0x2000)    /* RESERVED */



/* UCSCTL6 Control Bits */
#line 4093 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */

/* UCSCTL6 Control Bits */

//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */

//#define RESERVED            (0x2000)    /* RESERVED */



#line 4120 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCSCTL7 Control Bits */


//#define RESERVED            (0x0004)    /* RESERVED */

//#define RESERVED            (0x0010)    /* RESERVED */
//#define RESERVED            (0x0020)    /* RESERVED */
//#define RESERVED            (0x0040)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL7 Control Bits */


//#define RESERVED            (0x0004)    /* RESERVED */

//#define RESERVED            (0x0010)    /* RESERVED */
//#define RESERVED            (0x0020)    /* RESERVED */
//#define RESERVED            (0x0040)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL8 Control Bits */




//#define RESERVED            (0x0010)    /* RESERVED */
//#define RESERVED            (0x0020)    /* RESERVED */
//#define RESERVED            (0x0040)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/* UCSCTL8 Control Bits */




//#define RESERVED            (0x0010)    /* RESERVED */
//#define RESERVED            (0x0020)    /* RESERVED */
//#define RESERVED            (0x0040)    /* RESERVED */
//#define RESERVED            (0x0080)    /* RESERVED */
//#define RESERVED            (0x0100)    /* RESERVED */
//#define RESERVED            (0x0200)    /* RESERVED */
//#define RESERVED            (0x0400)    /* RESERVED */
//#define RESERVED            (0x0800)    /* RESERVED */
//#define RESERVED            (0x1000)    /* RESERVED */
//#define RESERVED            (0x2000)    /* RESERVED */
//#define RESERVED            (0x4000)    /* RESERVED */
//#define RESERVED            (0x8000)    /* RESERVED */

/************************************************************
* USCI A0
************************************************************/




extern volatile unsigned int UCA0CTLW0;                         /* USCI A0 Control Word Register 0 */
extern volatile unsigned char UCA0CTLW0_L;                        /* USCI A0 Control Word Register 0 */
extern volatile unsigned char UCA0CTLW0_H;                        /* USCI A0 Control Word Register 0 */


extern volatile unsigned int UCA0CTLW1;                         /* USCI A0 Control Word Register 1 */
extern volatile unsigned char UCA0CTLW1_L;                        /* USCI A0 Control Word Register 1 */
extern volatile unsigned char UCA0CTLW1_H;                        /* USCI A0 Control Word Register 1 */
extern volatile unsigned int UCA0BRW;                           /* USCI A0 Baud Word Rate 0 */
extern volatile unsigned char UCA0BRW_L;                          /* USCI A0 Baud Word Rate 0 */
extern volatile unsigned char UCA0BRW_H;                          /* USCI A0 Baud Word Rate 0 */


extern volatile unsigned int UCA0MCTLW;                         /* USCI A0 Modulation Control */
extern volatile unsigned char UCA0MCTLW_L;                        /* USCI A0 Modulation Control */
extern volatile unsigned char UCA0MCTLW_H;                        /* USCI A0 Modulation Control */
extern volatile unsigned char UCA0STATW;                          /* USCI A0 Status Register */
extern volatile unsigned int UCA0RXBUF;                         /* USCI A0 Receive Buffer */
extern volatile unsigned char UCA0RXBUF_L;                        /* USCI A0 Receive Buffer */
extern volatile unsigned char UCA0RXBUF_H;                        /* USCI A0 Receive Buffer */
extern volatile unsigned int UCA0TXBUF;                         /* USCI A0 Transmit Buffer */
extern volatile unsigned char UCA0TXBUF_L;                        /* USCI A0 Transmit Buffer */
extern volatile unsigned char UCA0TXBUF_H;                        /* USCI A0 Transmit Buffer */
extern volatile unsigned char UCA0ABCTL;                          /* USCI A0 LIN Control */
extern volatile unsigned int UCA0IRCTL;                         /* USCI A0 IrDA Transmit Control */
extern volatile unsigned char UCA0IRCTL_L;                        /* USCI A0 IrDA Transmit Control */
extern volatile unsigned char UCA0IRCTL_H;                        /* USCI A0 IrDA Transmit Control */


extern volatile unsigned int UCA0IE;                            /* USCI A0 Interrupt Enable Register */
extern volatile unsigned char UCA0IE_L;                           /* USCI A0 Interrupt Enable Register */
extern volatile unsigned char UCA0IE_H;                           /* USCI A0 Interrupt Enable Register */
extern volatile unsigned int UCA0IFG;                           /* USCI A0 Interrupt Flags Register */
extern volatile unsigned char UCA0IFG_L;                          /* USCI A0 Interrupt Flags Register */
extern volatile unsigned char UCA0IFG_H;                          /* USCI A0 Interrupt Flags Register */
extern volatile unsigned int UCA0IV;                            /* USCI A0 Interrupt Vector Register */


/************************************************************
* USCI B0
************************************************************/





extern volatile unsigned int UCB0CTLW0;                         /* USCI B0 Control Word Register 0 */
extern volatile unsigned char UCB0CTLW0_L;                        /* USCI B0 Control Word Register 0 */
extern volatile unsigned char UCB0CTLW0_H;                        /* USCI B0 Control Word Register 0 */


extern volatile unsigned int UCB0CTLW1;                         /* USCI B0 Control Word Register 1 */
extern volatile unsigned char UCB0CTLW1_L;                        /* USCI B0 Control Word Register 1 */
extern volatile unsigned char UCB0CTLW1_H;                        /* USCI B0 Control Word Register 1 */
extern volatile unsigned int UCB0BRW;                           /* USCI B0 Baud Word Rate 0 */
extern volatile unsigned char UCB0BRW_L;                          /* USCI B0 Baud Word Rate 0 */
extern volatile unsigned char UCB0BRW_H;                          /* USCI B0 Baud Word Rate 0 */


extern volatile unsigned int UCB0STATW;                         /* USCI B0 Status Word Register */
extern volatile unsigned char UCB0STATW_L;                        /* USCI B0 Status Word Register */
extern volatile unsigned char UCB0STATW_H;                        /* USCI B0 Status Word Register */


extern volatile unsigned int UCB0TBCNT;                         /* USCI B0 Byte Counter Threshold Register */
extern volatile unsigned char UCB0TBCNT_L;                        /* USCI B0 Byte Counter Threshold Register */
extern volatile unsigned char UCB0TBCNT_H;                        /* USCI B0 Byte Counter Threshold Register */
extern volatile unsigned int UCB0RXBUF;                         /* USCI B0 Receive Buffer */
extern volatile unsigned char UCB0RXBUF_L;                        /* USCI B0 Receive Buffer */
extern volatile unsigned char UCB0RXBUF_H;                        /* USCI B0 Receive Buffer */
extern volatile unsigned int UCB0TXBUF;                         /* USCI B0 Transmit Buffer */
extern volatile unsigned char UCB0TXBUF_L;                        /* USCI B0 Transmit Buffer */
extern volatile unsigned char UCB0TXBUF_H;                        /* USCI B0 Transmit Buffer */
extern volatile unsigned int UCB0I2COA0;                        /* USCI B0 I2C Own Address 0 */
extern volatile unsigned char UCB0I2COA0_L;                       /* USCI B0 I2C Own Address 0 */
extern volatile unsigned char UCB0I2COA0_H;                       /* USCI B0 I2C Own Address 0 */
extern volatile unsigned int UCB0I2COA1;                        /* USCI B0 I2C Own Address 1 */
extern volatile unsigned char UCB0I2COA1_L;                       /* USCI B0 I2C Own Address 1 */
extern volatile unsigned char UCB0I2COA1_H;                       /* USCI B0 I2C Own Address 1 */
extern volatile unsigned int UCB0I2COA2;                        /* USCI B0 I2C Own Address 2 */
extern volatile unsigned char UCB0I2COA2_L;                       /* USCI B0 I2C Own Address 2 */
extern volatile unsigned char UCB0I2COA2_H;                       /* USCI B0 I2C Own Address 2 */
extern volatile unsigned int UCB0I2COA3;                        /* USCI B0 I2C Own Address 3 */
extern volatile unsigned char UCB0I2COA3_L;                       /* USCI B0 I2C Own Address 3 */
extern volatile unsigned char UCB0I2COA3_H;                       /* USCI B0 I2C Own Address 3 */
extern volatile unsigned int UCB0ADDRX;                         /* USCI B0 Received Address Register */
extern volatile unsigned char UCB0ADDRX_L;                        /* USCI B0 Received Address Register */
extern volatile unsigned char UCB0ADDRX_H;                        /* USCI B0 Received Address Register */
extern volatile unsigned int UCB0ADDMASK;                       /* USCI B0 Address Mask Register */
extern volatile unsigned char UCB0ADDMASK_L;                      /* USCI B0 Address Mask Register */
extern volatile unsigned char UCB0ADDMASK_H;                      /* USCI B0 Address Mask Register */
extern volatile unsigned int UCB0I2CSA;                         /* USCI B0 I2C Slave Address */
extern volatile unsigned char UCB0I2CSA_L;                        /* USCI B0 I2C Slave Address */
extern volatile unsigned char UCB0I2CSA_H;                        /* USCI B0 I2C Slave Address */
extern volatile unsigned int UCB0IE;                            /* USCI B0 Interrupt Enable Register */
extern volatile unsigned char UCB0IE_L;                           /* USCI B0 Interrupt Enable Register */
extern volatile unsigned char UCB0IE_H;                           /* USCI B0 Interrupt Enable Register */
extern volatile unsigned int UCB0IFG;                           /* USCI B0 Interrupt Flags Register */
extern volatile unsigned char UCB0IFG_L;                          /* USCI B0 Interrupt Flags Register */
extern volatile unsigned char UCB0IFG_H;                          /* USCI B0 Interrupt Flags Register */
extern volatile unsigned int UCB0IV;                            /* USCI B0 Interrupt Vector Register */

// UCAxCTLW0 UART-Mode Control Bits
#line 4319 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCAxCTLW0 UART-Mode Control Bits
#line 4329 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCAxCTLW0 UART-Mode Control Bits
#line 4339 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCxxCTLW0 SPI-Mode Control Bits



//#define res               (0x0020)    /* reserved */
//#define res               (0x0010)    /* reserved */
//#define res               (0x0008)    /* reserved */
//#define res               (0x0004)    /* reserved */


// UCBxCTLW0 I2C-Mode Control Bits



//#define res               (0x1000)    /* reserved */
//#define res               (0x0100)    /* reserved */






// UCBxCTLW0 I2C-Mode Control Bits
//#define res               (0x1000)    /* reserved */
//#define res               (0x0100)    /* reserved */






// UCBxCTLW0 I2C-Mode Control Bits



//#define res               (0x1000)    /* reserved */
//#define res               (0x0100)    /* reserved */






#line 4390 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCAxCTLW1 UART-Mode Control Bits



// UCAxCTLW1 UART-Mode Control Bits



// UCBxCTLW1 I2C-Mode Control Bits
#line 4409 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCBxCTLW1 I2C-Mode Control Bits
#line 4419 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

// UCBxCTLW1 I2C-Mode Control Bits

















/* UCAxMCTLW Control Bits */
#line 4452 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxMCTLW Control Bits */






/* UCAxMCTLW Control Bits */
#line 4469 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 4486 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxSTATW Control Bits */
#line 4497 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxSTATW I2C Control Bits */
#line 4510 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxTBCNT I2C Control Bits */
#line 4520 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxIRCTL Control Bits */
#line 4538 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxIRCTL Control Bits */
#line 4548 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxIRCTL Control Bits */
#line 4558 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxABCTL Control Bits */
//#define res               (0x80)    /* reserved */
//#define res               (0x40)    /* reserved */




//#define res               (0x02)    /* reserved */


/* UCBxI2COA0 Control Bits */
#line 4582 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2COA0 Control Bits */
#line 4592 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2COA0 Control Bits */





/* UCBxI2COAx Control Bits */
#line 4611 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2COAx Control Bits */
#line 4621 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2COAx Control Bits */




/* UCBxADDRX Control Bits */
#line 4638 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxADDRX Control Bits */
#line 4648 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxADDRX Control Bits */



/* UCBxADDMASK Control Bits */
#line 4664 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxADDMASK Control Bits */
#line 4674 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxADDMASK Control Bits */



/* UCBxI2CSA Control Bits */
#line 4690 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2CSA Control Bits */
#line 4700 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCBxI2CSA Control Bits */



/* UCAxIE UART Control Bits */





/* UCAxIE/UCBxIE SPI Control Bits */

/* UCBxIE I2C Control Bits */
#line 4729 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* UCAxIFG UART Control Bits */





/* UCAxIFG/UCBxIFG SPI Control Bits */



/* UCBxIFG Control Bits */
#line 4756 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* USCI UART Definitions */






/* USCI SPI Definitions */



/* USCI I2C Definitions */
#line 4784 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* USCI A1
************************************************************/




extern volatile unsigned int UCA1CTLW0;                         /* USCI A1 Control Word Register 0 */
extern volatile unsigned char UCA1CTLW0_L;                        /* USCI A1 Control Word Register 0 */
extern volatile unsigned char UCA1CTLW0_H;                        /* USCI A1 Control Word Register 0 */


extern volatile unsigned int UCA1CTLW1;                         /* USCI A1 Control Word Register 1 */
extern volatile unsigned char UCA1CTLW1_L;                        /* USCI A1 Control Word Register 1 */
extern volatile unsigned char UCA1CTLW1_H;                        /* USCI A1 Control Word Register 1 */
extern volatile unsigned int UCA1BRW;                           /* USCI A1 Baud Word Rate 0 */
extern volatile unsigned char UCA1BRW_L;                          /* USCI A1 Baud Word Rate 0 */
extern volatile unsigned char UCA1BRW_H;                          /* USCI A1 Baud Word Rate 0 */


extern volatile unsigned int UCA1MCTLW;                         /* USCI A1 Modulation Control */
extern volatile unsigned char UCA1MCTLW_L;                        /* USCI A1 Modulation Control */
extern volatile unsigned char UCA1MCTLW_H;                        /* USCI A1 Modulation Control */
extern volatile unsigned char UCA1STATW;                          /* USCI A1 Status Register */
extern volatile unsigned int UCA1RXBUF;                         /* USCI A1 Receive Buffer */
extern volatile unsigned char UCA1RXBUF_L;                        /* USCI A1 Receive Buffer */
extern volatile unsigned char UCA1RXBUF_H;                        /* USCI A1 Receive Buffer */
extern volatile unsigned int UCA1TXBUF;                         /* USCI A1 Transmit Buffer */
extern volatile unsigned char UCA1TXBUF_L;                        /* USCI A1 Transmit Buffer */
extern volatile unsigned char UCA1TXBUF_H;                        /* USCI A1 Transmit Buffer */
extern volatile unsigned char UCA1ABCTL;                          /* USCI A1 LIN Control */
extern volatile unsigned int UCA1IRCTL;                         /* USCI A1 IrDA Transmit Control */
extern volatile unsigned char UCA1IRCTL_L;                        /* USCI A1 IrDA Transmit Control */
extern volatile unsigned char UCA1IRCTL_H;                        /* USCI A1 IrDA Transmit Control */


extern volatile unsigned int UCA1IE;                            /* USCI A1 Interrupt Enable Register */
extern volatile unsigned char UCA1IE_L;                           /* USCI A1 Interrupt Enable Register */
extern volatile unsigned char UCA1IE_H;                           /* USCI A1 Interrupt Enable Register */
extern volatile unsigned int UCA1IFG;                           /* USCI A1 Interrupt Flags Register */
extern volatile unsigned char UCA1IFG_L;                          /* USCI A1 Interrupt Flags Register */
extern volatile unsigned char UCA1IFG_H;                          /* USCI A1 Interrupt Flags Register */
extern volatile unsigned int UCA1IV;                            /* USCI A1 Interrupt Vector Register */


/************************************************************
* USCI A2
************************************************************/




extern volatile unsigned int UCA2CTLW0;                         /* USCI A2 Control Word Register 0 */
extern volatile unsigned char UCA2CTLW0_L;                        /* USCI A2 Control Word Register 0 */
extern volatile unsigned char UCA2CTLW0_H;                        /* USCI A2 Control Word Register 0 */


extern volatile unsigned int UCA2CTLW1;                         /* USCI A2 Control Word Register 1 */
extern volatile unsigned char UCA2CTLW1_L;                        /* USCI A2 Control Word Register 1 */
extern volatile unsigned char UCA2CTLW1_H;                        /* USCI A2 Control Word Register 1 */
extern volatile unsigned int UCA2BRW;                           /* USCI A2 Baud Word Rate 0 */
extern volatile unsigned char UCA2BRW_L;                          /* USCI A2 Baud Word Rate 0 */
extern volatile unsigned char UCA2BRW_H;                          /* USCI A2 Baud Word Rate 0 */


extern volatile unsigned int UCA2MCTLW;                         /* USCI A2 Modulation Control */
extern volatile unsigned char UCA2MCTLW_L;                        /* USCI A2 Modulation Control */
extern volatile unsigned char UCA2MCTLW_H;                        /* USCI A2 Modulation Control */
extern volatile unsigned char UCA2STATW;                          /* USCI A2 Status Register */
extern volatile unsigned int UCA2RXBUF;                         /* USCI A2 Receive Buffer */
extern volatile unsigned char UCA2RXBUF_L;                        /* USCI A2 Receive Buffer */
extern volatile unsigned char UCA2RXBUF_H;                        /* USCI A2 Receive Buffer */
extern volatile unsigned int UCA2TXBUF;                         /* USCI A2 Transmit Buffer */
extern volatile unsigned char UCA2TXBUF_L;                        /* USCI A2 Transmit Buffer */
extern volatile unsigned char UCA2TXBUF_H;                        /* USCI A2 Transmit Buffer */
extern volatile unsigned char UCA2ABCTL;                          /* USCI A2 LIN Control */
extern volatile unsigned int UCA2IRCTL;                         /* USCI A2 IrDA Transmit Control */
extern volatile unsigned char UCA2IRCTL_L;                        /* USCI A2 IrDA Transmit Control */
extern volatile unsigned char UCA2IRCTL_H;                        /* USCI A2 IrDA Transmit Control */


extern volatile unsigned int UCA2IE;                            /* USCI A2 Interrupt Enable Register */
extern volatile unsigned char UCA2IE_L;                           /* USCI A2 Interrupt Enable Register */
extern volatile unsigned char UCA2IE_H;                           /* USCI A2 Interrupt Enable Register */
extern volatile unsigned int UCA2IFG;                           /* USCI A2 Interrupt Flags Register */
extern volatile unsigned char UCA2IFG_L;                          /* USCI A2 Interrupt Flags Register */
extern volatile unsigned char UCA2IFG_H;                          /* USCI A2 Interrupt Flags Register */
extern volatile unsigned int UCA2IV;                            /* USCI A2 Interrupt Vector Register */


/************************************************************
* WATCHDOG TIMER A
************************************************************/




extern volatile unsigned int WDTCTL;                            /* Watchdog Timer Control */
extern volatile unsigned char WDTCTL_L;                           /* Watchdog Timer Control */
extern volatile unsigned char WDTCTL_H;                           /* Watchdog Timer Control */
/* The bit names have been prefixed with "WDT" */
/* WDTCTL Control Bits */
#line 4895 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* WDTCTL Control Bits */
#line 4905 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"



#line 4924 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

#line 4932 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/* WDT-interval times [1ms] coded with Bits 0-2 */
/* WDT is clocked by fSMCLK (assumed 1MHz) */




/* WDT is clocked by fACLK (assumed 32KHz) */




/* Watchdog mode -> reset after expired time */
/* WDT is clocked by fSMCLK (assumed 1MHz) */




/* WDT is clocked by fACLK (assumed 32KHz) */






/************************************************************
* TLV Descriptors
************************************************************/






#line 4980 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* Interrupt Vectors (offset from 0xFF80)
************************************************************/

#pragma diag_suppress 1107
#line 4994 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"


#line 5116 "/opt/ti/ccsv5/ccs_base/msp430/include/msp430f6733.h"

/************************************************************
* End of Modules
************************************************************/


}




#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"




namespace msp430f6733
{

/** Port definitions */
#line 24 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"

/** Port register offsets */
#line 32 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"

/** Pin configuration flag bit offsets (bit positions) */
#line 40 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"

/** Pin configuration flag settings */
#line 53 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/iopin.h"



class IOPin : public base::IOPin
{
private:
  uint8_t _portNumber;
  uint8_t _pinNumber;
  uint8_t _expandedPinNumber;
  static volatile unsigned char *_portAddr[];
  void _configurePin(uint8_t flags);

public:

  IOPin();

  IOPin(uint8_t portNumber_, uint8_t pinNumber, base::pin_direction dir_,  base::pin_state initial_state_);

  void init(uint8_t portNumber_, uint8_t pinNumber, base::pin_direction dir_,  base::pin_state initial_state_);

  void setDirection(base::pin_direction dir);

  void setHigh(void);

  void setLow(void);

  void toggle(void);

  bool getValue(void);
};

}

#line 4 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/lcd_driver.h"
/**
 * @file lcd_driver.h
 * Driver for the MSP430F6733 LCD C peripheral.
 *
 * Currently only handles static LCDs with 20 pins beginning at one of seven
 * positions, as seen in enum lcdStartPin.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */








namespace msp430f6733
{

typedef enum lcdStartPin
{
	S0 = 0,
	S2 = 1,
	S4 = 2,
	S6 = 3,
	S8 = 4,
	S10 = 5,
	S12 = 6
} lcd_start_pin_t;


class LCDDriver : public base::LCDDriver
{
private:
	lcd_start_pin_t _startPin;

public:
	LCDDriver(lcd_start_pin_t startPin);
	volatile uint8_t* getLCDMemoryPointer();
	void turnOn();
	void turnOff();
	void enterBlinkingMode();
	void exitBlinkingMode();
};

}


#line 5 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/uart.h"



#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/buffer/ring_buffer.h"






template <typename T, uint16_t size>
class RingBuffer
{
private:
	T _buffer[size];  /* The statically-allocated buffer. */
	uint16_t _tailIndex;  /* Position of the last element in the buffer. */
	uint16_t _numEntries;

public:
	RingBuffer()
		: _tailIndex(0),
		  _numEntries(0)
	{
	}


	bool put(T element)
	{
		if (_numEntries < size)
		{
			uint16_t headIndex = (_tailIndex + _numEntries) % size;
			_buffer[headIndex] = element;
			_numEntries++;
			return true;
		}
		else
		{
			return false;
		}
	}


	bool get(T *element)
	{
		if (_numEntries > 0)
		{
			*element = _buffer[_tailIndex];
			_tailIndex = (_tailIndex + 1) % size;
			_numEntries--;
			return true;
		}
		else
		{
			return false;
		}
	}


	void flush()
	{
		_tailIndex = 0;
		_numEntries = 0;
	}


	uint16_t numEntries()
	{
		return _numEntries;
	}


	bool isEmpty()
	{
		return _numEntries == 0;
	}


	bool isFull()
	{
		return _numEntries == size;
	}
};

#line 9 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/uart.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/system.h"



namespace msp430f6733
{


typedef enum serial_module
{
	USCIA0 = 0,
	USCIA1 = 1,
	USCIA2 = 2,
	USCIB0 = 3
} serial_module_t;

typedef enum soft_serial_module
{
	SOFTSERIAL0 = 0
} soft_serial_module_t;

typedef enum timer_module
{
	TIMER_A0 = 0,
	TIMER_A1 = 1,
	TIMER_A2 = 2
	/* TIMER_A3 is reserved for optimized implementation of the SoftSerial
	 * module
	 */
} timer_module_t;

typedef enum timer_clock_source
{
	TAXCLK = 0,
	ACLK = 1,
	SMCLK = 2,
	INVERTED_TAXCLK = 3
} timer_clock_source_t;

typedef volatile unsigned int reg;

}

#line 11 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/uart.h"

namespace msp430f6733
{






class UART : public base::UART
{
	RingBuffer<uint8_t, 64> _txBuffer;
	RingBuffer<uint8_t, 64> _rxBuffer;
	volatile bool _transmitting;
	base::IOPin* _enablePin;
	bool _useEnablePin;
	base::IOPin* _ctsPin;
	bool _useCtsPin;
	reg *_txRegister;
	reg *_rxRegister;
	reg *_interruptVector;
	reg *_baseAddress;
	reg* _irdaControl;
	uint32_t _baud;

	public:
  	  	UART(serial_module_t uart_module);
		void associateRegisters(reg* txRegister_, reg* rxRegister_,
		        reg* interruptVector_, reg* baseAddress_, reg* irdaControl_);
		void lowLevelInit(serial_module_t uart_module);
		void update();
		// TODO: Implement this
		void setBaud(uint32_t baud);
		void useEnablePin(base::IOPin* enablePin_);
		void useCtsPin(base::IOPin* ctsPin_);
		bool put(uint8_t c);
		bool get(uint8_t *c);
		bool writeable();
		bool readable();
		uint8_t numBytesWriteable();
		bool bytesPendingToTransmit();
		bool readFull();
		void flushInput();
		void flushOutput();
		void configureAsIrDA(void);
		void isr(/*some params*/);

		static void _a0Interrupt();
		static void _a1Interrupt();
		static void _a2Interrupt();
		static UART *_uartList[3];
};

}

#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/clock.h"





namespace msp430f6733
{

class Clock : public base::Clock
{
public:
	Clock();
};

}

#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/timer.h"






namespace msp430f6733
{
class Timer : public base::Timer
{
private:
	reg *_baseRegister;
	base::TimerUser *_user;
	bool _callbackEnabled;

	void associateRegisters(reg *baseRegister_);
	void lowLevelInit(timer_module_t timer);

public:
	Timer(timer_module_t timer);

	void start();
	void stop();
	void setClockSource(timer_clock_source_t source);
	void setCallback(base::TimerUser *user);
	void setCallbackFrequency(uint32_t hertz);
	void _isr();

	static void _timer0Interrupt();
	static void _timer1Interrupt();
	static void _timer2Interrupt();
	static void _timer3Interrupt();
	static Timer *_timerList[3];
};

}

#line 9 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/spi.h"









namespace msp430f6733
{

class SPI : public base::SPI
{
private:
	reg *_txRegister;
	reg *_rxRegister;
	reg *_interruptVector;
	reg *_interruptFlags;
	reg *_baseAddress;
	IOPin _csPin;
	void lowLevelInit(serial_module_t serialModule);
	void associateRegisters(reg* txRegister_, reg* rxRegister_,
    		reg* interruptVector_, reg* baseAddress_, reg* interruptFlags_);

public:
	SPI(serial_module_t serialModule, uint8_t csPinPortNumber, uint8_t csPinPinNumber);
	uint8_t send(uint8_t byte);
	void setCsPin();
	void clearCsPin();
};

}



#line 10 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/sd24.h"



#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/microcontrollers/base/adc.h"
namespace base
{
class ADC
{

};
}
#line 10 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733/sd24.h"


namespace msp430f6733
{



class SD24 : public base::ADC
{
	static RingBuffer<int32_t, 8> _channelBuffer[3];

	public:
  	  	SD24();
  	  	bool getSample(uint8_t channel, int32_t* sample);
  	  	void startConversion();
		static void isr();
};

}

#line 12 "/home/anay/grampower/gpos_fw/gpos/hardware/components/../microcontrollers/msp430f6733.h"
#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/push_button/push_button.h"





typedef enum push_button_logic_t
{
	high_when_pressed,
	low_when_pressed
} push_button_logic_t;

typedef enum push_button_status_t
{
	pressed,
	released
} push_button_status_t;

class PushButton
{
private:
	base::IOPin* _ioPin;
	push_button_logic_t _logic;

public:

	PushButton (base::IOPin* ioPin_, push_button_logic_t logic_);

	push_button_status_t getStatus();
};

#line 7 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/radio/rc11xx.h"
/*
 *
 */




#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/utils.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/time/mytime.h"
/*
 * mytime.h
 *
 */ 








#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/serialize/serialize.h"
/*
 * serialize.h
 * Gram Power Inc.
 *
 * Library to serialize and deserialize basic integer primitives.
 * Uses MSB-first (big-endian) encoding.
 *
 */ 







void init_int8_t(int8_t *n);
void init_int16_t(int16_t *n);
void init_int32_t(int32_t *n);
void init_uint8_t(uint8_t *n);
void init_uint16_t(uint16_t *n);
void init_uint32_t(uint32_t *n);

/* Serialize functions
 * 
 * Put "n" of the given data type at index "pos" of "buffer'.
 * 
 * return: number of bytes written to buffer
 */
uint8_t serialize_int8_t(volatile int8_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t serialize_int16_t(volatile int16_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t serialize_int32_t(volatile int32_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t serialize_uint8_t(volatile uint8_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t serialize_uint16_t(volatile uint16_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t serialize_uint32_t(volatile uint32_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);

/* Deserialize functions
 * 
 * Take the given data type from "buffer" at index "pos" and put it in "n".
 *
 * return: number of bytes taken from buffer to make "n"
 */
uint8_t deserialize_int8_t(volatile int8_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t deserialize_int16_t(volatile int16_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t deserialize_int32_t(volatile int32_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t deserialize_uint8_t(volatile uint8_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t deserialize_uint16_t(volatile uint16_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);
uint8_t deserialize_uint32_t(volatile uint32_t *n, uint8_t *buffer, uint16_t buf_size, uint16_t pos);

#line 15 "/home/anay/grampower/gpos_fw/gpos/utils/time/mytime.h"


class MyTime
{
  public:
	uint32_t sec;		// Tick value in seconds

	// Increment information
	uint32_t fract;			// Tick increments elapsed since last seconds boundary
	uint32_t increment;		// Fractions of a second that time_fract represents;
							// do fract/increment to get decimal seconds

	// Real time information
	uint32_t utcOfs;		// Offset between "sec" and real UTC Unix time
							// (add this to sec to get the real UTC Unix time)
	int32_t timezone;		// Offset from UTC for the current timezone in seconds
	void init(void);

	/* Initialize or reset a mytime object with the given parameters.
	 *
	 * arg mytime: the mytime object to update
	 * arg time_sec: seconds since 1 January 1970 00:00:00:00 UTC
	 * arg time_fract: fractional increments since the most recent seconds boundary
	 * arg increment: frations of a second that time_fract represents
	 * arg utc_ofs: Offset between "sec" and real UTC time in seconds
	 * arg timezone: seconds from UTC of this timezone
	 */
	void set(uint32_t sec, uint32_t fract, uint32_t increment,
			uint32_t utc_ofs, uint32_t timezone);

	void setUTC(uint32_t utc);

	uint32_t getUTC(void);

	uint32_t getLocal(void);

	/*
	 * Add a certain number of increments to the given mytime object.
	 *
	 * arg mytime: the mytime object to update
	 * arg num: number of increments to add to the give mytime object
	 */
	void addIncrement(uint32_t inc);

	/*
	 * Add a certain number of seconds to the given mytime object.
	 *
	 * arg mytime: the mytime object to update
	 * arg us: number of seconds to add to the give mytime object
	 */
	void addSec(uint32_t sec);

	/*
	 * Copy value of "source" mytime object to "dest" mytime object.
	 *
	 * arg source: the mytime object to copy
	 * arg dest: the mytime object to receive the values of source
	 */
	void copyTo(MyTime *dest);
	void copyFrom(MyTime *source);

	/*
	 * Returns non-zero if two mytime objects represent the same time, TAKING
	 * INTO ACCOUNT TIMEZONES. In other words, even if time_sec is different
	 * for the two objects, this will still return non-zero if the two times
	 * represent the same moment after adjusting for time zone differences.
	 *
	 * arg time1: the first time to compare
	 * arg time2: the second time to compare
	 */
	bool tickEqual(MyTime *other);

	/*
	 * Returns the difference between two times in milliseconds, to the nearest
	 * millisecond. In pseudo-math, returns (time1 - time2).
	 *
	 * arg time1: the first time to compare
	 * arg time2: the second time to compare
	 */
	int32_t diffMilliSec(MyTime *time2);

	/*
	 * Convert mytime struct to UTC hours, minutes, and seconds
	 *
	 * arg mytime: the mytime object to convert
	 * arg hours: hours after midnight UTC
	 * arg minutes: minutes after the hour UTC
	 * arg seconds: seconds after the minute UTC
	 */
	void toUTC(uint8_t *hours, uint8_t *minutes, uint8_t *seconds);

	/*
	 * Convert mytime struct to local hours, minutes, and seconds
	 *
	 * arg mytime: the mytime object to convert
	 * arg hours: hours after midnight local time
	 * arg minutes: minutes after the hour local time
	 * arg seconds: seconds after the minute local time
	 */
	void toLocal(uint8_t *hours, uint8_t *minutes, uint8_t *seconds);

	uint16_t serialize(uint8_t *buf, uint16_t buf_size, uint16_t pos);
	uint16_t deserialize(uint8_t *buf, uint16_t buf_size, uint16_t pos);

};

// Calendar time, broken down in terms of seconds, minutes, hours,
// day of the week, month, and year; loosely structured after
// struct tm in time.h
typedef struct CALTIME_STRUCT {
	uint8_t sec;	// Seconds after the minute
	uint8_t min;	// Minutes after the hour
	uint8_t hour;	// Hours since midnight
	uint8_t mday;	// Day of the month
	uint8_t month;	// Month of the year (1 = January)
	uint16_t year;	// The year in conventional format, ie the year 2020 is
					// represented as the number 2020
} CALTIME_t;



#line 2 "/home/anay/grampower/gpos_fw/gpos/utils/utils.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/buffer/buffer.h"
/**
 * @file buffer.h
 * Template for a generic buffer of items, plus helpers such as iterators,
 * parsers, and formatters which act on these buffers.
 *
 * Loosely equivalent to std::array, but with a size-independent superclass.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */






/**
 * Generic interface for a buffer of items.
 */
template <typename T>
class Buffer
{
public:
	/**
	 * Insert a new element at the end of the buffer.
	 *
	 * @param element New element to insert.
	 * @return true if element was inserted, false otherwise.
	 */
	virtual bool push(T element) = 0;

	/**
	 * Get value of element at a certain index in the buffer.
	 *
	 * @param element Place to put the retrieved element.
	 * @param index Index of desired element.
	 * @return true if element was successfully retrieved, false otherwise.
	 */
	virtual bool read(T *element, uint16_t index) const = 0;

	/**
	 * Delete the contents of the entire buffer.
	 */
	virtual void clear() = 0;

	/**
	 * Get number of elements currently stored in the buffer.
	 *
	 * @return number of elements currently stored in the buffer.
	 */
	virtual uint16_t length() = 0;

	/**
	 * Test whether an index is within the range of the buffer size.
	 *
	 * @param index Index to test.
	 * @return true if index is in range.
	 */
	virtual bool indexInRange(uint16_t index) = 0;

	/**
	 * Copy the contents of this Buffer to the given array, up to a maximum of
	 * 'len' elements.
	 *
	 * @param array Array to which we should copy elements.
	 * @param len Maximum number of elements to copy.
	 * @return number of elements copied.
	 */
	virtual uint16_t copyTo(T *array, uint16_t len) = 0;

	/**
	 * Erase this Buffer and copy the contents of the given array to the Buffer,
	 * up to a maximum of 'len' elements (or the Buffer's length, whichever is
	 * smaller).
	 *
	 * @param array Array from which we should copy elements.
	 * @param len Maximum number of elements to copy.
	 * @return number of elements copied.
	 */
	virtual uint16_t copyFrom(T *array, uint16_t len) = 0;

	/**
	 * When "=" operator is used, copy one buffer to another.
	 *
	 * NOTE: This could result in strange things if the buffers are not the
	 * same size!
	 */
	Buffer<T> & operator=(const Buffer<T> &buffer)
	{
		this->clear();

		T element;
		for (uint16_t i = 0; buffer.read(&element, i); i++)
		{
			this->push(element);
		}

		return *this;
	}


};


/**
 * Template for a simple statically-allocated buffer, designed for FIFO-type
 * applications such as communication buffers. Buffer elements can be read
 * in any order (random access) but can only be written sequentially.
 *
 * Another way to view this template is as a simplified, statically-allocated
 * version of std::queue.
 */
template <typename T, uint16_t size>
class StaticBuffer: public Buffer<T>
{
private:
	T _buffer[size];  /* The statically-allocated buffer. */
	uint16_t _bufferIndex;  /* Position of the last element in the buffer. */

public:
	StaticBuffer()
		: _bufferIndex(0)
	{
	}


	bool push(T element)
	{
		if (_bufferIndex < size)
		{
			_buffer[_bufferIndex] = element;
			_bufferIndex++;
			return true;
		}
		else
		{
			return false;
		}
	}


	bool read(T *element, uint16_t index) const
	{
		if (index < _bufferIndex)
		{
			*element = _buffer[index];
			return true;
		}
		else
		{
			return false;
		}
	}


	void clear()
	{
		_bufferIndex = 0;
	}

	bool indexInRange(uint16_t index)
	{
		return index < size;
	}

	uint16_t copyTo(T *array, uint16_t len)
	{
		uint16_t numToCopy = len < _bufferIndex ? len : _bufferIndex;
		for (uint16_t i = 0; i < numToCopy; i++)
		{
			array[i] = _buffer[i];
		}

		return numToCopy;
	}

	uint16_t copyFrom(T *array, uint16_t len)
	{
		clear();

		uint16_t numToCopy = len < size ? len : size;
		for (uint16_t i = 0; i < numToCopy; i++)
		{
			_buffer[i] = array[i];
		}

		_bufferIndex = numToCopy;
		return numToCopy;
	}

	/**
	 * When "=" operator is used, copy one buffer to another.
	 */
	StaticBuffer<T, size> & operator=(const StaticBuffer<T, size> &buffer)
	{
		this->clear();

		T element;
		for (uint16_t i = 0; buffer.read(&element, i); i++)
		{
			this->push(element);
		}

		return *this;
	}

	uint16_t length()
	{
		return _bufferIndex;
	}
};

/**
 * Parser which iterates through a bytestream, implemented as a Buffer<uint8_t>,
 * and pulls out different integer types as requested by the user. Uses MSB-first
 * formatting for integers.
 *
 * Inverse of BytestreamFormatter.
 */
class BytestreamParser
{
private:
	Buffer<uint8_t> &_buffer;
	uint16_t _index;

	/**
	 * Generic template for deserializing an integer from a Buffer<uint8_t>.
	 *
	 * NOTE: Implemented for general type T, but will only function predictably
	 * with integer types.
	 *
	 * @param result place to put the deserialized integer.
	 */
	template <typename T, uint8_t len>
	bool _getIntegerValue(T *result)
	{
		*result = 0;
		if (_index + len <= _buffer.length())
		{
			for (int i = 0; i < len; i++)
			{
				uint8_t byte;
				_buffer.read(&byte, _index + i);
				*result |= ((T)byte) << ((len - i - 1) * 8);
			}

			_index += len;
			return true;
		}
		else
		{
			return false;
		}
	}

public:
	/**
	 * Constructor for BytestreamParser.
	 *
	 * @param buffer buffer to parse.
	 */
	BytestreamParser(Buffer<uint8_t> &buffer)
		: _buffer(buffer),
		  _index(0)
	{
	}

	/**
	 * Get uint8_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getUint8(uint8_t *result)
	{
		return _getIntegerValue<uint8_t, 1>(result);
	}

	/**
	 * Get uint16_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getUint16(uint16_t *result)
	{
		return _getIntegerValue<uint16_t, 2>(result);
	}

	/**
	 * Get uint32_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getUint32(uint32_t *result)
	{
		return _getIntegerValue<uint32_t, 4>(result);
	}

	/**
	 * Get int8_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getInt8(int8_t *result)
	{
		return _getIntegerValue<int8_t, 1>(result);
	}

	/**
	 * Get int16_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getInt16(int16_t *result)
	{
		return _getIntegerValue<int16_t, 2>(result);
	}

	/**
	 * Get int32_t from the buffer.
	 *
	 * @param result place to put the integer.
	 * @return true if integer was successfully parsed, false otherwise.
	 */
	bool getInt32(int32_t *result)
	{
		return _getIntegerValue<int32_t, 4>(result);
	}

	/**
	 * Copy a certain amount of the buffer into an external buffer.
	 *
	 * The primary reason for "false" being returned would be if the
	 * destination buffer is not large enough to hold the number of bytes
	 * requested.
	 *
	 * @param buffer buffer in which to place these byte.
	 * @param numBytes number of bytes to copy.
	 * @return true if bytes were copied successfully, false otherwise.
	 */
	bool getBuffer(Buffer<uint8_t> &buffer, uint8_t numBytes)
	{
		if (bytesRemaining() < numBytes)
		{
			return false;
		}

		buffer.clear();
		uint8_t byte;
		for (int i = 0; i < numBytes; i++)
		{
			_buffer.read(&byte, _index + i);
			buffer.push(byte);
		}
		_index += numBytes;

		return true;
	}

	/**
	 * Get the number of unparsed bytes left in the buffer.
	 *
	 * @return number of unparsed bytes left in the buffer.
	 */
	uint16_t bytesRemaining()
	{
		if (_buffer.length() > _index)
		{
			return _buffer.length() - _index;
		}
		else
		{
			return 0;
		}
	}

	/**
	 * Move forward bytesToSkip bytes in the buffer without parsing those bytes.
	 *
	 * @param bytesToSkip number of bytes to move buffer forward.
	 * @return true if bytesToSkip bytes were skipped, false otherwise.
	 */
	bool skip(uint16_t bytesToSkip)
	{
		if (_index + bytesToSkip <= _buffer.length())
		{
			_index += bytesToSkip;
			return true;
		}
		else
		{
			return false;
		}
	}
};

/**
 * Formatter which creates a bytestream, implemented as a Buffer<uint8_t>,
 * from a series of integers of different types. Also accepts other buffers.
 * Uses MSB-first formatting for integers.
 *
 * Inverse of BytestreamParser.
 */
class BytestreamFormatter
{
private:
	Buffer<uint8_t> &_buffer;
	uint16_t _index;

	/**
	 * Generic template for serializing an integer into a Buffer<uint8_t>.
	 *
	 * NOTE: Implemented for general type T, but will only function predictably
	 * with integer types.
	 *
	 * @param value integer to serialize into the buffer.
	 */
	template <typename T, uint8_t len>
	bool _putIntegerValue(T value)
	{
		if (_buffer.indexInRange(_index + len - 1))
		{
			for (int i = 0; i < len; i++)
			{
				uint8_t byte = (value >> ((len - i - 1) * 8)) & 0xFF;
				_buffer.push(byte);
			}

			_index += len;
			return true;
		}
		else
		{
			return false;
		}
	}

public:
	/**
	 * Constructor for BytestreamFormatter. Clears the buffer passed to it.
	 *
	 * @param buffer buffer in which to insert the items passed to the formatter.
	 */
	BytestreamFormatter(Buffer<uint8_t> &buffer)
		: _buffer(buffer),
		  _index(0)
	{
		_buffer.clear();
	}

	/**
	 * Insert uint8_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putUint8(uint8_t value)
	{
		return _putIntegerValue<uint8_t, 1>(value);
	}

	/**
	 * Insert uint16_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putUint16(uint16_t value)
	{
		return _putIntegerValue<uint16_t, 2>(value);
	}

	/**
	 * Insert uint32_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putUint32(uint32_t value)
	{
		return _putIntegerValue<uint32_t, 4>(value);
	}

	/**
	 * Insert int8_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putInt8(int8_t value)
	{
		return _putIntegerValue<int8_t, 1>(value);
	}

	/**
	 * Insert int16_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putInt16(int16_t value)
	{
		return _putIntegerValue<int16_t, 2>(value);
	}

	/**
	 * Insert int32_t into the buffer.
	 *
	 * @param value value to insert.
	 * @return true if value was successfully inserted, false otherwise.
	 */
	bool putInt32(int32_t value)
	{
		return _putIntegerValue<int32_t, 4>(value);
	}

	/**
	 * Insert another buffer into the buffer.
	 *
	 * @param buffer buffer to insert.
	 * @return true if buffer was successfully inserted, false otherwise.
	 */
	bool putBuffer(Buffer<uint8_t> &buffer)
	{
		if (! _buffer.indexInRange(_index + buffer.length() - 1))
		{
			return false;
		}

		uint8_t byte;
		for (int i = 0; i < buffer.length(); i++)
		{
			buffer.read(&byte, i);
			_buffer.push(byte);
		}
		_index += buffer.length();

		return true;
	}
};


/**
 * Iterator which iterates over one complete cycle of a buffer starting from
 * where it stopped in the last iteration.
 *
 * For example, say a CyclicIterator is iterating over a buffer of length 4.
 * On the first call to "get", element 0 is returned. On the second call,
 * element 1 is returned. Now, if reset() is called at this point then get()
 * is called continuously until it returns false, the elements returned will be
 * element 2, element 3, element 0, then element 1.
 */
template <typename T>
class CyclicIterator
{
private:
	StaticBuffer<T, 1> _emptyBuffer;
	Buffer<T> *_buffer;
	uint16_t _index;
	uint16_t _startIndex;
	bool _done;

	uint16_t _getNextIndex()
	{
		if ((_index + 1) >= _buffer->length())
		{
			return 0;
		}
		else
		{
			return _index + 1;
		}
	}

public:
	CyclicIterator()
		: _buffer(&_emptyBuffer),
		  _index(0),
		  _startIndex(0),
		  _done(false)
	{
	}

	CyclicIterator(Buffer<T> &buffer)
		: _buffer(&buffer),
		  _index(0),
		  _startIndex(0),
		  _done(false)
	{
	}


	void associateBuffer(Buffer<T> &buffer)
	{
		_buffer = &buffer;
		_index = 0;
		_startIndex = 0;
	}


	bool get(T *element)
	{
		if (_done)
		{
			return false;
		}
		else
		{
			bool success = _buffer->read(element, _index);
			_index = _getNextIndex();

			if (_buffer->length() == 1)
			{
				_done = true;
			}
			else
			{
				if (_index == _startIndex)
				{
					_done = true;
				}
				else
				{
					_done = false;
				}
			}

			return success;
		}
	}

	void reset()
	{
		if (_buffer->length() == 1)
		{
			_index = 0;
		}

		_startIndex = _index;
		_done = false;
	}
};


#line 4 "/home/anay/grampower/gpos_fw/gpos/utils/utils.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/time/stop_watch.h"
/*
 * timer.h
 */ 







class StopWatch
{
private:
	MyTime *_systemTime;
	MyTime _startTime;

public:
    StopWatch (MyTime *systemTime_);
    void reset();
    int32_t getElapsedMilliSec();
    void delay(uint32_t milliSec);
};


#line 6 "/home/anay/grampower/gpos_fw/gpos/utils/utils.h"
#line 12 "/home/anay/grampower/gpos_fw/gpos/hardware/components/radio/rc11xx.h"



typedef enum rc_command {
	signal_strength, // returns one byte indicating signal strength, 'S'
	temperature_monitoring, // returns one byte indicating temperature
	battery_monitoring, // returns one byte indicating power supply voltage
	memory_read, //returns one byte value from the configuration memory (one byte argument)
	memory_configuration,
	memory_reset,
	exit_command,
	set_router_mode,
	set_gateway_mode,
	set_endnode_mode,
	test_mode_0,
	test_mode_1,
	test_mode_3,
	test_mode_5
} rc_command_t;

typedef enum rc_network_type {
	transparent_mode, packet_mode
} rc_network_type_t;

typedef enum rc_node_type {
	gateway,
	router,
	endnode
} rc_node_type_t;

typedef uint32_t rc_unique_id_t;
typedef uint32_t rc_system_id_t;


class RC11XX: public SerialDevice
{
private:
	base::IOPin* _configPin;
	base::IOPin* _resetPin;
	base::IOPin* _ctsPin;
	base::UART* _uart;
	bool _inConfigMode;

	void _executeCommand(rc_command_t command, uint8_t arg1, uint8_t arg2, uint8_t *result);
	void _waitForPrompt();
	void _waitForResult(uint8_t* result);

public:


	RC11XX(base::IOPin* configPin_, base::IOPin* resetPin_,
			base::IOPin* ctsPin_, base::UART* uart_);

	void enterConfigMode();
	void exitConfigMode();
	void reset(StopWatch *stopwatch);

	void setChannel(uint8_t channel);

	void setNodeType(rc_node_type_t nodeType);

	void setNetworkType(rc_network_type_t networkType);
	rc_network_type_t getNetworkType();

	void setUniqueId(rc_unique_id_t id);
	rc_unique_id_t getUniqueId();

	void setSystemId(rc_system_id_t id);
	rc_system_id_t getSystemId();

	void revertToFactoryDefault();
	uint8_t getRSSIReading();
	void sendTXCarrier();

	bool send(uint8_t byte);
	bool recv(uint8_t* byte);
	bool readable();
	uint8_t numBytesWriteable();
};

#line 8 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/relay/latching_relay.h"
/*
 * non_latching_relay.h
 *
 * Driver for a non-latching single-coil relay.
 *
 * Example usage:
 * 		IOPin pin(PORT2, 1, base::output)
 * 		NonLatchingRelay relay(&pin, inverted)
 * 		relay.turnOn();
 *
 */




#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/relay/relay.h"
/**
 * @file relay.h
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */








class Relay
{
public:
	virtual void turnOn() = 0;
	virtual void turnOff() = 0;
	virtual void toggle() = 0;
};


#line 17 "/home/anay/grampower/gpos_fw/gpos/hardware/components/relay/latching_relay.h"






class LatchingRelay: public Relay
{
private:
	const uint16_t LATCHING_TIME_MS;

	/** the microcontroller pins driving the relay */
	base::IOPin* _setPin;
	base::IOPin* _resetPin;

	StopWatch _delayTimer;
	enum latching_relay_state
	{
		on,
		off,
		unknown
	} state;

public:
	LatchingRelay(base::IOPin* setPin_, base::IOPin* resetPin_, MyTime* systemTime);
	void update();
	void turnOn();
	void turnOff();
	void toggle();
};




#line 9 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/relay/non_latching_relay.h"
/*
 * non_latching_relay.h
 *
 * Driver for a non-latching single-coil relay.
 *
 * Example usage:
 * 		IOPin pin(PORT2, 1, base::output)
 * 		NonLatchingRelay relay(&pin, inverted)
 * 		relay.turnOn();
 *
 */









class NonLatchingRelay: public Relay
{
private:
	/** the microcontroller pin driving the relay */
	base::IOPin* _ioPin;

	/** either inverted or noninverted;
	 * inverted configuration implies that relay is closed when microcontroller pin is driven low */
	logic_t _logic;
	binary_state_t state;

public:
	NonLatchingRelay(base::IOPin* ioPin_, logic_t logic);
	void turnOn();
	void turnOff();
	void toggle();
};




#line 10 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/hardware/components/simple_serial/simple_serial.h"
/**
 * @file simple_serial.h
 * Simplest kind of SerialDevice which simply passes bytes on the UART port.
 *
 * TODO: Come up with a better name for this.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */








class SimpleSerial: public SerialDevice
{
private:
	base::UART* _uart;


public:
	SimpleSerial(base::UART* uart_, uint32_t baud_);
	bool send(uint8_t byte);
	bool recv(uint8_t *byte);
	bool readable();
	uint8_t numBytesWriteable();
};

#line 11 "/home/anay/grampower/gpos_fw/gpos/hardware/components/drivers.h"
#line 5 "/home/anay/grampower/gpos_fw/gpos/hardware/boards/board.h"
#line 1 "/home/anay/grampower/gpos_fw/gpos/utils/utils.h"
#line 6 "/home/anay/grampower/gpos_fw/gpos/hardware/boards/board.h"

class Board : public base::TimerUser
{
public:


	void init();
	static MyTime systemTime;
	virtual void update()=0;
};

#line 2 "/home/anay/grampower/gpos_fw/gpos/hardware/boards/board.cpp"

MyTime Board::systemTime;

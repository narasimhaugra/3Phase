/**
 * @file board_node_1_3.cpp
 * Board definition for Node v1.3.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "board_node_1_3.h"

using namespace msp430f6733;


BoardNode13::BoardNode13()
    : watchdog(),
    _clock(),
    _timer(TIMER_A0),
    _scrollButtonPullUpSupply(PORTJ, 1, base::output, base::high),
    _coverTamperPullUpSupply(PORTJ, 0, base::output, base::high),
    _rfCtsPin(PORT5, 7, base::input, base::high),
    _rfConfigPin(PORT5, 6, base::output, base::high),
    _rfResetPin(PORT6, 2, base::output, base::high),
    _irShutdownPin(PORT6, 7, base::output, base::high),
    _lcdBacklightPin(PORT6, 3, base::output, base::high),
    _scrollButtonPin(PORT2, 7, base::input, base::high),
    _coverTamperButtonPin(PORT2, 4, base::input, base::high),
    relayPin1(PORTJ, 2, base::output, base::high),  /** High to keep relay on during startup */
    //_relayPin2(PORT6, 5, base::output, base::low),
    _lcdDriver(S12),
    _rfSerial(USCIA0),
    _irSerial(USCIA1),
    _maxwellSerial(USCIA2),
    _externalFlashSPI(USCIB0, PORTJ, 3),
    maxwellMainsIndicator(PORT1, 6, base::input, base::low),
    maxwellNeutralMissing(PORT2, 6, base::input, base::high),
    maxwellGPIO2(PORT5, 4, base::input, base::low),
    maxwellResetPin(PORT6, 4, base::output, base::high),
    mainVCCControl(PORT1, 1, base::output , base::high),
    infoFlash(&watchdog),
    lcdBacklight(&_lcdBacklightPin, inverted),
    energyMeterLcd(&_lcdDriver, inverted_sequence),
    rfModule(&_rfConfigPin, &_rfResetPin, &_rfCtsPin, &_rfSerial),
    irModule(&_irShutdownPin, &_irSerial),
    maxwellComm(&_maxwellSerial, 2400),
    externalFlash(&_externalFlashSPI),
    coverTamperButton(&_coverTamperButtonPin, low_when_pressed),
    scrollButton(&_scrollButtonPin, low_when_pressed),
    rtc(RTC::interrupt_mode),
    _powerMode(sub_2_ma),
    timeUpdateSw(&systemTime),
    noPowerLoopCycle(0)
{
    _irSerial.setBaud(9600); //(57600);
    SFRRPCR |= SYSNMI;  /** Disable reset pin by putting it into NMI mode */
    lcdBacklight.turnOff();

    /** Set up time systems */
    systemTime.set(0, 0, 4096, 0);

    /** We try to ensure that systemTime is synchronised with the RTC time.
    * If the synchronisation is successful, then timeUpdateSucceeded is set to true.
    * We can probably add a BOARD_ASSERT(timeUpdateSucceeded) call to ensure
    * that the update is successful
    */

    uint8_t count = 0;
    
    while (count < 50)
    {
        if (_updateSystemTimeFromRTC())
        {
            break;
        }
        count++;
    }

    timeUpdateSw.reset();

    /** setCallback would register the Board's _timerCallback function with the
    * _timer module; hence, _timerCallback would be called in the ISR of the module */

    _timer.setCallback(this);
    _EINT();  /** Enable interrupts */

    StopWatch rfStopWatch(&systemTime);
    rfModule.reset(&rfStopWatch);

    // while transiting from super sleep to normal mode,
    // the RC config pin goes from high to low, and the RC module enters config state
    // Hence, forcefully exiting config mode

    _rfSerial.put('X');

    externalFlash.enable();

    mainVCCControl.setLow();

    setPowerMode(BoardNode13::normal);

    watchdog.enable();
}

void BoardNode13::requestReset()
{
    noPowerLoopCycle = 1;
}

/*
 * Reseting using PMM module is a hard reset. Earlier,
 * watchdog module was used for reseting (watchdog.resetSystem())
 */

void BoardNode13 :: _reset()
{
    PMMCTL0 = ((PMMCTL0 & 0xFF) | PMMPW) | PMMSWBOR;  /** Reset system */
}

void BoardNode13::update()
{
    if (noPowerLoopCycle)
    {
        ++noPowerLoopCycle;
    }
    if (noPowerLoopCycle >= 4)
    {
        _reset();
    }

    watchdog.kick();
    _rfSerial.update();
    _irSerial.update();
    _maxwellSerial.update();

    /** Synchronize the systemTime variable with the RTC */

    if (timeUpdateSw.getApproxElapsedSec() >= 60)
    {
        if (_updateSystemTimeFromRTC())
        {
            timeUpdateSw.reset();
        }
    }
}

void BoardNode13::_timerCallback()
{
    systemTime.addIncrement(1);
}

void BoardNode13::setPowerMode(power_mode_t mode)
{
    switch (mode)
    {
    case normal:
        _powerMode = normal;
        _rfConfigPin.setHigh();
        _rfCtsPin.setHigh();
        _rfResetPin.setHigh();
        _rfSerial.enable();
        _externalFlashSPI.enable();
        externalFlash.enable();
        _irSerial.setBaud(9600);
        _rfSerial.setBaud(19200);
        break;

    case sub_2_ma:
        _powerMode = sub_2_ma;
        /*
        * These pins are kept as inputs because the UI uses these LED's
        * even in sub_2_ma mode. UI doesn't know which mode the
        * uC is running on.
        */
        _rfConfigPin.setLow();
        _rfCtsPin.setLow();
        _lcdBacklightPin.setLow();
        _rfResetPin.setLow();
        _rfSerial.disable();
        _externalFlashSPI.disable();
        externalFlash.disable();
        break;
    }
}

bool BoardNode13::_updateSystemTimeFromRTC()
{
    datetime_t rtcTime;
    struct tm formattedTime;

    if (! rtc.getDatetime(rtcTime))
    {
        return false;
    }

    formattedTime.tm_year = rtcTime.year - 1900;
    formattedTime.tm_mon = rtcTime.month - 1;
    formattedTime.tm_mday = rtcTime.day;
    formattedTime.tm_hour = rtcTime.hour;
    formattedTime.tm_min = rtcTime.minute;
    formattedTime.tm_sec = rtcTime.second;
    formattedTime.tm_isdst = -1;

    uint32_t unixTime = mktime(&formattedTime) - SECONDS_BETWEEN_1900_AND_1970;
    systemTime.setRealTime(unixTime);

    return true;
}

void BoardNode13::assertRaise(char* filePath, uint16_t lineNumber)
{

  /*assert commented for now*/

//    StopWatch assertTimer(&systemTime);
//    assertTimer.reset();
//    lcdBacklight.turnOn();
//    energyMeterLcd.exitBlinkingMode();
//    energyMeterLcd.clearAll();
//
//
//    // Infer filename from filepath
//    uint8_t length = 0;
//    uint8_t lastSlash = 0;
//    char fileName[6];
//    while(filePath[length] != '\0')
//    {
//        length = length + 1;
//        if(filePath[length] == '/')
//        {
//            lastSlash = length;
//        }
//    }
//    uint8_t i;
//    for(i=0; i<6; i++)
//    {
//        fileName[i] = filePath[lastSlash + i + 1] - 32;
//    }
//
//
//
//    enum
//    {
//        ERR_STATE,
//        FILENAME_STATE,
//        LINE_NUMBER_STATE
//    } displayState;
//
//    displayState = ERR_STATE;
//
//    enum
//    {
//        NO_CHAR_RECEIVED,
//        FIRST_CHAR_RECEIVED,
//        SECOND_CHAR_RECEIVED,
//        THIRD_CHAR_RECEIVED
//    } parsingState;
//
//    parsingState = NO_CHAR_RECEIVED;
//    while(1)
//    {
//        watchdog.kick();
//
//        // Check if reset assert command has been received
//        char commandReceived;
//        if (rfModule.recv((uint8_t*)&commandReceived) || irModule.recv((uint8_t*)&commandReceived))
//        {
//            if(parsingState == NO_CHAR_RECEIVED && commandReceived == 'x')
//            {
//                parsingState = FIRST_CHAR_RECEIVED;
//            }
//            if(parsingState == FIRST_CHAR_RECEIVED && commandReceived == '%')
//            {
//                parsingState = SECOND_CHAR_RECEIVED;
//            }
//            if(parsingState == SECOND_CHAR_RECEIVED && commandReceived == '?')
//            {
//                parsingState = THIRD_CHAR_RECEIVED;
//                break;
//            }
//        }
//
//
//        // Toggle through the display states
//        if(assertTimer.getElapsedMilliSec() > 6000)
//        {
//            if(displayState != ERR_STATE)
//            {
//                energyMeterLcd.clearAll();
//                energyMeterLcd.displayString("ERR   ", 6);
//                assertTimer.reset();
//            }
//            displayState = ERR_STATE;
//        }
//        else if(assertTimer.getElapsedMilliSec() > 4000)
//        {
//            if(displayState != LINE_NUMBER_STATE)
//            {
//                energyMeterLcd.clearAll();
//                energyMeterLcd.displayString("L", 1);
//                energyMeterLcd.displayIntegerWithoutClearing(lineNumber);
//            }
//            displayState = LINE_NUMBER_STATE;
//        }
//        else if(assertTimer.getElapsedMilliSec() > 2000)
//        {
//            if(displayState != FILENAME_STATE)
//            {
//                energyMeterLcd.clearAll();
//                energyMeterLcd.displayString("F", 1);
//                energyMeterLcd.displayString(fileName, 6);
//            }
//            displayState = FILENAME_STATE;
//        }
//    }
}

bool BoardNode13 :: checkMainsSupply()
{
    bool sts = false;
    uint8_t count = 0;
    
	// P2.6 ( Wakeup = NM | MVCC ) configuration
    P2SEL &= ~BIT6;     // P2.6 Selected as GPIO
	P2IE  &=  BIT6;     // P2.6 disable interrupt
    P2REN &= ~BIT6;     // P2.6 disable Pullup/Pulldown. bcoz, series R = 20k (very high)
    P2DIR &= ~BIT6;     // P2.6 input mode 
    // P2OUT &= ~BIT6;  // P2.6 not required since pin is i/p and REN = off
    P2IES &= ~BIT6;     // P2.6 Low to High transition Interrupt
    P2IFG &= ~BIT6;     // P2.6 Clear any Pending Interrupt
    
	// P1.6 ( MVCC only, i.e. Mains Indicator ) configuration                           
    P1SEL &= ~BIT6;     // P1.6 Selected as GPIO
	P1IE  &=  BIT6;     // P1.6 disable interrupt
	P1REN |=  BIT6;     // P1.6 Enable Pullup/Pulldown Resitors
	P1DIR &= ~BIT6;     // P1.6 Input Mode
    P1OUT &= ~BIT6;     // P1.6 Pulldown resistor applied, series R = 5K
    P1IES &= ~BIT6;     // P1.6 Low to High transition Interrupt
	P1IFG &= ~BIT6;     // P1.6 Clear any Pending Interrupt

    for (uint8_t i = 0; i < 100; i++)
    {
        if ((P1IN & BIT6) || (P2IN & BIT6))
        {
            count++;
            if ( count > 60 )
            {
                sts = true;
                break;
            }
        }
    }
    
	// P2.6 ( Wakeup = NM | MVCC ) configuration
    P2SEL &= ~BIT6;     // P2.6 Selected as GPIO
    P2REN |=  BIT6;     // P2.6 enable Pullup/Pulldown resitor
    P2DIR |=  BIT6;     // P2.6 output mode
    P2OUT &= ~BIT6;     // P2.6 make output low to drain charged line via series 20k pulled down
    
	// P1.6 ( MVCC only, i.e. Mains Indicator ) configuration                           
    P1SEL &= ~BIT6;     // P1.6 Selected as GPIO
	P1REN |=  BIT6;     // P1.6 Enable Pullup/Pulldown Resitors
	P1DIR |=  BIT6;     // P1.6 output Mode 
    P1OUT &= ~BIT6;     // P1.6 make output low to drain charged line via series 5k

    return sts;
}

bool BoardNode13::amIrestarting()
{
    if (noPowerLoopCycle)
    {
        return true;
    }
    return false;
}

BoardNode13::power_mode_t BoardNode13::getPowerMode()
{
    return _powerMode;
}
// ===============================================================================================
// end of file
// ===============================================================================================

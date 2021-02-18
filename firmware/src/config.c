#include <xc.h>
#include <stdint.h>
#include "config.h"


#pragma config WDTEN  = OFF
#pragma config PLLDIV = 2
#pragma config STVREN = ON
#pragma config XINST  = OFF

#pragma config CPUDIV = OSC2_PLL2
#pragma config CP0    = ON

#pragma config OSC = INTOSCPLL
#pragma config T1DIG = OFF
#pragma config LPT1OSC = OFF
#pragma config FCMEN = OFF
#pragma config IESO = OFF

#pragma config WDTPS = 32768

#pragma config DSWDTOSC = INTOSCREF

#pragma config RTCOSC = T1OSCREF
#pragma config DSBOREN = OFF
#pragma config DSWDTEN = OFF
#pragma config DSWDTPS = 8192

#pragma config IOL1WAY = OFF
#pragma config MSSP7B_EN = MSK7

#pragma config WPFP = PAGE_1
#pragma config WPEND = PAGE_0
#pragma config WPCFG = OFF

#pragma config WPDIS = OFF


void init(void) {
    //disable interrupts
    INTCONbits.GIE = 0;

    //8 MHz oscillator
    OSCCONbits.IRCF = 0b111;
    while (!OSCCONbits.OSTS); //Oscillator Start-up Timer time-out has expired; primary oscillator is running

    //wait for PLL lock
    OSCTUNEbits.PLLEN = 1;
    _delay(60000);

    //all lines are outputs (except for A3, B3, B7 and C6)
    TRISA = 0b00001000;
    TRISB = 0b10001000;
    TRISC = 0b01000000;

    //clear all outputs
    LATA = 0;
    LATB = 0;
    LATC = 0;

    //Disable analog input
    ANCON0 = 0b11110111; //AN3 is input
    ANCON1 = 0b11111111;
}


void wait_short(void) {
    for (uint8_t i=0; i<64; i++) {
        _delay(10000);
    }
}


void reset(void) {
    Reset();
}

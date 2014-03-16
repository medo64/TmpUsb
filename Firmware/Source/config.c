#include <p18cxxx.h>
#include <delays.h>
#include "config.h"


#pragma config WDTEN  = OFF
#pragma config PLLDIV = 2
#pragma config STVREN = ON
#pragma config XINST  = OFF

#pragma config CPUDIV = OSC2_PLL2
#pragma config CP0    = OFF

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

    //all lines are outputs (except for RB7 and RC6)
    TRISA = 0;
    TRISB = 0b10000000;
    TRISC = 0b01000000;

    //clear all outputs
    LATA = 0;
    LATB = 0;
    LATC = 0;

    //Disable analog input
    ANCON0 = 0xFF;
    ANCON1 = 0xFF;

    //wait for PLL lock
    OSCTUNEbits.PLLEN = 1;
    wait_10ms();
}

void wait_10ms(void) {
    Delay10KTCYx(6); //@ 24 MHz
}

void wait_1s(void) {
    Delay10KTCYx(180);
    Delay10KTCYx(180);
    Delay10KTCYx(180);
    Delay10KTCYx(180);
}

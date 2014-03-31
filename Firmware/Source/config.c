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

    ADCON1bits.ADFM = 1;     //Right justified
    ADCON1bits.ACQT = 0b001; //20 Tad [2+ us]
    ADCON1bits.ADCS = 0b110; //Fosc/64  [1-25 us]
    ADCON0bits.VCFG = 0b00;  //Vref source: AVdd, AVss
    ADCON0bits.ADON  = 1; // Turn on ADC

    //wait for PLL lock
    OSCTUNEbits.PLLEN = 1;
    wait_10ms();
}

void wait_10ms(void) {
    Delay10KTCYx(6); //@ 24 MHz
}

void wait_100ms(void) {
    Delay10KTCYx(72); //@ 24 MHz
}

void wait_1s(void) {
    Delay10KTCYx(180);
    Delay10KTCYx(180);
    Delay10KTCYx(180);
    Delay10KTCYx(180);
}

#include <p18cxxx.h>
#include "timing.h"
#include "config.h"


unsigned short timing_getCharge() {
    OSCCONbits.IRCF = 0b100;
    while (!OSCCONbits.OSTS); //Oscillator Start-up Timer time-out has expired; primary oscillator is running

    ANCON0bits.PCFG3 = 0; //Pin configured as an analog channel

    ADCON0bits.VCFG = 0b00;  //Vref source: AVdd, AVss
    ADCON0bits.CHS = 3;      //AN3

    ADCON1bits.ADFM = 1;     //Right justified
    ADCON1bits.ACQT = 0b001; //2 Tad
    ADCON1bits.ADCS = 0b011; //Frc (clock derived from A/D RC oscillator)

    ADCON0bits.ADON = 1;     //Turn on ADC

    PIR1bits.ADIF = 0;
    ADCON0bits.GO  = 1;
    while(!PIR1bits.ADIF); //Wait for A/D convert complete
    return ADRES;
}

void timing_charge() {
    TRISBbits.TRISB3 = 0;
    LATBbits.LATB3 = 1;
}

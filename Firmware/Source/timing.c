#include <p18cxxx.h>
#include "timing.h"


void timing_charge() {
    TRISBbits.TRISB3 = 0;
    LATBbits.LATB3 = 1;
}

unsigned int timing_getCharge() {
    ADCON0bits.CHS = 3; //AN3
    ADCON0bits.GO  = 1;
    while(ADCON0bits.GO); //Wait for A/D convert complete
    return ADRES;
}

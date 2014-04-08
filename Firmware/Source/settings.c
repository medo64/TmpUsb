#include <p18cxxx.h>
#include <string.h>
#include <GenericTypeDefs.h>

#include "io.h"


#define SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH      0
#define SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW       1
#define SETTING_INDEX_ISARMED                       2

#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH    0
#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW    42
#define SETTING_DEFAULT_ISARMED                     0


#define BLOCK_ERASE_SIZE                         1024
#define BLOCK_BUFFER_SIZE                          64

#pragma romdata ROM_CONFIGURATION=0xF000
    rom unsigned char SettingsRomBlock[BLOCK_ERASE_SIZE] = { SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH, SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW, SETTING_DEFAULT_ISARMED, 0 };
#pragma romdata

unsigned char SettingsBuffer[BLOCK_BUFFER_SIZE];


void settings_init() {
    memcpypgm2ram((void*)SettingsBuffer, (rom void*)SettingsRomBlock, sizeof(SettingsBuffer));
}

void settings_write(void) {
    unsigned char i, j;
    unsigned char buffer[BLOCK_BUFFER_SIZE] = { 0 };

    io_led_toggle();

    //Erase all
    TBLPTR = (unsigned short long)(SettingsRomBlock);
    EECON1 = 0x14;      //FREE + WREN
    EECON2 = 0x55;
    EECON2 = 0xAA;
    EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete

    //write settings
    for (i=0; i<BLOCK_ERASE_SIZE/BLOCK_BUFFER_SIZE; i++) {
        if (i==0) {
            memcpy((void*)buffer, (void*)SettingsBuffer, sizeof(SettingsBuffer));
        } else {
            memset((void*)buffer, '\0', BLOCK_BUFFER_SIZE);
        }

        TBLPTR = (unsigned short long)(SettingsRomBlock + (int)i * BLOCK_BUFFER_SIZE - BLOCK_BUFFER_SIZE);
        for (j=0; j<BLOCK_BUFFER_SIZE; j++) {
            TABLAT = buffer[j];
            _asm TBLWTPOSTINC _endasm
        }

        EECON1 = 0x04;      //WREN
        EECON2 = 0x55;
        EECON2 = 0xAA;
        EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete
    }
    EECON1bits.WREN = 0;    //Good practice to disable any further writes now.

    io_led_toggle();
}

void settings_reset() {
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH] = SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH;
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW]  = SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW;
    SettingsBuffer[SETTING_INDEX_ISARMED]                  = SETTING_DEFAULT_ISARMED;
    settings_write();
}


unsigned int settings_getTimingChargeLimit() {
    return SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH] * 256 + SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW];
}

void settings_setTimingChargeLimit(unsigned int value) {
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH] = (unsigned char)(value / 256);
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW]  = (unsigned char)(value & 0xFF);
    settings_write();
}


BOOL settings_getIsArmed() {
    return SettingsBuffer[SETTING_INDEX_ISARMED] ? TRUE : FALSE;
}

void settings_setIsArmed(BOOL value) {
    SettingsBuffer[SETTING_INDEX_ISARMED] = value ? 1 : 0;
    settings_write();
}

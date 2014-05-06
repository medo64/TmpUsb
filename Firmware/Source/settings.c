#include <p18cxxx.h>
#include <stdbool.h>
#include <string.h>

#include "system.h"

#include "io.h"
#include "timing.h"


#define SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH    0
#define SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW     1
#define SETTING_INDEX_ISARMED                     2
#define SETTING_INDEX_ISREADONLY                  3

#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH  0
#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW   TIMING_DEFAULT
#define SETTING_DEFAULT_ISARMED                   0
#define SETTING_DEFAULT_ISREADONLY                0


#define BLOCK_ERASE_SIZE  DRV_FILEIO_INTERNAL_FLASH_CONFIG_ERASE_BLOCK_SIZE
#define BLOCK_WRITE_SIZE  DRV_FILEIO_INTERNAL_FLASH_CONFIG_WRITE_BLOCK_SIZE

const uint8_t SettingsRomBlock[BLOCK_ERASE_SIZE] @0xF000 = { SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH, SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW, SETTING_DEFAULT_ISARMED, SETTING_DEFAULT_ISREADONLY, 0 };

uint8_t SettingsBuffer[BLOCK_WRITE_SIZE];


void settings_init() {
    memcpy((void*)SettingsBuffer, (const void*)SettingsRomBlock, sizeof(SettingsBuffer));
}

void settings_write(void) {
    uint8_t buffer[BLOCK_WRITE_SIZE] = { 0 };

    io_led_active();

    //Erase all
    TBLPTR = (uint32_t)(&SettingsRomBlock[0]);
    EECON1 = 0x14;      //FREE + WREN
    EECON2 = 0x55;
    EECON2 = 0xAA;
    EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete

    //write settings
    for (uint8_t i=0; i<BLOCK_ERASE_SIZE/BLOCK_WRITE_SIZE; i++) {
        if (i == 0) {
            memcpy((void*)buffer, (void*)SettingsBuffer, sizeof(SettingsBuffer));
        } else {
            memset((void*)buffer, '\0', BLOCK_WRITE_SIZE);
        }

        TBLPTR = (uint32_t)(&SettingsRomBlock[0] + i * BLOCK_WRITE_SIZE - BLOCK_WRITE_SIZE);
        for (uint8_t j = 0; j < BLOCK_WRITE_SIZE; j++) {
            TABLAT = buffer[j];
            asm("TBLWTPOSTINC");
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
    SettingsBuffer[SETTING_INDEX_ISREADONLY]               = SETTING_DEFAULT_ISREADONLY;
    settings_write();
}


unsigned short settings_getTimingChargeLimit() {
    return SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH] * 256 + SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW];
}

void settings_setTimingChargeLimit(unsigned short value) {
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_HIGH] = (uint8_t)(value / 256);
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT_LOW]  = (uint8_t)(value & 0xFF);
    settings_write();
}


bool settings_getIsArmed() {
    return (SettingsBuffer[SETTING_INDEX_ISARMED] != 0) ? true : false;
}

void settings_setIsArmed(bool value) {
    SettingsBuffer[SETTING_INDEX_ISARMED] = value ? 1 : 0;
    if (value == false) { SettingsBuffer[SETTING_INDEX_ISREADONLY] = 0; } //read-only must be off if drive is not armed
    settings_write();
}


bool settings_getIsReadOnly() {
    return (SettingsBuffer[SETTING_INDEX_ISREADONLY] != 0) ? true : false;
}

void settings_setIsReadOnly(bool value) {
    SettingsBuffer[SETTING_INDEX_ISREADONLY] = value ? 1 : 0;
    settings_write();
}

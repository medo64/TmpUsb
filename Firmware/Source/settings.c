#include "io.h"


#define SETTING_INDEX_TIMING_CHARGE_LIMIT           0
#define SETTING_INDEX_ISARMED                       2

#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH    0
#define SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW   142
#define SETTING_DEFAULT_ISARMED                     0


#define BLOCK_ERASE_SIZE                         1024
#define BLOCK_BUFFER_SIZE                          64

#pragma romdata ROM_CONFIGURATION=0xF800
    rom unsigned char SettingsRomBlock[BLOCK_ERASE_SIZE] = { SETTING_DEFAULT_TIMING_CHARGE_LIMIT_HIGH, SETTING_DEFAULT_TIMING_CHARGE_LIMIT_LOW, SETTING_DEFAULT_ISARMED, 0 };
#pragma romdata

unsigned char SettingsBuffer[BLOCK_BUFFER_SIZE];


void settings_init() {
    unsigned char i;
    for (i = 0; i < 64; i++) {
        SettingsBuffer[i] = SettingsRomBlock[i];
    }
}

void settings_write(void) {
    io_led_toggle();
    //
    io_led_toggle();
}


unsigned int settings_getTimingChargeLimit() {
    return (SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT]<<8) + SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT + 1];
}

void settings_setTimingChargeLimit(unsigned int value) {
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT]     = (value>>8);
    SettingsBuffer[SETTING_INDEX_TIMING_CHARGE_LIMIT + 1] = (value & 0xFF);
    settings_write();
}


unsigned char settings_getIsArmed() {
    return SettingsBuffer[SETTING_INDEX_ISARMED];
}

void settings_setIsArmed(unsigned char value) {
    SettingsBuffer[SETTING_INDEX_ISARMED] = value;
    settings_write();
}

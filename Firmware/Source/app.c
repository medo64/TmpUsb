#include <p18cxxx.h>
#include "config.h"
#include "fat12.h"
#include "io.h"
#include "settings.h"
#include "timing.h"

#include "app_usb.h"
#include "usb.h"


void main(void) {
    unsigned int timingCharge;
    unsigned char isArmed;

    init();
    timingCharge = timing_getCharge();
    timing_charge();

    io_init();
    settings_init();


    isArmed = (io_disk_isLabelArmed() || settings_getIsArmed());

    
    if (!io_disk_isValid()) {
        unsigned char label[] = { FAT12_ROOT_LABEL };
        io_disk_erase(label);
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (isArmed && (timingCharge < settings_getTimingChargeLimit())) { //Check if it needs to be deleted
        unsigned char label[] = { FAT12_ROOT_LABEL };
        io_disk_erase(label);
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (io_disk_isLabelCalibrate()) {
        unsigned char label[12] = "Set "; //11 + null char
        if (timingCharge >= 1000) {
            label[4] = 0x30 + (unsigned char)(timingCharge / 1000);
            label[5] = 0x30 + (unsigned char)((timingCharge / 100) % 10);
            label[6] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[7] = 0x30 + (unsigned char)(timingCharge % 10);
            label[8] = '\0';
        } else if (timingCharge >= 100) {
            label[4] = 0x30 + (unsigned char)(timingCharge / 100);
            label[5] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[6] = 0x30 + (unsigned char)(timingCharge % 10);
            label[7] = '\0';
        } else if (timingCharge >= 10) {
            label[4] = 0x30 + (unsigned char)(timingCharge / 10);
            label[5] = 0x30 + (unsigned char)(timingCharge % 10);
            label[6] = '\0';
        } else {
            label[4] = 0x30 + (unsigned char)timingCharge;
            label[5] = '\0';
        }
        io_disk_erase(label);
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
    }


    USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

    while(1) {
        USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)
        ProcessIO();        
    }
}

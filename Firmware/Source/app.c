#include <p18cxxx.h>
#include "config.h"
#include "fat12.h"
#include "io.h"
#include "settings.h"
#include "timing.h"

#include "app_usb.h"
#include "usb.h"


#define DEBUG  0


void main(void) {
    unsigned int timingCharge;
    unsigned char isArmed;

    timingCharge = timing_getCharge();


    init();
    io_init();
    settings_init();

    timing_charge();


    isArmed = (io_disk_isLabelArmed() || settings_getIsArmed());

    
    if (!io_disk_isValid()) {
        
        unsigned char label[] = { FAT12_ROOT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(0);

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (isArmed && (timingCharge < settings_getTimingChargeLimit())) { //Check if it needs to be deleted

        unsigned char label[] = { FAT12_ROOT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(0);

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (io_disk_isLabelCalibrate()) {

        unsigned char label[12] = "Raw "; //11 + null char
        unsigned char offset = 4;

        settings_setTimingChargeLimit(timingCharge);

        if (timingCharge >= 1000) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 1000);
            label[offset + 1] = 0x30 + (unsigned char)((timingCharge / 100) % 10);
            label[offset + 2] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[offset + 3] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 4] = '\0';
        } else if (timingCharge >= 100) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 100);
            label[offset + 1] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[offset + 2] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 3] = '\0';
        } else if (timingCharge >= 10) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 10);
            label[offset + 1] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 2] = '\0';
        } else {
            label[offset + 0] = 0x30 + (unsigned char)timingCharge;
            label[offset + 1] = '\0';
        }
        io_disk_erase(label);
        settings_setIsArmed(0);

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
    }

#if DEBUG
    {
        unsigned char label[12] = "Debug "; //11 + null char
        unsigned char offset = 6;

        if (timingCharge >= 1000) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 1000);
            label[offset + 1] = 0x30 + (unsigned char)((timingCharge / 100) % 10);
            label[offset + 2] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[offset + 3] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 4] = '\0';
        } else if (timingCharge >= 100) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 100);
            label[offset + 1] = 0x30 + (unsigned char)((timingCharge / 10) % 10);
            label[offset + 2] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 3] = '\0';
        } else if (timingCharge >= 10) {
            label[offset + 0] = 0x30 + (unsigned char)(timingCharge / 10);
            label[offset + 1] = 0x30 + (unsigned char)(timingCharge % 10);
            label[offset + 2] = '\0';
        } else {
            label[offset + 0] = 0x30 + (unsigned char)timingCharge;
            label[offset + 1] = '\0';
        }
        io_disk_erase(label);
    }
#endif


    //wait for charge
    io_led_on();
    while (timingCharge < 1000) {
        timingCharge = timing_getCharge();
    }
    io_led_off();


    isArmed = (io_disk_isLabelArmed() || settings_getIsArmed()); //just reset it from whatever previous steps did to drive

    if (!isArmed) {
        wait_10ms(); //just to blink a bit
        io_led_on();
    }


    {
        unsigned char indexer = 0;

        USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

        while(1) {
            indexer++;

            USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)
            ProcessIO();

            if ((indexer == 0) && !isArmed) {
                if (io_disk_isLabelArmed()) {
                    settings_setIsArmed(1);
                    io_led_off();
                    isArmed = 1;
                }
            }
        }
    }
}

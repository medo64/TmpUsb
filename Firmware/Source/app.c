#include <p18cxxx.h>
#include <GenericTypeDefs.h>

#include "config.h"
#include "fat12.h"
#include "io.h"
#include "settings.h"
#include "timing.h"

#include "app_usb.h"
#include "usb.h"


void main(void) {
    unsigned int timingCharge = timing_getCharge();

    settings_init();
    if (settings_getIsArmed() && (timingCharge <= settings_getTimingChargeLimit())) {
        unsigned char label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(FALSE);
        reset();
    }


    init();
    io_init();

    timing_charge();


    if (!io_disk_isValid()) {
        
        unsigned char label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(FALSE);

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (io_disk_hasLabel(IO_DISK_LABEL_RESET)) {

        unsigned char label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_reset();

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    } else if (io_disk_hasLabel(IO_DISK_LABEL_ARM)) {

        settings_setIsArmed(TRUE);

    } else if (io_disk_hasLabel(IO_DISK_LABEL_CALIBRATE)) {

        unsigned char label[12] = "Raw "; //11 + null char
        unsigned char offset = 4;

        settings_reset();
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

        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();
        io_led_on(); wait_100ms();  io_led_off(); wait_100ms();

    }


    //wait for charge
    io_led_on();
    while (timingCharge < 1000) {
        timingCharge = timing_getCharge();
    }
    io_led_off();


    if (!settings_getIsArmed()) {
        wait_10ms(); //just to blink a bit
        io_led_on();
    }


    {
        unsigned char indexer = 0;

        USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

        while(TRUE) {
            indexer++;

            USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)
            ProcessIO();

            if ((indexer == 0) && !settings_getIsArmed()) {
                if (io_disk_hasLabel(IO_DISK_LABEL_ARMED)) {
                    settings_setIsArmed(TRUE);
                    io_led_off();
                }
            }
        }
    }
}

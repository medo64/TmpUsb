#include <p18cxxx.h>
#include "config.h"
#include "io.h"
#include "timing.h"

#include "app_usb.h"
#include "usb.h"


#define MAX_CHARGE  142


void main(void) {
    unsigned int timingCharge;

    init();
    timingCharge = timing_getCharge();
    timing_charge();
    io_init();

    
    if (io_disk_isArmed() && (timingCharge < MAX_CHARGE)) { //Check if it needs to be deleted
        io_led_on();
        io_disk_erase();
        io_led_off();
    }

    USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

    while(1) {
        USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)
        ProcessIO();        
    }
}

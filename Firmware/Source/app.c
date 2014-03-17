#include <p18cxxx.h>
#include "config.h"
#include "io.h"

#include "app_usb.h"
#include "usb.h"


void main(void) {
    init();
    io_init();
    
    if (io_disk_isArmed() && io_disk_isExpired()) { //Check if it needs to be deleted
        io_led_on();
        io_disk_erase();
        io_led_off();
    }
    
    wait_1s();
    USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

    while(1) {
        USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)
        ProcessIO();        
    }
}

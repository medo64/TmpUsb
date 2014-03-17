#include <p18cxxx.h>
#include "config.h"

#include "app_usb.h"
#include "usb.h"


void main(void) {
    init();
    wait_1s();
    USBDeviceInit();	//usb_device.c.  Initializes USB module SFRs and firmware

    while(1) {
        USBDeviceTasks(); //if using polling, must call this function periodically (such as once every 1.8ms or faster)

        //TODO other stuff

        ProcessIO();        
    }
}

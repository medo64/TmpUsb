#include <xc.h>
#include <stdbool.h>

#include "usb.h"
#include "app_device_msd.h"
#include "usb_device_msd.h"

#include "config.h"
#include "fat12.h"
#include "io.h"
#include "settings.h"
#include "timing.h"

void main(void) {
    unsigned short timingCharge = timing_getCharge();

    settings_init();

    if (settings_getIsArmed() && (timingCharge <= settings_getTimingChargeLimit())) { //erase it all
        uint8_t label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(false);
        if (settings_getTimingChargeLimit() > TIMING_LIMIT) { settings_setTimingChargeLimit(TIMING_DEFAULT); } //reset timings if it was ArmMax

        init();
        for (int i = 0; i < 3; i++) {
            io_led_active();
            wait_short();
            io_led_inactive();
            wait_short();
        }
    } else {
        init();
    }

    io_init();


    timing_charge();


    if (!io_disk_isValid()) {

        uint8_t label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_setIsArmed(false);

        for (int i = 0; i < 7; i++) {
            io_led_active();
            wait_short();
            io_led_inactive();
            wait_short();
        }

    } else if (io_disk_hasLabel(IO_DISK_LABEL_RESET)) {

        uint8_t label[] = { FAT12_ROOT_DEFAULT_LABEL };
        io_disk_erase(label);
        settings_reset();

        for (int i = 0; i < 3; i++) {
            io_led_active();
            wait_short();
            io_led_inactive();
            wait_short();
        }

    } else if (io_disk_hasLabel(IO_DISK_LABEL_ARM) && !settings_getIsArmed()) {

        settings_setIsArmed(true);

    } else if (io_disk_hasLabel(IO_DISK_LABEL_READONLY) && !settings_getIsReadOnly()) {

        settings_setIsArmed(true);
        settings_setIsReadOnly(true);

    } else if (io_disk_hasLabel(IO_DISK_LABEL_ARM_MAX_1) || io_disk_hasLabel(IO_DISK_LABEL_ARM_MAX_2)) {

        settings_setIsArmed(true);
        settings_setTimingChargeLimit(TIMING_CEILING); //this will ensure it always gets erased since there is no ADC value higher than 1024

    } else if (io_disk_hasLabel(IO_DISK_LABEL_CALIBRATE)) {

        uint8_t label[12] = "Raw "; //11 + null char
        uint8_t offset = 4;

        settings_reset();

        timingCharge = (timingCharge < TIMING_LIMIT) ? timingCharge : TIMING_LIMIT;
        settings_setTimingChargeLimit(timingCharge);

        if (timingCharge >= 1000) {
            label[offset + 0] = 0x30 + (uint8_t)(timingCharge / 1000);
            label[offset + 1] = 0x30 + (uint8_t)((timingCharge / 100) % 10);
            label[offset + 2] = 0x30 + (uint8_t)((timingCharge / 10) % 10);
            label[offset + 3] = 0x30 + (uint8_t)(timingCharge % 10);
            label[offset + 4] = '\0';
        } else if (timingCharge >= 100) {
            label[offset + 0] = 0x30 + (uint8_t)(timingCharge / 100);
            label[offset + 1] = 0x30 + (uint8_t)((timingCharge / 10) % 10);
            label[offset + 2] = 0x30 + (uint8_t)(timingCharge % 10);
            label[offset + 3] = '\0';
        } else if (timingCharge >= 10) {
            label[offset + 0] = 0x30 + (uint8_t)(timingCharge / 10);
            label[offset + 1] = 0x30 + (uint8_t)(timingCharge % 10);
            label[offset + 2] = '\0';
        } else {
            label[offset + 0] = 0x30 + (uint8_t)timingCharge;
            label[offset + 1] = '\0';
        }
        io_disk_erase(label);

        for (int i = 0; i < 3; i++) {
            io_led_active();
            wait_short();
            io_led_inactive();
            wait_short();
        }

    } else if (io_disk_hasLabel(IO_DISK_LABEL_FORGETFUL)) {

        uint8_t label[12] = "Forgetful"; //11 + null char
        io_disk_erase(label);
        
    }


    //wait for charge
    io_led_active();
    while (timing_getCharge() < TIMING_STARTUP);
    io_led_inactive();


    #if defined(USB_INTERRUPT)
        INTCONbits.GIE = 1;
    #endif

    USBDeviceInit();
    USBDeviceAttach();

    uint8_t indexer = 0;
    while (true) {
        SYSTEM_Tasks();

        #if defined(USB_POLLING)
            USBDeviceTasks();
        #endif


        indexer++;
        if (indexer == 0) { //check online commands
            if (!settings_getIsArmed()) {
                if (io_disk_hasLabel(IO_DISK_LABEL_ARMED)) {
                    settings_setIsArmed(true);
                    io_led_inactive();
                }
            } else if (!settings_getIsReadOnly()) {
                if (io_disk_hasLabel(IO_DISK_LABEL_READONLY)) {
                    settings_setIsReadOnly(true);
                    if (settings_getTimingChargeLimit() <= TIMING_LIMIT) {
                        reset();
                    }
                }
            }
        }
        io_led_inactive();
        
        if (!io_5v_isOn() && settings_getIsArmed()) { //if 5V line goes off and PIC is still working
            unsigned char label[] = { FAT12_ROOT_DEFAULT_LABEL };
            unsigned int oldChargeLimit = settings_getTimingChargeLimit();
            settings_setTimingChargeLimit(TIMING_CEILING); //ensure it gets deleted on next boot in case something goes wrong here
            io_disk_erase(label);
            settings_setTimingChargeLimit(oldChargeLimit);
            settings_setIsArmed(false);
            while (true) {
                io_led_toggle();
                wait_short();
            }
        }


        if (USBGetDeviceState() < CONFIGURED_STATE) { continue; }
        if (USBIsDeviceSuspended() == true) { continue; }

        APP_DeviceMSDTasks();
    }
}


void interrupt SYS_InterruptHigh(void) {
    #if defined(USB_INTERRUPT)
        USBDeviceTasks();
    #endif
}


/*******************************************************************
 * Function:        bool USER_USB_CALLBACK_EVENT_HANDLER(
 *                        USB_EVENT event, void *pdata, uint16_t size)
 *
 * PreCondition:    None
 *
 * Input:           USB_EVENT event - the type of event
 *                  void *pdata - pointer to the event data
 *                  uint16_t size - size of the event data
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        This function is called from the USB stack to
 *                  notify a user application that a USB event
 *                  occured.  This callback is in interrupt context
 *                  when the USB_INTERRUPT option is selected.
 *
 * Note:            None
 *******************************************************************/
bool USER_USB_CALLBACK_EVENT_HANDLER(USB_EVENT event, void *pdata, uint16_t size)
{
    switch((int)event)
    {
        case EVENT_TRANSFER:
            //Add application specific callback task or callback function here if desired.
            break;

        case EVENT_SOF:
            break;

        case EVENT_SUSPEND:
            break;

        case EVENT_RESUME:
            break;

        case EVENT_CONFIGURED:
            /* When the device is configured, we can (re)initialize the demo
             * code. */
            APP_DeviceMSDInitialize();
            break;

        case EVENT_SET_DESCRIPTOR:
            break;

        case EVENT_EP0_REQUEST:
            /* We have received a non-standard USB request.  The MSD driver
             * needs to check to see if the request was for it. */
            USBCheckMSDRequest();
            break;

        case EVENT_BUS_ERROR:
            break;

        case EVENT_TRANSFER_TERMINATED:
            //Add application specific callback task or callback function here if desired.
            //The EVENT_TRANSFER_TERMINATED event occurs when the host performs a CLEAR
            //FEATURE (endpoint halt) request on an application endpoint which was
            //previously armed (UOWN was = 1).  Here would be a good place to:
            //1.  Determine which endpoint the transaction that just got terminated was
            //      on, by checking the handle value in the *pdata.
            //2.  Re-arm the endpoint if desired (typically would be the case for OUT
            //      endpoints).

            //Check if the host recently did a clear endpoint halt on the MSD OUT endpoint.
            //In this case, we want to re-arm the MSD OUT endpoint, so we are prepared
            //to receive the next CBW that the host might want to send.
            //Note: If however the STALL was due to a CBW not valid condition,
            //then we are required to have a persistent STALL, where it cannot
            //be cleared (until MSD reset recovery takes place).  See MSD BOT
            //specs v1.0, section 6.6.1.
            if(MSDWasLastCBWValid() == false)
            {
                //Need to re-stall the endpoints, for persistent STALL behavior.
                USBStallEndpoint(MSD_DATA_IN_EP, IN_TO_HOST);
                USBStallEndpoint(MSD_DATA_OUT_EP, OUT_FROM_HOST);
            }
            else
            {
                //Check if the host cleared halt on the bulk out endpoint.  In this
                //case, we should re-arm the endpoint, so we can receive the next CBW.
                if((USB_HANDLE)pdata == USBGetNextHandle(MSD_DATA_OUT_EP, OUT_FROM_HOST))
                {
                    USBMSDOutHandle = USBRxOnePacket(MSD_DATA_OUT_EP, (uint8_t*)&msd_cbw, MSD_OUT_EP_SIZE);
                }
            }
            break;

        default:
            break;
    }
    return true;
}

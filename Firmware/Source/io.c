#include <p18cxxx.h>

#include "usb.h"
#include "internal flash.h"


const BYTE DiskDefaultFat0[64] = {0xF8, 0x0F, 0x00, 0xFF, 0x0F, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const BYTE DiskDefaultRoot0[64] = {'N', 'o', 't', ' ', 'A', 'r', 'm', 'e', 'd', ' ', ' ', 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};


void io_init() {
    TRISBbits.TRISB5 = 0;
}


void io_led_on() {
    LATBbits.LATB5 = 1;
}

void io_led_off() {
    LATBbits.LATB5 = 0;
}


unsigned char io_disk_isArmed() {
    ROM BYTE* diskRootDirectory = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + 3*MEDIA_SECTOR_SIZE);
    if (
           ((diskRootDirectory[0] == 'A') || (diskRootDirectory[0] == 'a'))
        && ((diskRootDirectory[1] == 'R') || (diskRootDirectory[1] == 'r'))
        && ((diskRootDirectory[2] == 'M') || (diskRootDirectory[2] == 'm'))
        && ((diskRootDirectory[3] == 'E') || (diskRootDirectory[3] == 'e'))
        && ((diskRootDirectory[4] == 'D') || (diskRootDirectory[4] == 'd'))
    ) {
        return 1;
    } else {
        return 0;
    }
}

unsigned char io_disk_isExpired() {
    return 1; //TODO: Check whether it should be set
}
void io_disk_erase() {
    WORD blockCounter;
    unsigned short long i, j;

    //Erase all
    blockCounter = 1; //skip first two sectors (MBR+Boot)
    while (blockCounter  < ((MDD_INTERNAL_FLASH_DRIVE_CAPACITY+1) / 2)) {
        TBLPTR = (unsigned short long)(MASTER_BOOT_RECORD_ADDRESS + blockCounter * 1024);

        //Erase the current block
        EECON1 = 0x14;          //FREE + WREN
        EECON2 = 0x55;
        EECON2 = 0xAA;
        EECON1bits.WR = 1;      //CPU stalls until flash erase/write is complete

        //Write data
        for (i=0; i<16; i++) {
            for (j=0; j<64; j++) {
                if ((blockCounter == 1) && (i==0)) {
                    TABLAT = DiskDefaultFat0[j];
                } else if ((blockCounter == 1) && (i==8)) {
                    TABLAT = DiskDefaultRoot0[j];
                } else {
                    TABLAT = 0;
                }
                _asm TBLWTPOSTINC _endasm
            }
            TBLPTR = (unsigned short long)(MASTER_BOOT_RECORD_ADDRESS + blockCounter*1024 + i*64);
            EECON1 = 0x04;          //WREN
            EECON2 = 0x55;
            EECON2 = 0xAA;
            EECON1bits.WR = 1;      //CPU stalls until flash erase/write is complete
        }

        blockCounter++;
    }

    EECON1bits.WREN = 0;    //Good practice to disable any further writes now.
}



#if ((MDD_INTERNAL_FLASH_DRIVE_CAPACITY % 2) == 0)
    #error "Internal flash drive capacity must be an odd number." //to have all data aligned on 1K boundary
#endif

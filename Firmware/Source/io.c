#include <p18cxxx.h>

#include "fat12.h"
#include "usb.h"


#include "internal flash.h"


#define BLOCK_SIZE         ERASE_BLOCK_SIZE
#define TABLE_SIZE         WRITE_BLOCK_SIZE
#define SECTORS_PER_BLOCK  (BLOCK_SIZE/MEDIA_SECTOR_SIZE)


const ROM BYTE DiskDefaultMbr[MEDIA_SECTOR_SIZE]  = FAT12_MBR;
const ROM BYTE DiskDefaultBoot[MEDIA_SECTOR_SIZE] = FAT12_BOOT;
const ROM BYTE DiskDefaultFat[MEDIA_SECTOR_SIZE]  = FAT12_FAT;
const ROM BYTE DiskDefaultRoot[MEDIA_SECTOR_SIZE] = FAT12_ROOT;


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
    unsigned char i, hasLabel = 0;
    ROM BYTE* label;

    for (i = 0; i < MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT; i++) {
        label = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + 3*MEDIA_SECTOR_SIZE + i*32);
        if (label[11] == 0x08) {
            hasLabel = 1;
            if (((label[0] == 'A') || (label[0] == 'a'))
             && ((label[1] == 'R') || (label[1] == 'r'))
             && ((label[2] == 'M') || (label[2] == 'm'))
             && ((label[3] == 'E') || (label[3] == 'e'))
             && ((label[4] == 'D') || (label[4] == 'd'))
             && ((label[5] == ' ') || (label[5] == 0))
             && ((label[6] == ' ') || (label[6] == 0))
             && ((label[7] == ' ') || (label[7] == 0))
             && ((label[8] == ' ') || (label[8] == 0))
             && ((label[9] == ' ') || (label[9] == 0))
             && ((label[10] == ' ') || (label[10] == 0))) {
                return 1;
            }
        }
    }

    if (!hasLabel) {
        label = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + MEDIA_SECTOR_SIZE + 0x2B);
        if (((label[0] == 'A') || (label[0] == 'a'))
         && ((label[1] == 'R') || (label[1] == 'r'))
         && ((label[2] == 'M') || (label[2] == 'm'))
         && ((label[3] == 'E') || (label[3] == 'e'))
         && ((label[4] == 'D') || (label[4] == 'd'))
         && ((label[5] == ' ') || (label[5] == 0))
         && ((label[6] == ' ') || (label[6] == 0))
         && ((label[7] == ' ') || (label[7] == 0))
         && ((label[8] == ' ') || (label[8] == 0))
         && ((label[9] == ' ') || (label[9] == 0))
         && ((label[10] == ' ') || (label[10] == 0))) {
            return 1;
        }
    }

    return 0;
}

unsigned char io_disk_isExpired() {
    return 1;  //TODO: Check whether it should be set
}

void io_disk_erase() {
    unsigned short long iBlock, iSector;
    unsigned char i, j;
    BYTE buffer[TABLE_SIZE] = {0};

    //Erase all
    for (iBlock = 0; iBlock  < (MDD_INTERNAL_FLASH_DRIVE_CAPACITY + 1) / SECTORS_PER_BLOCK; iBlock++) {
        TBLPTR = (unsigned short long)(MASTER_BOOT_RECORD_ADDRESS + iBlock * BLOCK_SIZE);

        //Erase the current block
        EECON1 = 0x14;      //FREE + WREN
        EECON2 = 0x55;
        EECON2 = 0xAA;
        EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete
    }

    for (iSector = 0; iSector  < (MDD_INTERNAL_FLASH_DRIVE_CAPACITY + 1); iSector++) {
        for (i=0; i<8; i++) {
            if (iSector == 0) {        memcpypgm2ram((void *)&buffer[0], (ROM void*)(&DiskDefaultMbr[0]  + ((int)i * TABLE_SIZE)), TABLE_SIZE);
            } else if (iSector == 1) { memcpypgm2ram((void *)&buffer[0], (ROM void*)(&DiskDefaultBoot[0] + ((int)i * TABLE_SIZE)), TABLE_SIZE);
            } else if (iSector == 2) { memcpypgm2ram((void *)&buffer[0], (ROM void*)(&DiskDefaultFat[0]  + ((int)i * TABLE_SIZE)), TABLE_SIZE);
            } else if (iSector == 3) { memcpypgm2ram((void *)&buffer[0], (ROM void*)(&DiskDefaultRoot[0] + ((int)i * TABLE_SIZE)), TABLE_SIZE);
            } else {
                memset((void *)&buffer[0], '\0', TABLE_SIZE);
            }

            TBLPTR = (unsigned short long)(MASTER_BOOT_RECORD_ADDRESS + iSector * MEDIA_SECTOR_SIZE + (int)i * TABLE_SIZE - TABLE_SIZE);
            for (j=0; j<TABLE_SIZE; j++) {
                TABLAT = buffer[j];
                _asm TBLWTPOSTINC _endasm
            }

            EECON1 = 0x04;      //WREN
            EECON2 = 0x55;
            EECON2 = 0xAA;
            EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete
        }
    }

    EECON1bits.WREN = 0;    //Good practice to disable any further writes now.
}



#if ((MDD_INTERNAL_FLASH_DRIVE_CAPACITY % 2) == 0)
    #error "Internal flash drive capacity must be an odd number." //to have all data aligned on 1K boundary
#endif

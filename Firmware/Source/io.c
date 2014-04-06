#include <p18cxxx.h>
#include <GenericTypeDefs.h>

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
    TRISAbits.TRISA0 = 0;
}


void io_led_on() {
    LATAbits.LATA0 = 1;
}

void io_led_off() {
    LATAbits.LATA0 = 0;
}

void io_led_toggle() {
    LATAbits.LATA0 = !LATAbits.LATA0;
}


BOOL io_disk_hasLabel(const rom char* label) {
    unsigned char i, hasDriveLabel = 0;
    ROM BYTE* driveLabel;

    for (i = 0; i < MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT; i++) {
        driveLabel = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + 3*MEDIA_SECTOR_SIZE + i*32);
        if (driveLabel[11] == 0x08) {
            hasDriveLabel = 1;
            break;
        }
    }

    if (!hasDriveLabel) {
        driveLabel = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + MEDIA_SECTOR_SIZE + 0x2B);
    }

    for (i = 0; i < 11; i++) {
        if (label[i] == '\0') {
            break;
        } else {
            if (!( (label[i] == driveLabel[i])
                || (((label[i] >= 0x41) && (label[i] <= 0x5A)) && ((label[i] + 0x20) == driveLabel[i]))
                || (((label[i] >= 0x61) && (label[i] <= 0x7A)) && ((label[i] - 0x20) == driveLabel[i]))
                )) {
                return FALSE; //if one letter doesn't match, abort early
            }
        }
    }

    for (; i < 11; i++) { //check rest of label to be empty
         if (!(driveLabel[i] == ' ') && !(driveLabel[i] == 0)) {
             return FALSE;
         }
    }

    return TRUE;
}


BOOL io_disk_isValid() {
    unsigned int i;
    ROM BYTE* mbr;
    ROM BYTE* boot;

    mbr = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS);
    for (i = 0; i < MEDIA_SECTOR_SIZE; i++) {
        if (mbr[i] != DiskDefaultMbr[i]) { return FALSE; }
    }

    boot = (ROM BYTE*)(MASTER_BOOT_RECORD_ADDRESS + MEDIA_SECTOR_SIZE);
    for (i = 0; i < MEDIA_SECTOR_SIZE; i++) {
        if (i == 0x25) { continue; } //dirty flag
        if ((i >= 0x2B) && (i <= 0x35)) { continue; } //label
        if (boot[i] != DiskDefaultBoot[i]) { return FALSE; }
    }

    return TRUE;
}


void io_disk_erase(unsigned char* label) {
    unsigned short long iBlock, iSector;
    unsigned char i, j, k;
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
            } else if (iSector == 3) {
                memcpypgm2ram((void *)&buffer[0], (ROM void*)(&DiskDefaultRoot[0] + ((int)i * TABLE_SIZE)), TABLE_SIZE);
                if (i == 0) { //overwrite label
                    memset((void *)&buffer[0], ' ', 11);
                    for (k=0; k<11; k++) {
                        if (label[k]=='\0') { break; }
                        buffer[k] = label[k];
                    }
                }
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

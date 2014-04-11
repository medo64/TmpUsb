#include <p18cxxx.h>
#include <stdbool.h>
#include <string.h>

#include "fileio_config.h"

#include "fat12.h"


#define MEDIA_SECTOR_SIZE   FILEIO_CONFIG_MEDIA_SECTOR_SIZE
#define MEDIA_ROOT_ENTRIES  DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT
#define MEDIA_CAPACITY      DRV_FILEIO_INTERNAL_FLASH_TOTAL_DISK_SIZE

#define BLOCK_ERASE_SIZE    DRV_FILEIO_INTERNAL_FLASH_CONFIG_ERASE_BLOCK_SIZE
#define BLOCK_WRITE_SIZE    DRV_FILEIO_INTERNAL_FLASH_CONFIG_WRITE_BLOCK_SIZE
#define SECTORS_PER_BLOCK   (BLOCK_ERASE_SIZE/MEDIA_SECTOR_SIZE)


const uint8_t DiskDefaultMbr[MEDIA_SECTOR_SIZE]  = FAT12_MBR;
const uint8_t DiskDefaultBoot[MEDIA_SECTOR_SIZE] = FAT12_BOOT;
const uint8_t DiskDefaultFat[MEDIA_SECTOR_SIZE]  = FAT12_FAT;
const uint8_t DiskDefaultRoot[MEDIA_SECTOR_SIZE] = FAT12_ROOT;


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


bool io_5v_isOn(void) {
    return PORTCbits.RC6 ? TRUE : FALSE;
}


bool io_disk_hasLabel(const uint8_t* label) {
    bool hasDriveLabel = false;
    const uint8_t* driveLabel;

    for (uint8_t i = 0; i < MEDIA_ROOT_ENTRIES; i++) {
        driveLabel = (const uint8_t*)(MASTER_BOOT_RECORD_ADDRESS + 3 * MEDIA_SECTOR_SIZE + i * 32);
        if (driveLabel[11] == 0x08) {
            hasDriveLabel = true;
            break;
        }
    }

    if (!hasDriveLabel) {
        driveLabel = (const uint8_t*)(MASTER_BOOT_RECORD_ADDRESS + MEDIA_SECTOR_SIZE + 0x2B);
    }

    uint8_t i;
    for (i = 0; i < 11; i++) {
        if (label[i] == '\0') {
            break;
        } else {
            if (!( (label[i] == driveLabel[i])
                || (((label[i] >= 0x41) && (label[i] <= 0x5A)) && ((label[i] + 0x20) == driveLabel[i]))
                || (((label[i] >= 0x61) && (label[i] <= 0x7A)) && ((label[i] - 0x20) == driveLabel[i]))
                )) {
                return false; //if one letter doesn't match, abort early
            }
        }
    }
    for (; i < 11; i++) { //check rest of label to be empty
         if ((driveLabel[i] != ' ') && (driveLabel[i] != 0)) {
             return false;
         }
    }

    return true;
}


bool io_disk_isValid() {
    const uint8_t* mbr = (const uint8_t*)(MASTER_BOOT_RECORD_ADDRESS);
    for (uint16_t i = 0; i < MEDIA_SECTOR_SIZE; i++) {
        if (mbr[i] != DiskDefaultMbr[i]) { return false; }
    }

    const uint8_t* boot = (const uint8_t*)(MASTER_BOOT_RECORD_ADDRESS + MEDIA_SECTOR_SIZE);
    for (uint16_t i = 0; i < MEDIA_SECTOR_SIZE; i++) {
        if (i == 0x25) { continue; } //dirty flag
        if ((i >= 0x2B) && (i <= 0x35)) { continue; } //label
        if (boot[i] != DiskDefaultBoot[i]) { return false; }
    }

    return true;
}


void io_disk_erase(uint8_t* label) {
    uint8_t buffer[BLOCK_WRITE_SIZE] = {0};

    
    //Erase all
    for (uint8_t iBlock = 0; iBlock  < MEDIA_CAPACITY / SECTORS_PER_BLOCK; iBlock++) {
        TBLPTR = (uint32_t)(MASTER_BOOT_RECORD_ADDRESS + iBlock * BLOCK_ERASE_SIZE);

        //Erase the current block
        EECON1 = 0x14;      //FREE + WREN
        EECON2 = 0x55;
        EECON2 = 0xAA;
        EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete
    }

    for (uint8_t iSector = 0; iSector  < MEDIA_CAPACITY; iSector++) {
        for (uint8_t i = 0; i < 8; i++) {
            if (iSector == 0) {        memcpy((void*)buffer, (const void*)(DiskDefaultMbr  + (uint32_t)i * BLOCK_WRITE_SIZE), sizeof(buffer));
            } else if (iSector == 1) { memcpy((void*)buffer, (const void*)(DiskDefaultBoot + (uint32_t)i * BLOCK_WRITE_SIZE), sizeof(buffer));
            } else if (iSector == 2) { memcpy((void*)buffer, (const void*)(DiskDefaultFat  + (uint32_t)i * BLOCK_WRITE_SIZE), sizeof(buffer));
            } else if (iSector == 3) {
                memcpy((void*)buffer, (const void*)(DiskDefaultRoot + i * BLOCK_WRITE_SIZE), sizeof(buffer));
                if (i == 0) { //overwrite label
                    memset((void *)&buffer[0], ' ', 11);
                    for (uint8_t k = 0; k < 11; k++) {
                        if (label[k]=='\0') { break; }
                        buffer[k] = label[k];
                    }
                }
            } else {
                memset((void*)buffer, '\0', sizeof(buffer));
            }

            TBLPTR = (uint32_t)(MASTER_BOOT_RECORD_ADDRESS + iSector * MEDIA_SECTOR_SIZE + i * BLOCK_WRITE_SIZE - BLOCK_WRITE_SIZE);
            for (uint8_t j = 0; j < BLOCK_WRITE_SIZE; j++) {
                TABLAT = buffer[j];
                asm("TBLWTPOSTINC");
            }

            EECON1 = 0x04;      //WREN
            EECON2 = 0x55;
            EECON2 = 0xAA;
            EECON1bits.WR = 1;  //CPU stalls until flash erase/write is complete
        }
    }

    EECON1bits.WREN = 0;    //Good practice to disable any further writes now.*/
}

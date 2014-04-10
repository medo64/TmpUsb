/******************************************************************************
 *
 *                Microchip Memory Disk Drive File System
 *
 ******************************************************************************
 * FileName:        Files.c
 * Dependencies:    None
 * Processor:       PIC18/PIC24/dsPIC30/dsPIC33
 * Compiler:        XC8/C18/XC16
 *
 * Software License Agreement
 *
 * The software supplied herewith by Microchip Technology Incorporated
 * (the "Company") for its PICmicro(R) Microcontroller is intended and
 * supplied to you, the Company�s customer, for use solely and
 * exclusively on Microchip PICmicro Microcontroller products. The
 * software is owned by the Company and/or its supplier, and is
 * protected under applicable copyright laws. All rights are reserved.
 * Any use in violation of the foregoing restrictions may subject the
 * user to criminal sanctions under applicable laws, as well as to
 * civil liability for the breach of the terms and conditions of this
 * license.
 *
 * THIS SOFTWARE IS PROVIDED IN AN "AS IS" CONDITION. NO WARRANTIES,
 * WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED
 * TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. THE COMPANY SHALL NOT,
 * IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL OR
 * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 *
*****************************************************************************/

#include "fileio_config.h"
#include <fileio/fileio.h>
#include <driver/fileio/internal_flash.h>

#include "../../fat12.h"


#if defined(__PIC32MX__)
    #define MBR_ATTRIBUTES                      __attribute__((aligned (ERASE_BLOCK_SIZE),section(".MDD_FILES")))
    #define PARTITION_ATTRIBUTES(sector_num)    __attribute__ ((section(".MDD_FILES")))
#elif defined(__C30__) || defined __XC16__
    #define MBR_ATTRIBUTES                      __attribute__((space(psv), address(DRV_FILEIO_INTERNAL_FLASH_CONFIG_FILES_ADDRESS)))
    #define PARTITION_ATTRIBUTES(sector_num)    __attribute__((space(psv), address(DRV_FILEIO_INTERNAL_FLASH_CONFIG_FILES_ADDRESS + (sector_num * FILEIO_CONFIG_MEDIA_SECTOR_SIZE))))
#elif defined(__XC8)
    #define MBR_ATTRIBUTES
    #define PARTITION_ATTRIBUTES(sector_num)
#elif defined(__18CXX)
    #define MBR_ATTRIBUTES
    #define PARTITION_ATTRIBUTES(sector_num)
    #pragma romdata Files = DRV_FILEIO_INTERNAL_FLASH_CONFIG_FILES_ADDRESS
#else
    #error "Compiler not supported."
#endif


//Flash memory address placement/computation macros.  To move the location in
//flash memory where the MSD drive volume begins, edit the DRV_FILEIO_INTERNAL_FLASH_CONFIG_FILES_ADDRESS
//definition in fileio_config.h.
#if defined(__XC8)
    #define MBR_ADDR_TAG    @DRV_FILEIO_INTERNAL_FLASH_CONFIG_FILES_ADDRESS
    #define BOOT_SEC_ADDR_TAG   MBR_ADDR_TAG + FILEIO_CONFIG_MEDIA_SECTOR_SIZE
    #define FAT_TBL_ADDR_TAG    BOOT_SEC_ADDR_TAG + FILEIO_CONFIG_MEDIA_SECTOR_SIZE
    #define ROOT_DIR_ADDR_TAG   FAT_TBL_ADDR_TAG + FILEIO_CONFIG_MEDIA_SECTOR_SIZE
    #define FILE_DATA_ADDR_TAG  ROOT_DIR_ADDR_TAG + (FILEIO_CONFIG_MEDIA_SECTOR_SIZE * (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT / 16))
    #define OTHER_FILE_PLACEHOLDER_ADDR_TAG     FILE_DATA_ADDR_TAG + FILEIO_CONFIG_MEDIA_SECTOR_SIZE
#else
    #define MBR_ADDR_TAG
    #define BOOT_SEC_ADDR_TAG
    #define FAT_TBL_ADDR_TAG
    #define ROOT_DIR_ADDR_TAG
    #define FILE_DATA_ADDR_TAG
    #define OTHER_FILE_PLACEHOLDER_ADDR_TAG
#endif


/*********** Sector Address Calculation macros ********************
    These macros are used to calculate the sector address of each
    of the blocks.  These are then used to locate where the blocks
    go in program memory on certain processors using processor specific
    attribute() commands
*******************************************************************/
#define BOOT_SECTOR_ADDRESS         1
#define FAT0_ADDRESS                (BOOT_SECTOR_ADDRESS + 1)
#define FATx_ADDRESS                (FAT0_ADDRESS + 1)
#define ROOTDIRECTORY0_ADDRESS      (FAT0_ADDRESS + DRV_FILEIO_INTERNAL_FLASH_NUM_FAT_SECTORS)

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>16)
    #define ROOTDIRECTORY1_ADDRESS  (ROOTDIRECTORY0_ADDRESS + 1)
#else
    #define ROOTDIRECTORY1_ADDRESS  (ROOTDIRECTORY0_ADDRESS)
#endif

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>32)
    #define ROOTDIRECTORY2_ADDRESS  (ROOTDIRECTORY1_ADDRESS + 1)
#else
    #define ROOTDIRECTORY2_ADDRESS  (ROOTDIRECTORY1_ADDRESS)
#endif

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>48)
    #define ROOTDIRECTORY3_ADDRESS  (ROOTDIRECTORY2_ADDRESS + 1)
#else
    #define ROOTDIRECTORY3_ADDRESS  (ROOTDIRECTORY2_ADDRESS)
#endif

#define SLACK0_ADDRESS              (ROOTDIRECTORY3_ADDRESS + 1)
#define SLACK1_ADDRESS              (SLACK0_ADDRESS + 1)
#define SLACK2_ADDRESS              (SLACK1_ADDRESS + 1)
#define SLACK3_ADDRESS              (SLACK2_ADDRESS + 1)
#define SLACK4_ADDRESS              (SLACK3_ADDRESS + 1)
#define SLACK5_ADDRESS              (SLACK4_ADDRESS + 1)
#define SLACK6_ADDRESS              (SLACK5_ADDRESS + 1)
#define SLACK7_ADDRESS              (SLACK6_ADDRESS + 1)
/******************************************************************/


//------------------------------------------------------------------------------
//Master boot record at LBA = 0
//------------------------------------------------------------------------------
const uint8_t MBR_ATTRIBUTES MasterBootRecord[FILEIO_CONFIG_MEDIA_SECTOR_SIZE] MBR_ADDR_TAG = FAT12_MBR;


//------------------------------------------------------------------------------
//Partition boot sector at LBA = 1
//------------------------------------------------------------------------------
//Physical Sector - 1, Logical Sector - 0.  
//This is the first sector in the partition, and is known as the "volume boot record" or "partition boot sector"
//Note: This table is filesystem specific.  Re-formatting the drive will overwrite this table.  
const uint8_t PARTITION_ATTRIBUTES(BOOT_SECTOR_ADDRESS) BootSector[FILEIO_CONFIG_MEDIA_SECTOR_SIZE]  BOOT_SEC_ADDR_TAG = FAT12_BOOT;


//------------------------------------------------------------------------------
//First FAT sector at LBA = 2
//------------------------------------------------------------------------------
//Please see:  http://technet.microsoft.com/en-us/library/cc938438.aspx
//For short summary on how this table works.
//Note: This table consists of a series of 12-bit entries, and are fully packed 
//(no pad bits).  This means every other byte is a "shared" byte, that is split
//down the middle and is part of two adjacent 12-bit entries.  
//The entries are in little endian format.
const uint8_t PARTITION_ATTRIBUTES(FAT0_ADDRESS) FAT0[FILEIO_CONFIG_MEDIA_SECTOR_SIZE]  FAT_TBL_ADDR_TAG = FAT12_FAT;

//Optional additional FAT space here, only needed for drives > ~174kB.
#if(DRV_FILEIO_INTERNAL_FLASH_NUM_FAT_SECTORS > 1)
const uint8_t PARTITION_ATTRIBUTES(FATx_ADDRESS) FATx[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_NUM_FAT_SECTORS - 1)];
#endif


const uint8_t PARTITION_ATTRIBUTES(ROOTDIRECTORY0_ADDRESS) RootDirectory0[FILEIO_CONFIG_MEDIA_SECTOR_SIZE]  ROOT_DIR_ADDR_TAG = FAT12_ROOT;

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>16)
        const uint8_t PARTITION_ATTRIBUTES(ROOTDIRECTORY1_ADDRESS) RootDirectory1[FILEIO_CONFIG_MEDIA_SECTOR_SIZE] =
        {0};
#endif

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>32)
    const uint8_t PARTITION_ATTRIBUTES(ROOTDIRECTORY2_ADDRESS) RootDirectory2[FILEIO_CONFIG_MEDIA_SECTOR_SIZE] =
    {0};
#endif

#if (DRV_FILEIO_CONFIG_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>48)
    const uint8_t PARTITION_ATTRIBUTES(ROOTDIRECTORY3_ADDRESS) RootDirectory3[FILEIO_CONFIG_MEDIA_SECTOR_SIZE] =
    {0};
#endif

//********************* Data Sectors ************************

//Create a place holder in flash for each of sector of data defined by 
//  the DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY definition.
//
//We will initialize the the first sector worth placeholder with the ASCII
//contents "Data".  This is the contents of the FILE.TXT, based on our
//RootDirectory0[] and FAT0[] settings above.
#if (DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY>0)
const uint8_t PARTITION_ATTRIBUTES(SLACK0_ADDRESS) slack0[FILEIO_CONFIG_MEDIA_SECTOR_SIZE]  FILE_DATA_ADDR_TAG = {0};
#endif

//The rest of the MSD volume is unused/blank/not currently filled with any file(s).
//However, we still need to declare a uint8_t array to fill the space, so the linker
//knows not to allocate anything else into this region of flash memory.
#if defined(__XC8)
    const uint8_t PARTITION_ATTRIBUTES(SLACK1_ADDRESS) slack1[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 1u)] OTHER_FILE_PLACEHOLDER_ADDR_TAG = {0};
#else
    //Technically, this array declaration could be:
    //const uint8_t PARTITION_ATTRIBUTES slack1[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 1u)] = {0};
    //In practice, the XC16 compiler requires you to use the "-mlarge-arrays" custom
    //build option if you create an array with more than 32767 elements.  This option
    //has some size/speed penalty associated with it.  Therefore, we instead just
    //use the normal build settings and declare the MSD volume placeholder as a
    //series of arrays (each 32767 bytes or less), so as to support large MSD
    //volume sizes.

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY>1)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 64)
            const uint8_t PARTITION_ATTRIBUTES(SLACK1_ADDRESS) slack1[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK1_ADDRESS) slack1[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 1u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 64)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 127)
            const uint8_t PARTITION_ATTRIBUTES(SLACK2_ADDRESS) slack2[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK2_ADDRESS) slack2[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 64u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 127)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 190)
            const uint8_t PARTITION_ATTRIBUTES(SLACK3_ADDRESS) slack3[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK3_ADDRESS) slack3[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 127u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 190)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 253)
            const uint8_t PARTITION_ATTRIBUTES(SLACK4_ADDRESS) slack4[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK4_ADDRESS) slack4[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 190u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 253)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 316)
            const uint8_t PARTITION_ATTRIBUTES(SLACK5_ADDRESS) slack5[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK5_ADDRESS) slack5[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 253u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 316)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 379)
            const uint8_t PARTITION_ATTRIBUTES(SLACK6_ADDRESS) slack6[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*63] = {0};
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK6_ADDRESS) slack6[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 316u)] = {0};
        #endif
    #endif

    #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 379)
        #if(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY >= 442)
            #error "Your MSD Volume is larger than this example has provisions for.  Double click this message and add more flash memory placeholder bytes."
            //If your DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY is > 442 sectors, then you need to declare more place holder
            //uint8_t arrays to allocate to the MSD volume.  If you don't do this, the linker might try to "re-use" the
            //flash memory by placing program code inside the MSD volume, which would cause unanticipated behavior.
            //Please use the existing slack1[] to slack6[] placeholder array declarations as an example/template
            //to follow, and keep adding as many more slackx[] arrays as needed to meet your
            //DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY size requirements.
        #else
            const uint8_t PARTITION_ATTRIBUTES(SLACK7_ADDRESS) slack7[FILEIO_CONFIG_MEDIA_SECTOR_SIZE*(DRV_FILEIO_INTERNAL_FLASH_CONFIG_DRIVE_CAPACITY - 379u)] = {0};
        #endif
    #endif

#endif //end of #if defined(__XC8)


//------------------------------------------------------------------------------
//End of File Files.c

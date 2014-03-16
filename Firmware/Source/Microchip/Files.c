/******************************************************************************
 *
 *                Microchip Memory Disk Drive File System
 *
 ******************************************************************************
 * FileName:        Files.c
 * Dependencies:    None
 * Processor:       PIC18/PIC24/dsPIC30/dsPIC33
 * Compiler:        C18/C30
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

#include "Compiler.h"
#include "GenericTypeDefs.h"
#include "FSconfig.h"
#include "Internal Flash.h"

#if defined(__18CXX)
    #pragma romdata Files=FILES_ADDRESS
#endif

#if (ERASE_BLOCK_SIZE > WRITE_BLOCK_SIZE)
    #define BLOCK_ALIGNMENT ERASE_BLOCK_SIZE
#else
    #define BLOCK_ALIGNMENT WRITE_BLOCK_SIZE
#endif


#if defined(__PIC32MX__)
    #define MBR_ATTRIBUTES                      __attribute__((aligned (ERASE_BLOCK_SIZE),section(".MDD_FILES")))
    #define PARTITION_ATTRIBUTES(sector_num)    __attribute__ ((section(".MDD_FILES")))
#elif defined(__C30__) || defined __XC16__
    #define MBR_ATTRIBUTES                      __attribute__((space(psv), address(FILES_ADDRESS)))
    #define PARTITION_ATTRIBUTES(sector_num)    __attribute__((space(psv), address(FILES_ADDRESS + (sector_num * MEDIA_SECTOR_SIZE))))
#elif defined(__18CXX)
    #define MBR_ATTRIBUTES
    #define PARTITION_ATTRIBUTES(sector_num)
#else
    #error "Compiler not supported."
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
#define ROOTDIRECTORY0_ADDRESS      (FAT0_ADDRESS + MDD_INTERNAL_FLASH_NUM_FAT_SECTORS)

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>16)
    #define ROOTDIRECTORY1_ADDRESS  (ROOTDIRECTORY0_ADDRESS + 1)
#else
    #define ROOTDIRECTORY1_ADDRESS  (ROOTDIRECTORY0_ADDRESS)
#endif

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>32)
    #define ROOTDIRECTORY2_ADDRESS  (ROOTDIRECTORY1_ADDRESS + 1)
#else
    #define ROOTDIRECTORY2_ADDRESS  (ROOTDIRECTORY1_ADDRESS)
#endif

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>48)
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
ROM BYTE MBR_ATTRIBUTES MasterBootRecord[MEDIA_SECTOR_SIZE] =
{
//Code Area
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	//0x0000
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0010
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0020
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0030
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0040
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0050
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0060
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0070
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0080
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0090
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00A0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00B0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00C0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00D0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00E0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x00F0
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0100
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0110
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0120
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0130
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0140
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0150
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0160
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0170
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,                                     //0x0180

//IBM 9 byte/entry x 4 entries primary partition table
0x00, 0x00, 0x00, 0x00, 0x00, 0x00,                                                             //0x018A
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x0190
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,             //0x01A0

//???
0x00, 0x00,                                                                                     //0x01AE
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,                                                 //0x01B0

//Disk signature
0xF5, 0x8B, 0x16, 0xEA,                                                                         //0x01B8

//??? - usually 0x0000
0x00, 0x00,                                                                                     //0x01BC

//Table of Primary Partitions (16 bytes/entry x 4 entries)
//Note: Multi-byte fields are in little endian format.
//Partition Entry 1                                                                             //0x01BE
0x80,                   //Status - 0x80 (bootable), 0x00 (not bootable), other (error)
0x01, 0x01, 0x00,       //Cylinder-head-sector address of first sector in partition
0x01,                   //Partition type - 0x01 = FAT12 up to 2MB
0x07, 0xFF, 0xE6,       //Cylinder-head-sector address of last sector in partition
0x01, 0x00, 0x00, 0x00, //Logical Block Address (LBA) of first sector in partition
(BYTE)MDD_INTERNAL_FLASH_PARTITION_SIZE, (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 8), (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 16), (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 24), //Length of partition in sectors (MBR sits at LBA = 0, and is not in the partition.)

//Partition Entry 2
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x01CE
//Partition Entry 3
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x01DE
//Partition Entry 4
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0x01EE

//MBR signature
0x55, 0xAA                                                                                      //0x01FE
};


//------------------------------------------------------------------------------
//Partition boot sector at LBA = 1
//------------------------------------------------------------------------------
//Physical Sector - 1, Logical Sector - 0.  
//This is the first sector in the partition, and is known as the "volume boot record" or "partition boot sector"
//Note: This table is filesystem specific.  Re-formatting the drive will overwrite this table.  
ROM BYTE PARTITION_ATTRIBUTES(BOOT_SECTOR_ADDRESS) BootSector[MEDIA_SECTOR_SIZE]  =
{
0xEB, 0x3C, 0x90,			//Jump instruction
'M', 'S', 'D', 'O', 'S', '5', '.', '0',	//OEM Name "MSDOS5.0"
(MEDIA_SECTOR_SIZE&0xFF), (MEDIA_SECTOR_SIZE>>8),	    //Bytes per sector (MEDIA_SECTOR_SIZE)
0x01,			    //Sectors per cluster
MDD_INTERNAL_FLASH_NUM_RESERVED_SECTORS, 0x00,			//Reserved sector count (usually 1 for FAT12 or FAT16)
0x01,			    //number of FATs 
MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT, 0x00,			//Max number of root directory entries - 16 files allowed
0x00, 0x00,			//total sectors (0x0000 means: use the 4 byte field at offset 0x20 instead)
0xF8,			    //Media Descriptor
MDD_INTERNAL_FLASH_NUM_FAT_SECTORS, 0x00,         //Sectors per FAT
0x3F, 0x00,	                //Sectors per track
0xFF, 0x00,                 //Number of heads
0x01, 0x00, 0x00, 0x00,		//Hidden sectors
(BYTE)MDD_INTERNAL_FLASH_PARTITION_SIZE, (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 8), (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 16), (BYTE)(MDD_INTERNAL_FLASH_PARTITION_SIZE >> 24),	//Total sectors (when WORD value at offset 20 is 0x0000)

0x00,			//Physical drive number
0x00,			//Reserved("current head")
0x29,			//Signature
0x32, 0x67, 0x94, 0xC4,		//ID(serial number)
'N', 'O', ' ', 'N', 'A', 'M', 'E', ' ', ' ', ' ', ' ',	//Volume Label (11 bytes) - "NO NAME    "
'F', 'A', 'T', '1', '2', ' ', ' ', ' ',	//FAT system "FAT12   "
//Operating system boot code
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x55, 0xAA			//End of sector (0x55AA)
};


//------------------------------------------------------------------------------
//First FAT sector at LBA = 2
//------------------------------------------------------------------------------
//Please see:  http://technet.microsoft.com/en-us/library/cc938438.aspx
//For short summary on how this table works.
//Note: This table consists of a series of 12-bit entries, and are fully packed 
//(no pad bits).  This means every other byte is a "shared" byte, that is split
//down the middle and is part of two adjacent 12-bit entries.  
//The entries are in little endian format.
ROM BYTE PARTITION_ATTRIBUTES(FAT0_ADDRESS) FAT0[MEDIA_SECTOR_SIZE] =
{
    0xF8,0x0F,   //Copy of the media descriptor 0xFF8
    0x00,
    0xFF,0x0F    
};

//Optional additional FAT space here, only needed for drives > ~174kB.
#if(MDD_INTERNAL_FLASH_NUM_FAT_SECTORS > 1)
ROM BYTE PARTITION_ATTRIBUTES(FATx_ADDRESS) FATx[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_NUM_FAT_SECTORS - 1)];
#endif


ROM BYTE PARTITION_ATTRIBUTES(ROOTDIRECTORY0_ADDRESS) RootDirectory0[MEDIA_SECTOR_SIZE] =
{
    //Root
    'D','r','i','v','e',' ','N','a','m','e',' ',   //Drive Name (11 characters, padded with spaces)
    0x08, //specify this entry as a volume label
    0x00, //Reserved
    0x00, 0x00, 0x00, 0x00, 0x11, //Create time
    0x00, 0x11,             //Last Access
    0x00, 0x00,             //EA-index
    0x00, 0x00, 0x00, 0x11, //Last modified time
    0x00, 0x00,             //First FAT cluster
    0x00, 0x00, 0x00, 0x00, //File Size (number of bytes)

    'F','I','L','E',' ',' ',' ',' ',    //File name (exactly 8 characters)
    'T','X','T',                        //File extension (exactly 3 characters)
    0x20, //specify this entry as a volume label
    0x00, //Reserved
    0x06, 0x28, 0x78, 0xDE, 0x38, //Create time
    0xDE, 0x38,             //Last Access
    0x00, 0x00,             //EA-index
    0x04, 0x77, 0xDE, 0x38, //Last modified
    0x02, 0x00,             //First FAT cluster
    0x04, 0x00, 0x00, 0x00, //File Size (number of bytes)
};

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>16)
        ROM BYTE PARTITION_ATTRIBUTES(ROOTDIRECTORY1_ADDRESS) RootDirectory1[MEDIA_SECTOR_SIZE] = 
        {0};
#endif

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>32)
    ROM BYTE PARTITION_ATTRIBUTES(ROOTDIRECTORY2_ADDRESS) RootDirectory2[MEDIA_SECTOR_SIZE] = 
    {0};
#endif

#if (MDD_INTERNAL_FLASH_MAX_NUM_FILES_IN_ROOT>48)
    ROM BYTE PARTITION_ATTRIBUTES(ROOTDIRECTORY3_ADDRESS) RootDirectory3[MEDIA_SECTOR_SIZE] = 
    {0};
#endif

//********************* Data Sectors ************************

//Create a place holder in flash for each of sector of data defined by 
//  the MDD_INTERNAL_FLASH_DRIVE_CAPACITY definition.
//
//We will initialize the the first sector worth placeholder with the ASCII
//contents "Data".  This is the contents of the FILE.TXT, based on our
//RootDirectory0[] and FAT0[] settings above.
#if (MDD_INTERNAL_FLASH_DRIVE_CAPACITY>0)
ROM BYTE PARTITION_ATTRIBUTES(SLACK0_ADDRESS) slack0[MEDIA_SECTOR_SIZE] =
{
    'D','a','t','a'
};
#endif

//The rest of the MSD volume is unused/blank/not currently filled with any file(s).
//However, we still need to declare a BYTE array to fill the space, so the linker
//knows not to allocate anything else into this region of flash memory.
//Technically, this array declaration could be:
//ROM BYTE PARTITION_ATTRIBUTES slack1[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 1u)] = {0};
//In practice, some compilers will run into limitations when trying to declare arrays
//with more than 32767 elements.  Therefore, we declare the MSD volume placeholder as a 
//series of arrays instead (each 32767 bytes or less), so as to support large MSD
//volume sizes.

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY>1)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 64)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK1_ADDRESS) slack1[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK1_ADDRESS) slack1[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 1u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 64)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 127)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK2_ADDRESS) slack2[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK2_ADDRESS) slack2[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 64u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 127)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 190)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK3_ADDRESS) slack3[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK3_ADDRESS) slack3[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 127u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 190)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 253)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK4_ADDRESS) slack4[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK4_ADDRESS) slack4[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 190u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 253)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 316)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK5_ADDRESS) slack5[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK5_ADDRESS) slack5[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 253u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 316)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 379)
        ROM BYTE PARTITION_ATTRIBUTES(SLACK6_ADDRESS) slack6[MEDIA_SECTOR_SIZE*63] = {0};
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK6_ADDRESS) slack6[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 316u)] = {0};
    #endif
#endif

#if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 379)
    #if(MDD_INTERNAL_FLASH_DRIVE_CAPACITY >= 442)
        #error "Your MSD Volume is larger than this example has provisions for.  Double click this message and add more flash memory placeholder bytes."
        //If your MDD_INTERNAL_FLASH_DRIVE_CAPACITY is > 442 sectors, then you need to declare more place holder
        //BYTE arrays to allocate to the MSD volume.  If you don't do this, the linker might try to "re-use" the
        //flash memory by placing program code inside the MSD volume, which would cause unanticipated behavior.
        //Please use the existing slack1[] to slack6[] placeholder array declarations as an example/template
        //to follow, and keep adding as many more slackx[] arrays as needed to meet your 
        //MDD_INTERNAL_FLASH_DRIVE_CAPACITY size requirements.
    #else
        ROM BYTE PARTITION_ATTRIBUTES(SLACK7_ADDRESS) slack7[MEDIA_SECTOR_SIZE*(MDD_INTERNAL_FLASH_DRIVE_CAPACITY - 379u)] = {0};
    #endif
#endif



//------------------------------------------------------------------------------
//End of File Files.c

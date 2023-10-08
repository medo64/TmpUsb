/*******************************************************************************
Copyright 2016 Microchip Technology Inc. (www.microchip.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

To request to license the code under the MLA license (www.microchip.com/mla_license), 
please contact mla_licensing@microchip.com
*******************************************************************************/

#include <xc.h>
#include <stdbool.h>
#include <stdint.h>

#include "io_mapping.h"


//Microcontroller flash memory erase/write page sizes.
#define DRV_FILEIO_INTERNAL_FLASH_CONFIG_ERASE_BLOCK_SIZE 1024
#define DRV_FILEIO_INTERNAL_FLASH_CONFIG_WRITE_BLOCK_SIZE 64

#define MAIN_RETURN void

/*********************************************************************
* Function: void SYSTEM_Initialize(void)
*
* Overview: Initializes the system.
*
* PreCondition: None
*
* Input: None
*
* Output: None
*
********************************************************************/
void SYSTEM_Initialize(void);

/*********************************************************************
* Function: void SYSTEM_Tasks(void)
*
* Overview: Runs system level tasks that keep the system running
*
* PreCondition: System has been initalized with SYSTEM_Initialize()
*
* Input: None
*
* Output: None
*
********************************************************************/
#define SYSTEM_Tasks()


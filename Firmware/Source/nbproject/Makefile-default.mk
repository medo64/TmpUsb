#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Microchip/Application/usb_descriptors.c Microchip/Application/app_device_msd.c Microchip/Application/files.c Microchip/Framework/usb/src/usb_device.c Microchip/Framework/usb/src/usb_device_msd.c Microchip/Framework/driver/fileio/src/internal_flash.c app.c config.c io.c timing.c settings.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Microchip/Application/usb_descriptors.p1 ${OBJECTDIR}/Microchip/Application/app_device_msd.p1 ${OBJECTDIR}/Microchip/Application/files.p1 ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1 ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1 ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1 ${OBJECTDIR}/app.p1 ${OBJECTDIR}/config.p1 ${OBJECTDIR}/io.p1 ${OBJECTDIR}/timing.p1 ${OBJECTDIR}/settings.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d ${OBJECTDIR}/Microchip/Application/files.p1.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d ${OBJECTDIR}/app.p1.d ${OBJECTDIR}/config.p1.d ${OBJECTDIR}/io.p1.d ${OBJECTDIR}/timing.p1.d ${OBJECTDIR}/settings.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Microchip/Application/usb_descriptors.p1 ${OBJECTDIR}/Microchip/Application/app_device_msd.p1 ${OBJECTDIR}/Microchip/Application/files.p1 ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1 ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1 ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1 ${OBJECTDIR}/app.p1 ${OBJECTDIR}/config.p1 ${OBJECTDIR}/io.p1 ${OBJECTDIR}/timing.p1 ${OBJECTDIR}/settings.p1

# Source Files
SOURCEFILES=Microchip/Application/usb_descriptors.c Microchip/Application/app_device_msd.c Microchip/Application/files.c Microchip/Framework/usb/src/usb_device.c Microchip/Framework/usb/src/usb_device_msd.c Microchip/Framework/driver/fileio/src/internal_flash.c app.c config.c io.c timing.c settings.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

# The following macros may be used in the pre and post step lines
Device=PIC18F26J50
ProjectDir="Q:\Projects\Electronics\TmpUsb\Firmware\Source"
ConfName=default
ImagePath="dist\default\${IMAGE_TYPE}\Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ImageDir="dist\default\${IMAGE_TYPE}"
ImageName="Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"

.build-conf:  .pre ${BUILD_SUBPROJECTS}
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
	@echo "--------------------------------------"
	@echo "User defined post-build step: [Powershell.exe -ExecutionPolicy RemoteSigned -File ${ProjectDir}\..\Setup\HexReplace.ps1 ${ProjectDir}\dist\default\production\Source.production.hex 197901281815 -Destination2 ${ProjectDir}\..\Binaries\TmpUsb.hex -AsciiHexRandom]"
	@Powershell.exe -ExecutionPolicy RemoteSigned -File ${ProjectDir}\..\Setup\HexReplace.ps1 ${ProjectDir}\dist\default\production\Source.production.hex 197901281815 -Destination2 ${ProjectDir}\..\Binaries\TmpUsb.hex -AsciiHexRandom
	@echo "--------------------------------------"

MP_PROCESSOR_OPTION=18F26J50
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Microchip/Application/usb_descriptors.p1: Microchip/Application/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/usb_descriptors.p1  Microchip/Application/usb_descriptors.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/usb_descriptors.d ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Application/app_device_msd.p1: Microchip/Application/app_device_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/app_device_msd.p1  Microchip/Application/app_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/app_device_msd.d ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Application/files.p1: Microchip/Application/files.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/files.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/files.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/files.p1  Microchip/Application/files.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/files.d ${OBJECTDIR}/Microchip/Application/files.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/files.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1: Microchip/Framework/usb/src/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/usb/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1  Microchip/Framework/usb/src/usb_device.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1: Microchip/Framework/usb/src/usb_device_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/usb/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1  Microchip/Framework/usb/src/usb_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1: Microchip/Framework/driver/fileio/src/internal_flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1  Microchip/Framework/driver/fileio/src/internal_flash.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.d ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/app.p1: app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app.p1.d 
	@${RM} ${OBJECTDIR}/app.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/app.p1  app.c 
	@-${MV} ${OBJECTDIR}/app.d ${OBJECTDIR}/app.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/app.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/config.p1: config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/config.p1.d 
	@${RM} ${OBJECTDIR}/config.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/config.p1  config.c 
	@-${MV} ${OBJECTDIR}/config.d ${OBJECTDIR}/config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/io.p1: io.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/io.p1.d 
	@${RM} ${OBJECTDIR}/io.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/io.p1  io.c 
	@-${MV} ${OBJECTDIR}/io.d ${OBJECTDIR}/io.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/io.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/timing.p1: timing.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/timing.p1.d 
	@${RM} ${OBJECTDIR}/timing.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/timing.p1  timing.c 
	@-${MV} ${OBJECTDIR}/timing.d ${OBJECTDIR}/timing.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/timing.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/settings.p1: settings.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/settings.p1.d 
	@${RM} ${OBJECTDIR}/settings.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/settings.p1  settings.c 
	@-${MV} ${OBJECTDIR}/settings.d ${OBJECTDIR}/settings.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/settings.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/Microchip/Application/usb_descriptors.p1: Microchip/Application/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/usb_descriptors.p1  Microchip/Application/usb_descriptors.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/usb_descriptors.d ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/usb_descriptors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Application/app_device_msd.p1: Microchip/Application/app_device_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/app_device_msd.p1  Microchip/Application/app_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/app_device_msd.d ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/app_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Application/files.p1: Microchip/Application/files.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Application 
	@${RM} ${OBJECTDIR}/Microchip/Application/files.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Application/files.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Application/files.p1  Microchip/Application/files.c 
	@-${MV} ${OBJECTDIR}/Microchip/Application/files.d ${OBJECTDIR}/Microchip/Application/files.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Application/files.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1: Microchip/Framework/usb/src/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/usb/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1  Microchip/Framework/usb/src/usb_device.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1: Microchip/Framework/usb/src/usb_device_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/usb/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1  Microchip/Framework/usb/src/usb_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.d ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/usb/src/usb_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1: Microchip/Framework/driver/fileio/src/internal_flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src 
	@${RM} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1  Microchip/Framework/driver/fileio/src/internal_flash.c 
	@-${MV} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.d ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/Framework/driver/fileio/src/internal_flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/app.p1: app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app.p1.d 
	@${RM} ${OBJECTDIR}/app.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/app.p1  app.c 
	@-${MV} ${OBJECTDIR}/app.d ${OBJECTDIR}/app.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/app.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/config.p1: config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/config.p1.d 
	@${RM} ${OBJECTDIR}/config.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/config.p1  config.c 
	@-${MV} ${OBJECTDIR}/config.d ${OBJECTDIR}/config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/io.p1: io.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/io.p1.d 
	@${RM} ${OBJECTDIR}/io.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/io.p1  io.c 
	@-${MV} ${OBJECTDIR}/io.d ${OBJECTDIR}/io.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/io.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/timing.p1: timing.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/timing.p1.d 
	@${RM} ${OBJECTDIR}/timing.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/timing.p1  timing.c 
	@-${MV} ${OBJECTDIR}/timing.d ${OBJECTDIR}/timing.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/timing.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/settings.p1: settings.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/settings.p1.d 
	@${RM} ${OBJECTDIR}/settings.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: (%%n) %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"    -o${OBJECTDIR}/settings.p1  settings.c 
	@-${MV} ${OBJECTDIR}/settings.d ${OBJECTDIR}/settings.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/settings.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    Microchip/rm18f26j50_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.map  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"        -odist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.hex 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   Microchip/rm18f26j50_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.map  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,+speed,-space,-debug --addrqual=ignore --mode=free -P -N255 -I"Microchip/Framework" -I"Microchip/Framework/usb" -I"Microchip/Application" -I"Microchip/Custom" --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%%f:%%l: error: %%s" "--warnformat=%%f:%%l: warning: (%%n) %%s" "--msgformat=%%f:%%l: advisory: (%%n) %%s"     -odist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif

.pre:
	@echo "--------------------------------------"
	@echo "User defined pre-build step: [COPY /B ${ProjectDir}\App.c+,,]"
	@COPY /B ${ProjectDir}\App.c+,,
	@echo "--------------------------------------"

# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

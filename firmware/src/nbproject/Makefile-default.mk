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
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Microchip/app_device_msd.c Microchip/files.c Microchip/internal_flash.c Microchip/usb_descriptors.c Microchip/usb_device.c Microchip/usb_device_msd.c app.c config.c io.c timing.c settings.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Microchip/app_device_msd.p1 ${OBJECTDIR}/Microchip/files.p1 ${OBJECTDIR}/Microchip/internal_flash.p1 ${OBJECTDIR}/Microchip/usb_descriptors.p1 ${OBJECTDIR}/Microchip/usb_device.p1 ${OBJECTDIR}/Microchip/usb_device_msd.p1 ${OBJECTDIR}/app.p1 ${OBJECTDIR}/config.p1 ${OBJECTDIR}/io.p1 ${OBJECTDIR}/timing.p1 ${OBJECTDIR}/settings.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/Microchip/app_device_msd.p1.d ${OBJECTDIR}/Microchip/files.p1.d ${OBJECTDIR}/Microchip/internal_flash.p1.d ${OBJECTDIR}/Microchip/usb_descriptors.p1.d ${OBJECTDIR}/Microchip/usb_device.p1.d ${OBJECTDIR}/Microchip/usb_device_msd.p1.d ${OBJECTDIR}/app.p1.d ${OBJECTDIR}/config.p1.d ${OBJECTDIR}/io.p1.d ${OBJECTDIR}/timing.p1.d ${OBJECTDIR}/settings.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Microchip/app_device_msd.p1 ${OBJECTDIR}/Microchip/files.p1 ${OBJECTDIR}/Microchip/internal_flash.p1 ${OBJECTDIR}/Microchip/usb_descriptors.p1 ${OBJECTDIR}/Microchip/usb_device.p1 ${OBJECTDIR}/Microchip/usb_device_msd.p1 ${OBJECTDIR}/app.p1 ${OBJECTDIR}/config.p1 ${OBJECTDIR}/io.p1 ${OBJECTDIR}/timing.p1 ${OBJECTDIR}/settings.p1

# Source Files
SOURCEFILES=Microchip/app_device_msd.c Microchip/files.c Microchip/internal_flash.c Microchip/usb_descriptors.c Microchip/usb_device.c Microchip/usb_device_msd.c app.c config.c io.c timing.c settings.c



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
_/_=/
ShExtension=.sh
Device=PIC18F26J50
ProjectDir=/Data/Projects/Electronics/Interfaces/TmpUsb/firmware/src
ProjectName=TmpUsb
ConfName=default
ImagePath=dist/default/${IMAGE_TYPE}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
ImageDir=dist/default/${IMAGE_TYPE}
ImageName=src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  .pre ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
	@echo "--------------------------------------"
	@echo "User defined post-build step: []"
	@
	@echo "--------------------------------------"

MP_PROCESSOR_OPTION=18F26J50
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Microchip/app_device_msd.p1: Microchip/app_device_msd.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/app_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/app_device_msd.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/app_device_msd.p1 Microchip/app_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/app_device_msd.d ${OBJECTDIR}/Microchip/app_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/app_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/files.p1: Microchip/files.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/files.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/files.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/files.p1 Microchip/files.c 
	@-${MV} ${OBJECTDIR}/Microchip/files.d ${OBJECTDIR}/Microchip/files.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/files.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/internal_flash.p1: Microchip/internal_flash.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/internal_flash.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/internal_flash.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/internal_flash.p1 Microchip/internal_flash.c 
	@-${MV} ${OBJECTDIR}/Microchip/internal_flash.d ${OBJECTDIR}/Microchip/internal_flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/internal_flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_descriptors.p1: Microchip/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_descriptors.p1 Microchip/usb_descriptors.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_descriptors.d ${OBJECTDIR}/Microchip/usb_descriptors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_descriptors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_device.p1: Microchip/usb_device.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_device.p1 Microchip/usb_device.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_device.d ${OBJECTDIR}/Microchip/usb_device.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_device.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_device_msd.p1: Microchip/usb_device_msd.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device_msd.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_device_msd.p1 Microchip/usb_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_device_msd.d ${OBJECTDIR}/Microchip/usb_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/app.p1: app.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/app.p1.d 
	@${RM} ${OBJECTDIR}/app.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/app.p1 app.c 
	@-${MV} ${OBJECTDIR}/app.d ${OBJECTDIR}/app.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/app.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/config.p1: config.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/config.p1.d 
	@${RM} ${OBJECTDIR}/config.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/config.p1 config.c 
	@-${MV} ${OBJECTDIR}/config.d ${OBJECTDIR}/config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/io.p1: io.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/io.p1.d 
	@${RM} ${OBJECTDIR}/io.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/io.p1 io.c 
	@-${MV} ${OBJECTDIR}/io.d ${OBJECTDIR}/io.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/io.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/timing.p1: timing.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/timing.p1.d 
	@${RM} ${OBJECTDIR}/timing.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/timing.p1 timing.c 
	@-${MV} ${OBJECTDIR}/timing.d ${OBJECTDIR}/timing.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/timing.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/settings.p1: settings.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/settings.p1.d 
	@${RM} ${OBJECTDIR}/settings.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=none   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/settings.p1 settings.c 
	@-${MV} ${OBJECTDIR}/settings.d ${OBJECTDIR}/settings.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/settings.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/Microchip/app_device_msd.p1: Microchip/app_device_msd.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/app_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/app_device_msd.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/app_device_msd.p1 Microchip/app_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/app_device_msd.d ${OBJECTDIR}/Microchip/app_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/app_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/files.p1: Microchip/files.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/files.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/files.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/files.p1 Microchip/files.c 
	@-${MV} ${OBJECTDIR}/Microchip/files.d ${OBJECTDIR}/Microchip/files.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/files.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/internal_flash.p1: Microchip/internal_flash.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/internal_flash.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/internal_flash.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/internal_flash.p1 Microchip/internal_flash.c 
	@-${MV} ${OBJECTDIR}/Microchip/internal_flash.d ${OBJECTDIR}/Microchip/internal_flash.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/internal_flash.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_descriptors.p1: Microchip/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_descriptors.p1 Microchip/usb_descriptors.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_descriptors.d ${OBJECTDIR}/Microchip/usb_descriptors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_descriptors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_device.p1: Microchip/usb_device.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_device.p1 Microchip/usb_device.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_device.d ${OBJECTDIR}/Microchip/usb_device.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_device.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/Microchip/usb_device_msd.p1: Microchip/usb_device_msd.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/Microchip" 
	@${RM} ${OBJECTDIR}/Microchip/usb_device_msd.p1.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device_msd.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/Microchip/usb_device_msd.p1 Microchip/usb_device_msd.c 
	@-${MV} ${OBJECTDIR}/Microchip/usb_device_msd.d ${OBJECTDIR}/Microchip/usb_device_msd.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/Microchip/usb_device_msd.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/app.p1: app.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/app.p1.d 
	@${RM} ${OBJECTDIR}/app.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/app.p1 app.c 
	@-${MV} ${OBJECTDIR}/app.d ${OBJECTDIR}/app.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/app.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/config.p1: config.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/config.p1.d 
	@${RM} ${OBJECTDIR}/config.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/config.p1 config.c 
	@-${MV} ${OBJECTDIR}/config.d ${OBJECTDIR}/config.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/config.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/io.p1: io.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/io.p1.d 
	@${RM} ${OBJECTDIR}/io.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/io.p1 io.c 
	@-${MV} ${OBJECTDIR}/io.d ${OBJECTDIR}/io.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/io.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/timing.p1: timing.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/timing.p1.d 
	@${RM} ${OBJECTDIR}/timing.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/timing.p1 timing.c 
	@-${MV} ${OBJECTDIR}/timing.d ${OBJECTDIR}/timing.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/timing.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/settings.p1: settings.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/settings.p1.d 
	@${RM} ${OBJECTDIR}/settings.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -DXPRJ_default=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits $(COMPARISON_BUILD)  -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     -o ${OBJECTDIR}/settings.p1 settings.c 
	@-${MV} ${OBJECTDIR}/settings.d ${OBJECTDIR}/settings.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/settings.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/src.${IMAGE_TYPE}.map  -D__DEBUG=1  -mdebugger=none  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto        $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/src.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} ${DISTDIR}/src.${IMAGE_TYPE}.hex 
	
else
${DISTDIR}/src.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/src.${IMAGE_TYPE}.map  -DXPRJ_default=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"Microchip" -mwarn=0 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits -std=c90 -gdwarf-3 -mstack=compiled:auto:auto:auto     $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/src.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif

.pre:
	@echo "--------------------------------------"
	@echo "User defined pre-build step: []"
	@
	@echo "--------------------------------------"

# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

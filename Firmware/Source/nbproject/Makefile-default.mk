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
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Microchip/Files.c Microchip/usb_device.c Microchip/usb_function_msd.c "Microchip/Internal Flash.c" Microchip/usb_descriptors.c config.c app.c app_usb.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Microchip/Files.o ${OBJECTDIR}/Microchip/usb_device.o ${OBJECTDIR}/Microchip/usb_function_msd.o "${OBJECTDIR}/Microchip/Internal Flash.o" ${OBJECTDIR}/Microchip/usb_descriptors.o ${OBJECTDIR}/config.o ${OBJECTDIR}/app.o ${OBJECTDIR}/app_usb.o
POSSIBLE_DEPFILES=${OBJECTDIR}/Microchip/Files.o.d ${OBJECTDIR}/Microchip/usb_device.o.d ${OBJECTDIR}/Microchip/usb_function_msd.o.d "${OBJECTDIR}/Microchip/Internal Flash.o.d" ${OBJECTDIR}/Microchip/usb_descriptors.o.d ${OBJECTDIR}/config.o.d ${OBJECTDIR}/app.o.d ${OBJECTDIR}/app_usb.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Microchip/Files.o ${OBJECTDIR}/Microchip/usb_device.o ${OBJECTDIR}/Microchip/usb_function_msd.o ${OBJECTDIR}/Microchip/Internal\ Flash.o ${OBJECTDIR}/Microchip/usb_descriptors.o ${OBJECTDIR}/config.o ${OBJECTDIR}/app.o ${OBJECTDIR}/app_usb.o

# Source Files
SOURCEFILES=Microchip/Files.c Microchip/usb_device.c Microchip/usb_function_msd.c Microchip/Internal Flash.c Microchip/usb_descriptors.c config.c app.c app_usb.c


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

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F26J50
MP_PROCESSOR_OPTION_LD=18f26j50
MP_LINKER_DEBUG_OPTION=  -u_DEBUGSTACK
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Microchip/Files.o: Microchip/Files.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/Files.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Files.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/Files.o   Microchip/Files.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/Files.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Files.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_device.o: Microchip/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_device.o   Microchip/usb_device.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_device.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_device.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_function_msd.o: Microchip/usb_function_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_function_msd.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_function_msd.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_function_msd.o   Microchip/usb_function_msd.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_function_msd.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_function_msd.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/Internal\ Flash.o: Microchip/Internal\ Flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/Internal\ Flash.o.d 
	@${RM} "${OBJECTDIR}/Microchip/Internal Flash.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo "${OBJECTDIR}/Microchip/Internal Flash.o"   "Microchip/Internal Flash.c" 
	@${DEP_GEN} -d "${OBJECTDIR}/Microchip/Internal Flash.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Internal Flash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_descriptors.o: Microchip/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_descriptors.o   Microchip/usb_descriptors.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_descriptors.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_descriptors.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/config.o: config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/config.o.d 
	@${RM} ${OBJECTDIR}/config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/config.o   config.c 
	@${DEP_GEN} -d ${OBJECTDIR}/config.o 
	@${FIXDEPS} "${OBJECTDIR}/config.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/app.o: app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app.o.d 
	@${RM} ${OBJECTDIR}/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/app.o   app.c 
	@${DEP_GEN} -d ${OBJECTDIR}/app.o 
	@${FIXDEPS} "${OBJECTDIR}/app.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/app_usb.o: app_usb.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app_usb.o.d 
	@${RM} ${OBJECTDIR}/app_usb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/app_usb.o   app_usb.c 
	@${DEP_GEN} -d ${OBJECTDIR}/app_usb.o 
	@${FIXDEPS} "${OBJECTDIR}/app_usb.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
else
${OBJECTDIR}/Microchip/Files.o: Microchip/Files.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/Files.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Files.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/Files.o   Microchip/Files.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/Files.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Files.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_device.o: Microchip/usb_device.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_device.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_device.o   Microchip/usb_device.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_device.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_device.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_function_msd.o: Microchip/usb_function_msd.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_function_msd.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_function_msd.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_function_msd.o   Microchip/usb_function_msd.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_function_msd.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_function_msd.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/Internal\ Flash.o: Microchip/Internal\ Flash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/Internal\ Flash.o.d 
	@${RM} "${OBJECTDIR}/Microchip/Internal Flash.o" 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo "${OBJECTDIR}/Microchip/Internal Flash.o"   "Microchip/Internal Flash.c" 
	@${DEP_GEN} -d "${OBJECTDIR}/Microchip/Internal Flash.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Internal Flash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/Microchip/usb_descriptors.o: Microchip/usb_descriptors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.o.d 
	@${RM} ${OBJECTDIR}/Microchip/usb_descriptors.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/Microchip/usb_descriptors.o   Microchip/usb_descriptors.c 
	@${DEP_GEN} -d ${OBJECTDIR}/Microchip/usb_descriptors.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/usb_descriptors.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/config.o: config.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/config.o.d 
	@${RM} ${OBJECTDIR}/config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/config.o   config.c 
	@${DEP_GEN} -d ${OBJECTDIR}/config.o 
	@${FIXDEPS} "${OBJECTDIR}/config.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/app.o: app.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app.o.d 
	@${RM} ${OBJECTDIR}/app.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/app.o   app.c 
	@${DEP_GEN} -d ${OBJECTDIR}/app.o 
	@${FIXDEPS} "${OBJECTDIR}/app.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
${OBJECTDIR}/app_usb.o: app_usb.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/app_usb.o.d 
	@${RM} ${OBJECTDIR}/app_usb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE) -p$(MP_PROCESSOR_OPTION) -I".." -I"../Include" -I"../" -I"Microchip" -I"." -ml -oa-  -I ${MP_CC_DIR}\\..\\h  -fo ${OBJECTDIR}/app_usb.o   app_usb.c 
	@${DEP_GEN} -d ${OBJECTDIR}/app_usb.o 
	@${FIXDEPS} "${OBJECTDIR}/app_usb.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    Microchip/rm18f26j50_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "Microchip\rm18f26j50_g.lkr"  -p$(MP_PROCESSOR_OPTION_LD)  -w -x -u_DEBUG -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"  -z__MPLAB_BUILD=1  -u_CRUNTIME -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PK3=1 $(MP_LINKER_DEBUG_OPTION) -l ${MP_CC_DIR}\\..\\lib  -o dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   
else
dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   Microchip/rm18f26j50_g.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "Microchip\rm18f26j50_g.lkr"  -p$(MP_PROCESSOR_OPTION_LD)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"  -z__MPLAB_BUILD=1  -u_CRUNTIME -l ${MP_CC_DIR}\\..\\lib  -o dist/${CND_CONF}/${IMAGE_TYPE}/Source.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   
endif


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

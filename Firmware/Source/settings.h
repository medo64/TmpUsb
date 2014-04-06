#ifndef SETTINGS_H
#define	SETTINGS_H

#include <GenericTypeDefs.h>


void settings_init(void);
void settings_reset(void);

unsigned int settings_getTimingChargeLimit(void);
void settings_setTimingChargeLimit(unsigned int value);

BOOL settings_getIsArmed(void);
void settings_setIsArmed(BOOL value);


#endif

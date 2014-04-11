#ifndef SETTINGS_H
#define	SETTINGS_H

#include <GenericTypeDefs.h>


void settings_init(void);
void settings_reset(void);

unsigned short settings_getTimingChargeLimit(void);
void settings_setTimingChargeLimit(unsigned short value);

bool settings_getIsArmed(void);
void settings_setIsArmed(bool value);


#endif

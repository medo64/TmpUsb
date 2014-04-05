#ifndef SETTINGS_H
#define	SETTINGS_H


void settings_init(void);

unsigned int settings_getTimingChargeLimit(void);
void settings_setTimingChargeLimit(unsigned int value);

unsigned char settings_getIsArmed(void);
void settings_setIsArmed(unsigned char value);


#endif

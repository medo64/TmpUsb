#ifndef IO_H
#define	IO_H


void io_init(void);

void io_led_on(void);
void io_led_off(void);

unsigned char io_disk_isLabelArmed(void);
unsigned char io_disk_isLabelCalibrate(void);

unsigned char io_disk_isValid(void);

void io_disk_erase(unsigned char* label);

#endif

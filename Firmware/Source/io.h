#ifndef IO_H
#define	IO_H


void io_init(void);

void io_led_on(void);
void io_led_off(void);

unsigned char io_disk_isArmed(void);
unsigned char io_disk_isExpired(void);
void io_disk_erase(void);

#endif

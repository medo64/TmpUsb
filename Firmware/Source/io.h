#ifndef IO_H
#define	IO_H


#define IO_DISK_LABEL_ARMED      "Armed"
#define IO_DISK_LABEL_NOTARMED   "Not Armed"
#define IO_DISK_LABEL_CALIBRATE  "Calibrate"

void io_init(void);

void io_led_on(void);
void io_led_off(void);
void io_led_toggle(void);

unsigned char io_disk_hasLabel(const rom char* label);

unsigned char io_disk_isValid(void);

void io_disk_erase(unsigned char* label);

#endif

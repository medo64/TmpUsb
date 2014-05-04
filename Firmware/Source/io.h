#ifndef IO_H
#define	IO_H

#include <stdbool.h>


#define IO_DISK_LABEL_ARM        "Arm"
#define IO_DISK_LABEL_ARM_MAX_1  "ArmMax"
#define IO_DISK_LABEL_ARM_MAX_2  "Arm Max"
#define IO_DISK_LABEL_ARMED      "Armed"
#define IO_DISK_LABEL_RESET      "Reset"
#define IO_DISK_LABEL_NOTARMED   "Not Armed"
#define IO_DISK_LABEL_CALIBRATE  "Calibrate"
#define IO_DISK_LABEL_READONLY   "ReadOnly"


void io_init(void);

void io_led_on(void);
void io_led_off(void);
void io_led_toggle(void);

bool io_5v_isOn(void);

bool io_disk_isValid(void);
bool io_disk_hasLabel(const uint8_t* label);
void io_disk_erase(uint8_t* label);


#endif

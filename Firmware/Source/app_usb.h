#ifndef APP_USB_H
#define	APP_USB_H


void USBDeviceTasks(void);
void ProcessIO(void);
void UserInit(void);
void YourHighPriorityISRCode();
void YourLowPriorityISRCode();
void USBCBSendResume(void);


#endif

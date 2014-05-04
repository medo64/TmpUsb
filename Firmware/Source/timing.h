#ifndef TIMING_H
#define	TIMING_H

#define TIMING_CEILING  1024  //ADC maxmimum + 1
#define TIMING_STARTUP  1012  //minimum ADC value for startup
#define TIMING_LIMIT     768  //value that still allows for a single reset event


unsigned short timing_getCharge(void);
void timing_charge(void);


#endif


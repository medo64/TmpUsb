## Building TmpUsb


### Hardware

PCB was designed in [DipTrace 3.3](https://diptrace.com/) and gerber files can
be exported from the same. There are three distint versions:

* [USB A plug](hardware/src/TmpUsb-A%20%5BB%5D.md)
* [USB 2.0 motherboard header](hardware/src/TmpUsb-H2%20%5BC%5D.md)
* [USB 3.0 motherboard header](hardware/src/TmpUsb-H3%20%5BB%5D.md)

Parts needed are similar for all three but USB 3.0 header version does use 0603
components while other two boards use 0805.

Alternatively, you can grab the latest release on GitHub and send gerbers over
to [OSH Park](http://oshpark.com/) (or any other PCB manufacturer of your
choice).


### Firmware

To build the firmware you will need the following:

* [MPLAB X IDE v5.45](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-x-ide#Downloads%20and%20Documentation%20)
* [MPLAB XC8 Compiler v1.45](https://www.microchip.com/development-tools/pic-and-dspic-downloads-archive)

While newer versions of MPLAB X IDE will work just fine, make sure you use XC8
v1.45 to compile the firmware as it's not compatible with newer versions.

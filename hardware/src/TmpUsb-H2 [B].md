## TmpUsb: USB 2.0 motherboard header

This variant is intended for direct plug into the motherboard's 2.0 header.

|      |                           |
|------|---------------------------|
| Size | 21.0 x 17.0 mm ~ 0.6 sqin |
| VID  | 0x04D8                    |
| PID  | 0xF777                    |


### Parts

|  # | Part name                            | RefDes  | DigiKey              |
|---:|--------------------------------------|---------|----------------------|
|  2 | C 100nF /10V X7R (0805)              | C1 C2   | 311-1142-1-ND        |
|  2 | C 1uF /10V X5R (0805)                | C3 C4   | 1276-6471-1-ND       |
|  2 | C 10uF /10V X5R (0805)               | C5 C6   | 478-5167-6-ND        |
|  1 | DS LED (0805)                        | DS1     | 475-1415-1-ND        |
|  1 | L Ferrite 40Ohm (0805)               | L1      | 445-2201-1-ND        |
|  1 | P USB2 Header F (2x5w)               | P1      | A106395-ND †         |
|  2 | R 1K 0.125W (0805)                   | R1 R2   | RMCF0805FT1K00CT-ND  |
|  1 | R 10K 0.125W (0805)                  | R3      | RMCF0805JT10K0CT-ND  |
|  1 | R 100K 0.125W (0805)                 | R4      | RMCF0805JT100KCT-ND  |
|  1 | U PIC18F26J50-I/SS (SSOP-28)         | U1      | PIC18F26J50-I/SS-ND  |
|  1 | VR MCP1700 (SOT-23)                  | VR1     | MCP1700T3302ETTCT-ND |

† This connector is not an excellent match but the best I could find on
  DigiKey. One needs to manually remove keyed pin.


### Suggested Soldering order

Here is the suggested order for easy hand soldering.


|  # | Part name                            | RefDes  |
|---:|--------------------------------------|---------|
|  1 | U PIC18F26J50-I/SS (SSOP-28)         | U1      |
|  1 | VR MCP1700 (SOT-23)                  | VR1     |
|  2 | R 1K 0.125W (0805)                   | R1 R2   |
|  1 | R 10K 0.125W (0805)                  | R3      |
|  1 | R 100K 0.125W (0805)                 | R4      |
|  2 | C 10uF /10V X5R (0805)               | C5 C6   |
|  2 | C 1uF /10V X5R (0805)                | C3 C4   |
|  2 | C 100nF /10V X7R (0805)              | C1 C2   |
|  1 | L Ferrite 40Ohm (0805)               | L1      |
|  1 | DS LED (0805)                        | DS1     |
|  1 | P USB2 Header F (2x5w)               | P1      |

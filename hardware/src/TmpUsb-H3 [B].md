## TmpUsb: USB 3.0 motherboard header

This variant is intended for direct plug into the motherboard's 3.0 header
while leaving one extra 3.0 USB receptacle available for other devices.

|      |                           |
|------|---------------------------|
| Size | 23.5 x 22.0 mm ~ 0.8 sqin |
| VID  | 0x04D8                    |
| PID  | 0xF777                    |


### Parts

|  # | Part name                            | RefDes  | DigiKey                |
|---:|--------------------------------------|---------|------------------------|
|  2 | C 100nF /10V X7R (0805)              | C1 C2   | 311-1142-1-ND          |
|  2 | C 1uF /10V X5R (0805)                | C3 C4   | 1276-6471-1-ND         |
|  2 | C 10uF /10V X5R (0805)               | C5 C6   | 1276-1119-1-ND         |
|  1 | DS LED (0805)                        | DS1     | 160-1468-1-ND          |
|  1 | J USB A 3.0, receptacle, vertical    | J1      | 2073-USB1086-GF-B-ND ‡ |
|  1 | L Ferrite 40Ohm (0805)               | L1      | 445-2201-1-ND          |
|  1 | P USB3 header F (2x10w)              | P1      | A108127-ND †           |
|  2 | R 1K 0.125W (0805)                   | R1 R2   | RMCF0805FT1K00CT-ND    |
|  1 | R 10K 0.125W (0805)                  | R3      | RMCF0805JT10K0CT-ND    |
|  1 | R 100K 0.125W (0805)                 | R4      | RMCF0805JT100KCT-ND    |
|  1 | U PIC18F26J50-I/SS (SSOP-28)         | U1      | PIC18F26J50-I/SS-ND    |
|  1 | VR MCP1700 (SOT-23)                  | VR1     | MCP1700T3302ETTCT-ND   |

† This connector is not an excellent match but the best I could find on
  DigiKey. It seems that blue USB connector is only available on Chinese
  sites.

‡ Optional.


### Suggested Soldering order

Here is the suggested order for easy hand soldering.

|  # | Part name                            | RefDes  |
|---:|--------------------------------------|---------|
|  1 | U PIC18F26J50-I/SS (SSOP-28)         | U1      |
|  1 | VR MCP1700 (SOT-23)                  | VR1     |
|  2 | C 100nF /10V X7R (0805)              | C1 C2   |
|  2 | C 10uF /10V X5R (0805)               | C5 C6   |
|  2 | C 1uF /10V X5R (0805)                | C3 C4   |
|  2 | R 1K 0.125W (0805)                   | R1 R2   |
|  1 | R 10K 0.125W (0805)                  | R3      |
|  1 | R 100K 0.125W (0805)                 | R4      |
|  1 | L Ferrite 40Ohm (0805)               | L1      |
|  1 | DS LED (0805)                        | DS1     |
|  1 | P USB3 header F (2x10w)              | P1      |
|  1 | J USB A 3.0, receptacle, vertical    | J1      |

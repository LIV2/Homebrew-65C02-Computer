# Homebrew-65C02-Computer

![PCB](https://raw.githubusercontent.com/LIV2/Homebrew-65C02-Computer/master/images/pcb.PNG)

# Introduction
This is a 65C02 based computer with on-board Serial, Parallel IO, PS/2 Keyboard support and 3 expansion slots.  
A VGA card will come later as an expansion card  

I am designing this in Circuitmaker, You can find the Circuitmaker project [here](https://circuitmaker.com/Projects/Details/Matt-Harlum/65C02-Computer-v12)  

# Memory Map
The Memory map I am using is currently as follows:  
0x0000-0xCFFF: RAM  
0xD000-0xD0FF: UART  
0xD100-0xD1FF: VIA  
0xD200-0xD2FF: IO Select 2  
0xD300-0xD3FF: IO Select 3  
0xD400-0xDFFF: Unused  
0xE000-0xFFFF: ROM  
This can be changed to suit your needs simply by changing the configuration of the CPLD.  

# Software
* [PS/2 Keyboard controller](https://github.com/LIV2/AVR-PS2-KBC)
* [ROM](https://github.com/LIV2/MHMON)

# Expansions
* [VGA card](https://github.com/LIV2/VGA-6502)
* [Floppy Disk card](https://github.com/LIV2/65C02-FDC)

----
![Creative Commons Attribution 4.0 International License](https://github.com/creativecommons/cc-cert-core/blob/master/images/cc-by-88x31.png "CC BY")
Licensed under a [Creative Commons Attribution 4.0 International License (CC BY)](https://creativecommons.org/licenses/by/4.0/).

Except where otherwise noted, this content is published under a [CC BY license](https://creativecommons.org/licenses/by/4.0/), which means that you can copy, redistribute, remix, transform and build upon the content for any purpose even commercially as long as you give appropriate credit, provide a link to the license, and indicate if changes were made. License details: [https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)

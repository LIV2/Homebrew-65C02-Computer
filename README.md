# Homebrew-65C02-Computer

![PCB](https://raw.githubusercontent.com/LIV2/Homebrew-65C02-Computer/master/images/pcb.PNG)

# Introduction
This is a 65C02 based computer with on-board Serial, Parallel IO, PS/2 Keyboard support and 3 expansion slots.  
A VGA card will come later as an expansion card  
I have not finished the design yet so I probably wouldn't be rushing to order boards!  

I am designing this in Circuitmaker, You can find the Circuitmaker project [here](https://circuitmaker.com/Projects/Details/Matt-Harlum/6502-SBC)  

# Memory Map
The Memory map I am using is currently as follows:  
0x0000-0xCFFF: RAM  
0xD000-0xD0FF: UART  
0xD100-0xD1FF: VIA  
0xD030-0xDFFF: IO Space  
0xE000-0xFFFF: ROM  
This can be changed to suit your needs simply by changing the configuration of the CPLD.  

# Software
Code for the PS/2 Keyboard controller is available on my github at https://github.com/LIV2/AVR-PS2-KBC  
Sources for the CPLD and a basic Monitor ROM will become available on my github as this system is developed.  

----
![Creative Commons Attribution 4.0 International License](https://github.com/creativecommons/cc-cert-core/blob/master/images/cc-by-88x31.png "CC BY")
Licensed under a [Creative Commons Attribution 4.0 International License (CC BY)](https://creativecommons.org/licenses/by/4.0/).

Except where otherwise noted, this content is published under a [CC BY license](https://creativecommons.org/licenses/by/4.0/), which means that you can copy, redistribute, remix, transform and build upon the content for any purpose even commercially as long as you give appropriate credit, provide a link to the license, and indicate if changes were made. License details: [https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)

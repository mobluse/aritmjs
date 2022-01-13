# aritmjs
Aritm for various programming languages, e.g. dialects of BASIC, PHP, and JavaScript, is FOSS.

Run online:
* https://mobluse.github.io/jsbasic/
* https://www.commanderx16.com/forum/index.php?/files/file/73-aritm/

See demos on YouTube:
* Transam Triton: https://youtu.be/DEfL17FnStc
* C64/THEC64 MINI: https://youtu.be/65AOkL8Yz6E

Aritm exists for many plattforms e.g. graphing calculators (TI and Casio), spread sheets, feature phones with Java, etc., see http://aritm.orbin.se. 

Convert BASIC to JavaScript:
* https://paulsperambulations.wordpress.com/2017/03/04/converting-basic-to-javascript/
* https://www.codeproject.com/Articles/25069/JSBasic-A-BASIC-to-JavaScript-Compiler

How to produce the C64 d64 diskette image in Windows 10 using WinVICE/VICE 2.4 - 3.5:

    petcat -w2 -o aritm.prg -- aritm-c64.bas
    c1541 -format aritm03_m6,00 d64 aritm03.d64 -write aritm.prg aritm

How to produce the VIC20 d64 diskette image in Windows 10:

    petcat -l 1201 -w2 -o aritm-vic20.prg -- aritm-vic20.bas
    c1541 -format aritm03_mvb1,00 d64 aritm03-vic20.d64 -write aritm-vic20.prg aritm-vic20
    
How to make the VIC-20 bas-file from prg-file in Windows 10:

    c1541 -attach aritm03-vic20.d64 -extract
    move aritm-vic20 aritm-vic20.prg
    petcat -nh -2 -- aritm-vic20.prg | wsl sed 's/^ //' | wsl mac2unix | wsl unix2dos > aritm-vic20.bas

Essential VIC-20 info:
* http://www.sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?p=66937#p66937
* https://www.pagetable.com/?p=273

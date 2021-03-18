# aritmjs
Aritm for JavaScript JS24 is FOSS.

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

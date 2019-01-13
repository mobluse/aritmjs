# aritmjs
Aritm for JavaScript JS24 is FOSS.

Convert BASIC to JavaScript:
* https://paulsperambulations.wordpress.com/2017/03/04/converting-basic-to-javascript/
* https://www.codeproject.com/Articles/25069/JSBasic-A-BASIC-to-JavaScript-Compiler

How to produce the C64 d64 diskette image in Windows 10:

    WinVICE-2.4-x64\petcat.exe -w2 -o aritm.prg -- aritm-c64.bas
    WinVICE-2.4-x64\c1541.exe -attach aritm03.d64 -del aritm -write aritm.prg aritm

How to produce the VIC20 d64 diskette image in Windows 10:

    WinVICE-2.4-x64\petcat.exe -l 1201 -w2 -o aritm-vic20.prg -- aritm-vic20.bas
    WinVICE-2.4-x64\c1541.exe -attach aritm03-vic20.d64 -del aritm-vic20 -write aritm-vic20.prg aritm-vic20
    
How to make the VIC-20 bas-file from prg-file:

    WinVICE-2.4-x64\petcat.exe -nh -2 -- aritm-vic20.prg | sed 's/ //' | mac2unix | unix2dos > aritm-vic20.bas

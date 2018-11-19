# aritmjs
Aritm for JavaScript JS24 is FOSS.

Convert BASIC to JavaScript:
* https://paulsperambulations.wordpress.com/2017/03/04/converting-basic-to-javascript/
* https://www.codeproject.com/Articles/25069/JSBasic-A-BASIC-to-JavaScript-Compiler

How to produce the d64 diskette image in Windows 10:

    WinVICE-2.4-x64\petcat.exe -w2 -o aritm.prg -- aritm-c64.bas
    WinVICE-2.4-x64\c1541.exe -attach aritm03.d64 -del aritm -write aritm.prg aritm

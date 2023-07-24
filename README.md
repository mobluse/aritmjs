# aritmjs
Aritm for various programming languages, e.g. dialects of BASIC, PHP, and JavaScript, is FOSS.

Run online in browser:
* http://bc3c.orbin.se (Works well in Chrome on Android and iPhone.)
* https://calormen.com/jsbasic/ (Works well in Chrome on iPhone.)
* https://www.commanderx16.com/webemu/x16emu.html?manifest=/forum/download/file.php?id=1518

See demos on YouTube:
* Transam Triton: https://youtu.be/DEfL17FnStc
* C64/THEC64 MINI: https://youtu.be/65AOkL8Yz6E
* Feature Phones (with Java ME/J2ME): https://youtu.be/hnBfS8jpjZU

Aritm exists for many plattforms e.g. graphing calculators (TI and Casio), spreadsheets, feature phones with Java, etc., see http://aritm.orbin.se. Aritm was first developed in C in 1992, and then in Java, TI-BASIC 83, and TinyBASIC. The versions for other BASIC dialects were developed from the Tiny BASIC version or its descendants. 

The original purpose of this repository was to develop a version for JavaScript that works like the BASIC versions for retro computers, but since
JavaScript doesn't have `goto` that has been difficult to write so far.

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
    petcat -nh -2 -- aritm-vic20.prg | wsl sed 's/^ *//' | wsl mac2unix | wsl unix2dos > aritm-vic20.bas

Essential VIC-20 info:
* http://www.sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?p=66937#p66937
* https://www.pagetable.com/?p=273

How to produce the p-file for ZX81 in Linux:

    zxtext2p -o aritm-zx81.p aritm-zx81.bas
    xz81 aritm-zx81.p

In xz81 ZX81 emulator: `RUN 4800`  
That creates a new aritm-zx81.p that auto-starts.

Convert the ZX81 version to ZX Spectrum:

    sed 's/GOTO/GO TO/;s/GOSUB/GO SUB/;s/RAND/RANDOMIZE/;s/SCROLL/POKE 23692,255/' aritm-zx81.bas > aritm-zx81sp.bas

How to produce the tap-file for ZX Spectrum in Linux:

    bas2tap -a10 aritm-zx81sp.bas

How to run the ZX Spectrum version in Linux:

    zesarux --machine 48k aritm-zx81sp.tap

Note that the ZX Spectrum version doesn't work due to convertion problems. There is the orginal version for ZX Spectrum `aritm-zxsp.bas` from
which the ZX81 version was made, but that also doesn't work, but that is not strange since it uses 9 digit precision instead of 8 digit as the
ZX81 version.

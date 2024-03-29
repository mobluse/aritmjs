
1000 LET A=0:GOTO 20:REM Aritm - Mental calculation trainer
1010 REM Aritm v0.3.4 for BASICODE 3C is FOSS.
1020 REM (C) 1992-2022 by Mikael O. Bonnier, Lund, Sweden.
1030 REM E-mail: <mikael.bonnier@gmail.com>.
1040 REM Absolutely no warranty.
1050 REM License GPLv3+, see
1060 REM <http://www.gnu.org/licenses/gpl.html>.
1070 REM More programs at
1080 REM <http://www.df.lth.se.orbin.se/~mikaelb/basic/>.
1090 REM Documentation:
1100 REM 6543210, 6:Type, 5-3:Op1, 2-1:Op2, 0:#Todo.
1110 REM Program:
1115 LET CC(0)=6:LET CC(1)=0:GOSUB 100
1117 DIM P(590)
1118 DEF FNMD(Y)=INT(.5+(X/Y-INT(X/Y))*Y)
1119 DEF FNDIV(Y)=INT(.001+X/Y)
1120 REM Lbl C
1130 GOSUB 3410:REM ClS
1140 LET A2=0
1150 IF L>0 AND M<>0 THEN GOTO 3000:REM ContMenu
1160 IF 0=M THEN LET M=10
1170 GOTO 3030:REM Menu
1180 REM Lbl S
1190 GOSUB 3410:REM ClS
1200 PRINT "Generating"
1210 PRINT "Problems..."
1220 LET U=1
1230 REM DIM P(N)
1240 REM Lbl Add1
1250 LET X=M:LET Y=10:LET X=FNDIV(Y)
1255 IF 0=FNMD(Y) THEN GOTO 1320:REM Add2
1260 FOR I=0 TO 9
1270 FOR J=0 TO 9
1280 LET P(U)=1000000+I*1000+J*10+1
1290 LET U=U+1
1300 NEXT J
1310 NEXT I
1320 REM Lbl Add2
1330 LET X=M:LET X=FNDIV(100)
1335 IF 0=FNMD(10) THEN GOTO 1410:REM Sub1
1340 FOR I=0 TO 9
1350 FOR J=0 TO 9
1360 GOSUB 260:LET T1=10*(INT(8*RV)+1)
1370 LET P(U)=2000000+(T1+I)*1000+J*10+1
1380 LET U=U+1
1390 NEXT J
1400 NEXT I
1410 REM Lbl Sub1
1420 LET X=M:LET X=FNDIV(1000)
1425 IF 0=FNMD(10) THEN GOTO 1490:REM Sub2
1430 FOR I=0 TO 9
1440 FOR J=I TO 9+I
1450 LET P(U)=3000000+J*1000+I*10+1
1460 LET U=U+1
1470 NEXT J
1480 NEXT I
1490 REM Lbl Sub2
1500 LET X=M:LET X=FNDIV(10000)
1505 IF 0=FNMD(10) THEN GOTO 1580:REM Mul
1510 FOR I=0 TO 9
1520 FOR J=I TO 9+I
1530 GOSUB 260:LET T1=10*(INT(9*RV)+1)
1540 LET P(U)=4000000+(T1+J)*1000+I*10+1
1550 LET U=U+1
1560 NEXT J
1570 NEXT I
1580 REM Lbl Mul
1590 LET X=M:LET X=FNDIV(100000)
1595 IF 0=FNMD(10) THEN GOTO 1660:REM Div
1600 FOR I=0 TO 9
1610 FOR J=0 TO 9
1620 LET P(U)=5000000+I*1000+J*10+1
1630 LET U=U+1
1640 NEXT J
1650 NEXT I
1660 REM Lbl Div
1670 LET X=M:LET X=FNDIV(1000000)
1675 IF 0=FNMD(10) THEN GOTO 1750:REM EndIf
1680 FOR I=0 TO 9
1690 FOR J=1 TO 9
1700 GOSUB 260:LET T1=I*J+INT(J*RV)
1710 LET P(U)=6000000+T1*1000+J*10+1
1720 LET U=U+1
1730 NEXT J
1740 NEXT I
1750 REM Lbl EndIf
1760 LET U=U-1
1770 LET L=U
1780 REM Lbl U
1790 PRINT "Shuffling..."
1800 FOR I=U TO 2 STEP -1
1810 GOSUB 260:LET J=INT(I*RV)+1
1820 LET T=P(I)
1830 LET P(I)=P(J)
1840 LET P(J)=T
1850 NEXT I
1860 LET K=1
1870 REM Lbl K
1880 GOSUB 3410:REM ClS
1890 LET SR=L:GOSUB 300:PRINT SR$;" problems left. -1 Esc"
1900 LET T=P(K)
1910 LET X=T
1915 LET C=FNDIV(1000000)
1920 IF 6=C THEN PRINT "Integer part of ";
1930 LET X=T:LET X=FNDIV(1000)
1935 LET I=FNMD(1000)
1940 LET SR=I:GOSUB 300:PRINT SR$;
1950 GOSUB 3280:REM Sign
1960 LET X=T:LET X=FNDIV(10)
1965 LET J=FNMD(100)
1970 LET SR=J:GOSUB 300:PRINT SR$;
1980 INPUT " = ";A2$:LET A2=VAL(A2$)
1990 IF -1=A2 OR ".1"=A2$ OR "01"=A2$ THEN GOTO 1120:REM C
2000 IF 1=C OR 2=C THEN LET R=I+J:GOTO 2040:REM EndIf
2010 IF 3=C OR 4=C THEN LET R=I-J:GOTO 2040:REM EndIf
2020 IF 5=C THEN LET R=I*J:GOTO 2040:REM EndIf
2030 IF 6=C THEN LET X=I:LET R=FNDIV(J)
2040 REM Lbl EndIf
2050 IF R<>A2 THEN GOTO 2140:REM Wrong
2060 PRINT "Right! ";
2070 LET X=T
2075 IF 0>=FNMD(10) THEN GOTO 2100:REM EndIf
2080 LET L=L-1
2090 LET P(K)=T-1
2100 REM Lbl EndIf
2110 LET K=K+1
2120 IF 0<L THEN LET D=500:GOSUB 3402:REM Delay
2130 GOTO 2250:REM EndIf 2
2140 REM Lbl Wrong
2150 PRINT "Wrong. ";
2155 GOSUB 250:REM Beep
2160 LET SR=I:GOSUB 300:PRINT SR$;
2170 GOSUB 3280:REM Sign
2180 LET SR=J:GOSUB 300:PRINT SR$;" is ";:LET SR=R:GOSUB 300:PRINT SR$;"."
2190 LET X=T
2195 IF 9<=FNMD(10) THEN GOTO 2220:REM EndIf
2200 LET L=L+1
2210 LET P(K)=T+1
2220 REM Lbl EndIf
2230 LET K=K+1
2240 LET D=1000:GOSUB 3402:REM Delay
2250 REM Lbl EndIf 2
2260 IF K<=U GOTO 1870:REM K
2270 IF 0>=L GOTO 2390:REM W
2280 PRINT "Checking..."
2290 LET N=1
2300 FOR K=1 TO U
2310 LET T=P(K)
2320 LET X=T
2325 IF 0=FNMD(10) THEN GOTO 2350:REM EndIf
2330 LET P(N)=T
2340 LET N=N+1
2350 REM EndIf
2360 NEXT K
2370 LET U=N-1
2380 GOTO 1780:REM U
2390 REM Lbl W
2400 PRINT "Good!!! Well done!"
2410 LET D=5000:GOSUB 3402:REM Delay
2420 GOTO 1120:REM C
2430 REM Lbl E
2440 GOSUB 3410:REM ClS
2450 LET A2=0
2460 LET N=0
2470 LET T=M
2480 GOSUB 2640:REM Sub
2490 PRINT "Addition 1"
2500 GOSUB 2640:REM Sub
2510 PRINT "Addition 2"
2520 GOSUB 2640:REM Sub
2530 PRINT "Subtraction 1"
2540 GOSUB 2640:REM Sub
2550 PRINT "Subtraction 2"
2560 GOSUB 2640:REM Sub
2570 PRINT "Multiplication"
2580 GOSUB 2640:REM Sub
2590 PRINT "Division | -1 Esc"
2600 PRINT "0 OK and Go ";
2605 LET SR=N:GOSUB 300:PRINT SR$
2610 GOTO 2780:REM Input
2640 REM Sub
2650 LET A2=A2+1
2660 LET X=T
2665 LET T=FNDIV(10)
2670 LET SR=A2:GOSUB 300:PRINT SR$;
2680 LET X=T
2685 IF 0=FNMD(10) THEN GOTO 2720:REM Else
2690 PRINT "*";
2700 LET N=N+100-10*ABS(6=A2)
2710 GOTO 2740:REM EndIf
2720 REM Lbl Else
2730 PRINT " ";
2740 REM Lbl EndIf
2750 RETURN
2780 REM Lbl Input
2790 INPUT "Toggle item 1-6, or choose 0 or -1: ";A2$:LET A2=VAL(A2$)
2800 IF -1>A2 OR 6<A2 OR (0=A2 AND 0=N) THEN GOTO 2780:REM Input
2810 IF 0=A2 THEN GOTO 1180:REM S
2820 IF -1=A2 OR ".1"=A2$ OR "01"=A2$ THEN GOTO 1120:REM C
2830 GOSUB 3350:REM 10^A
2840 LET X=M
2842 LET X=FNDIV(R)
2845 IF 0=FNMD(10) THEN GOTO 2870:REM Else
2850 LET M=M-R
2860 GOTO 2890:REM EndIf
2870 REM Lbl Else
2880 LET M=M+R
2890 REM EndIf
2900 GOTO 2430:REM E
2910 REM Lbl H
2920 GOSUB 3470:REM Help
2930 GOTO 1120:REM C
2940 REM Lbl A
2950 GOSUB 3540:REM About
2960 GOTO 1120:REM C
2970 REM Lbl Q
2980 GOSUB 3410:REM ClS
2990 GOTO 950
3000 REM Lbl ContMenu
3010 GOSUB 3240:REM MenuItem
3020 PRINT "Continue"
3030 REM Lbl Menu
3040 GOSUB 3240:REM MenuItem
3050 PRINT "Setup and Go"
3060 GOSUB 3240:REM MenuItem
3070 PRINT "Help"
3080 GOSUB 3240:REM MenuItem
3090 PRINT "About"
3100 GOSUB 3240:REM MenuItem
3110 PRINT "Exit"
3120 REM Lbl Input
3130 LET SR=4+ABS(L>0):GOSUB 300:PRINT "Choose 1-";SR$;": ";
3140 INPUT S
3150 IF 1>S OR 4+ABS(L>0)<S THEN GOTO 3120:REM Input
3160 LET S=S+ABS(L<=0)
3170 REM ON S GOTO K,E,H,A,Q
3180 ON S GOTO 1870,2430,2910,2940,2970
3230 STOP
3240 REM Sub MenuItem
3250 LET A2=A2+1
3260 LET SR=A2:GOSUB 300:PRINT SR$;" ";
3270 RETURN
3280 REM Sub Sign
3290 IF 1=C OR 2=C THEN PRINT "+";:RETURN
3300 IF 3=C OR 4=C THEN PRINT "-";:RETURN
3310 IF 5=C THEN PRINT "*";:RETURN
3320 IF 6=C THEN PRINT "/";
3340 RETURN
3350 REM Sub 10^A2, A2>0
3360 LET R=1
3370 FOR I=1 TO A2
3380 LET R=R*10
3390 NEXT I
3400 RETURN
3402 REM Delay
3405 LET D=D/100
3406 SD=D:GOSUB 450
3408 RETURN
3410 REM Sub ClS
3420 FOR T1=1 TO 24
3430 PRINT
3440 NEXT T1
3450 PRINT "Aritm"
3460 RETURN
3470 REM Sub Help
3480 GOSUB 3410:REM ClS
3490 PRINT "Help"
3500 PRINT "You can mix problems anyway you like."
3510 PRINT "More help on <http://aritm.orbin.se>."
3520 LET D=5000:GOSUB 3402:REM Delay
3530 RETURN
3540 REM Sub About
3550 GOSUB 3410:REM ClS
3560 PRINT "About"
3570 PRINT "Aritm 0.3 (C) 1992-2022 by"
3575 PRINT "Mikael O. Bonnier, Lund, Sweden."
3580 PRINT "Absolutely no warranty."
3585 PRINT "FOSS, see license GPLv3+."
3590 LET D=5000:GOSUB 3402:REM Delay
3600 RETURN
30000 REM You can mix problems anyway you like.
30010 REM More help on aritm.orbin.se
30020 REM
30030 REM Aritm 0.3 (C) 1992-2022 by
30040 REM Mikael O. Bonnier, Lund, Sweden.
30050 REM Absolutely no warranty.
30060 REM FOSS, see license GPLv3+.
30070 REM
30080 REM github.com/mobluse/aritmjs

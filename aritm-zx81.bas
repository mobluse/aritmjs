10 REM ARITM V0.3.3 FOR ZX81 BASIC IS FOSS.
20 REM (C) 1992-2021 BY MIKAEL O. BONNIER, LUND, SWEDEN.
30 REM E-MAIL: <MIKAEL.BONNIER(A)GMAIL.COM>.
40 REM ABSOLUTELY NO WARRANTY.
50 REM LICENSE GPLV3+, SEE 
60 REM <HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML>.
70 REM MORE PROGRAMS AT 
80 REM <HTTP://WWW.DF.LTH.SE.ORBIN.SE/*MIKAELB/BASIC/>. * IS TILDE.
90 REM DOCUMENTATION:
100 REM 76543210, 7:TYPE, 6-4:OP1, 3-2:OP2, 1-0:/TODO.
110 REM PROGRAM:
120 GOTO 200
130 REM SUB MOD
140 LET MD=INT(.5+(X/Y-INT(X/Y))*Y)
150 RETURN
160 REM SUB DIV
170 LET DV=INT(.5+X/Y)
180 RETURN
200 RAND
210 LET R=RND
220 LET L=0
230 LET M=0
240 CLS
250 DIM A(590)
270 REM LBL C
280 GOSUB 4440
290 REM CLS
300 LET A=0
310 IF (L>0)*M THEN GOTO 3770
320 REM CONTMENU
330 IF 0=M THEN LET M=10
340 GOTO 3820
350 REM MENU
370 REM LBL S
380 GOSUB 4440
390 REM CLS
395 SCROLL
400 PRINT "GENERATING"
405 SCROLL
410 PRINT "PROBLEMS..."
415 SCROLL
420 LET U=1
430 REM DIM A(N)
440 REM LBL ADD1
450 LET X=M
460 LET Y=10
470 GOSUB 160
475 REM DIV
480 LET X=DV
490 GOSUB 130
495 REM MOD
500 IF 0=MD THEN GOTO 590
510 REM ADD2
520 FOR I=0 TO 9
530 FOR J=0 TO 9
540 LET A(U)=10000000+I*10000+J*100+1
550 LET U=U+1
560 NEXT J
570 NEXT I
590 REM LBL ADD2
600 LET X=M
610 LET Y=100
620 GOSUB 160
625 REM DIV
630 LET X=DV
640 LET Y=10
650 GOSUB 130
655 REM MOD
660 IF 0=MD THEN GOTO 750
670 REM SUB1
680 FOR I=0 TO 9
690 FOR J=0 TO 9
700 LET T=10*(INT(8*RND)+1)
710 LET A(U)=20000000+(T+I)*10000+J*100+1
720 LET U=U+1
730 NEXT J
740 NEXT I
750 REM LBL SUB1
770 LET X=M
780 LET Y=1000
790 GOSUB 160
795 REM DIV
800 LET X=DV
810 LET Y=10
820 GOSUB 130
825 REM MOD
830 IF 0=MD THEN GOTO 910
840 REM SUB2
850 FOR I=0 TO 9
860 FOR J=I TO 9+I
870 LET A(U)=30000000+J*10000+I*100+1
880 LET U=U+1
890 NEXT J
900 NEXT I
910 REM LBL SUB2
930 LET X=M
940 LET Y=10000
950 GOSUB 160
955 REM DIV
960 LET X=DV
970 LET Y=10
980 GOSUB 130
985 REM MOD
990 IF 0=MD THEN GOTO 1080
1000 REM MUL
1010 FOR I=0 TO 9
1020 FOR J=I TO 9+I
1030 LET T=10*(INT(9*RND)+1)
1040 LET A(U)=40000000+(T+J)*10000+I*100+1
1050 LET U=U+1
1060 NEXT J
1070 NEXT I
1080 REM LBL MUL
1100 LET X=M
1110 LET Y=100000
1120 GOSUB 160
1125 REM DIV
1130 LET X=DV
1140 LET Y=10
1150 GOSUB 130
1155 REM MOD
1160 IF 0=MD THEN GOTO 1240
1170 REM DIV
1180 FOR I=0 TO 9
1190 FOR J=0 TO 9
1200 LET A(U)=50000000+I*10000+J*100+1
1210 LET U=U+1
1220 NEXT J
1230 NEXT I
1240 REM LBL DIV
1260 LET X=M
1270 LET Y=1000000
1280 GOSUB 160
1285 REM DIV
1290 LET X=DV
1300 LET Y=10
1310 GOSUB 130
1315 REM MOD
1320 IF 0=MD THEN GOTO 1410
1330 REM ENDIF
1340 FOR I=0 TO 9
1350 FOR J=1 TO 9
1360 LET T=I*J+INT(J*RND)
1370 LET A(U)=60000000+T*10000+J*100+1
1380 LET U=U+1
1390 NEXT J
1400 NEXT I
1410 REM LBL ENDIF
1430 LET U=U-1
1440 LET L=U
1450 REM LBL U
1470 PRINT "SHUFFLING..."
1475 SCROLL
1480 FOR I=U TO 2 STEP -1
1490 LET J=INT(I*RND)+1
1500 LET T=A(I)
1510 LET A(I)=A(J)
1520 LET A(J)=T
1530 NEXT I
1540 LET K=1
1550 REM LBL K
1570 GOSUB 4440
1580 REM CLS
1590 PRINT L;
1600 PRINT " PROBLEMS LEFT. -1 ESC"
1605 SCROLL
1610 LET T=A(K)
1620 LET X=T
1630 LET Y=10000000
1640 GOSUB 160
1645 REM DIV
1650 LET C=DV
1660 IF 6=C THEN PRINT "INTEGER PART OF ";
1670 LET X=T
1680 LET Y=10000
1690 GOSUB 160
1695 REM DIV
1700 LET X=DV
1710 LET Y=1000
1720 GOSUB 130
1725 REM MOD
1730 LET I=MD
1740 PRINT I;
1750 GOSUB 4160
1760 REM SIGN
1770 LET X=T
1780 LET Y=100
1790 GOSUB 160
1795 REM DIV
1800 LET X=DV
1810 LET Y=100
1820 GOSUB 130
1825 REM MOD
1830 LET J=MD
1840 PRINT J;
1850 PRINT " = ";
1860 INPUT A$
1870 LET A=VAL A$
1880 PRINT A$
1885 SCROLL
1890 IF -1=A OR ".1"=A$ THEN GOTO 270
1900 REM C
1910 IF (1=C)+(2=C) THEN LET R=I+J
1940 IF (3=C)+(4=C) THEN LET R=I-J
1970 IF 5=C THEN LET R=I*J
2000 IF 6=C THEN LET R=INT(I/J)
2010 REM LBL ENDIF
2030 IF R<>A THEN GOTO 2210
2040 REM WRONG
2050 PRINT "RIGHT. "
2055 SCROLL
2060 LET X=T
2070 LET Y=100
2080 GOSUB 130
2085 REM MOD
2090 IF 0>=MD THEN GOTO 2130
2100 REM ENDIF
2110 LET L=L-1
2120 LET A(K)=T-1
2130 REM LBL ENDIF
2150 LET K=K+1
2160 IF NOT 0<L THEN GOTO 2185
2162 REM ENDIF 
2165 LET D=500
2170 GOSUB 4380
2180 REM DELAY
2185 REM LBL ENDIF
2190 GOTO 2460
2200 REM ENDIF 2
2210 REM LBL WRONG
2230 PRINT "WRONG. ";
2240 PRINT I;
2250 GOSUB 4160
2260 REM SIGN
2270 PRINT J;
2280 PRINT " IS ";
2290 PRINT R;
2300 PRINT "."
2305 SCROLL
2310 LET X=T
2320 LET Y=100
2330 GOSUB 130
2335 REM MOD
2340 IF 99<=MD THEN GOTO 2380
2350 REM ENDIF
2360 LET L=L+1
2370 LET A(K)=T+1
2380 REM LBL ENDIF
2400 LET K=K+1
2410 GOSUB 4770
2420 REM SOUND
2430 LET D=1000
2440 GOSUB 4380
2450 REM DELAY
2460 REM LBL ENDIF 2
2480 IF K<=U THEN GOTO 1550
2490 REM K
2500 IF 0>=L THEN GOTO 2690
2510 REM W
2520 PRINT "CHECKING..."
2525 SCROLL
2530 LET N=1
2540 FOR K=1 TO U
2550 LET T=A(K)
2560 LET X=T
2570 LET Y=100
2580 GOSUB 130
2585 REM MOD
2590 IF 0=MD THEN GOTO 2630
2600 REM ENDIF
2610 LET A(N)=T
2620 LET N=N+1
2630 REM LBL ENDIF
2650 NEXT K
2660 LET U=N-1
2670 GOTO 1450
2680 REM U
2690 REM LBL W
2710 PRINT "GOOD.   WELL DONE."
2715 SCROLL
2720 LET D=5000
2730 GOSUB 4380
2740 REM DELAY
2750 GOTO 270
2760 REM C
2770 REM LBL E
2790 GOSUB 4440
2800 REM CLS
2810 LET A=0
2820 LET N=0
2830 LET T=M
2840 GOSUB 3060
2850 REM SUB
2860 PRINT "ADDITION 1"
2870 GOSUB 3060
2880 REM SUB
2890 PRINT "ADDITION 2"
2900 GOSUB 3060
2910 REM SUB
2920 PRINT "SUBTRACTION 1"
2930 GOSUB 3060
2940 REM SUB
2950 PRINT "SUBTRACTION 2"
2960 GOSUB 3060
2970 REM SUB
2980 PRINT "MULTIPLICATION"
2990 GOSUB 3060
3000 REM SUB
3010 PRINT "DIVISION \ : -1 ESC"
3015 SCROLL
3020 PRINT "0 OK AND GO ";
3030 GOTO 3290
3040 REM AFTER SUB
3060 REM SUB
3065 SCROLL
3070 LET A=A+1
3080 LET X=T
3090 LET Y=10
3100 GOSUB 160
3105 REM DIV
3110 LET T=DV
3120 PRINT A;
3130 LET X=T
3140 LET Y=10
3150 GOSUB 130
3155 REM MOD
3160 IF 0=MD THEN GOTO 3220
3170 REM ELSE
3180 PRINT "*";
3190 LET N=N+100-10*(6=A)
3200 GOTO 3250
3210 REM ENDIF
3220 REM LBL ELSE
3240 PRINT " ";
3250 REM LBL ENDIF
3270 RETURN
3280 REM LBL AFTER SUB
3300 PRINT N
3305 SCROLL
3310 REM LBL INPUT
3330 PRINT "TOGGLE ITEM 1-6, OR CHOOSE 0"
3332 SCROLL
3334 PRINT "OR -1: ";
3340 INPUT A$
3350 LET A=VAL A$
3360 PRINT A$
3365 SCROLL
3370 IF (-1>A)+(6<A)+(0=A)*(0=N) THEN GOTO 3310
3380 REM INPUT
3390 IF 0=A THEN GOTO 370
3400 REM S
3410 IF -1=A OR ".1"=A$ THEN GOTO 270
3420 REM C
3430 GOSUB 4310
3440 REM 10**A
3450 LET X=M
3460 LET Y=R
3470 GOSUB 160
3475 REM DIV
3480 LET X=DV
3490 LET Y=10
3500 GOSUB 130
3505 REM MOD
3510 IF 0=MD THEN GOTO 3560
3520 REM ELSE
3530 LET M=M-R
3540 GOTO 3590
3550 REM ENDIF
3560 REM LBL ELSE
3580 LET M=M+R
3590 REM LBL ENDIF
3610 GOTO 2770
3620 REM E
3630 REM LBL H
3640 GOSUB 4520
3650 REM HELP
3660 GOTO 270
3670 REM C
3680 REM LBL A
3690 GOSUB 4630
3700 REM ABOUT
3710 GOTO 270
3720 REM C
3730 REM LBL Q
3740 GOSUB 4440
3750 REM CLS
3760 STOP
3770 REM LBL CONTMENU
3790 GOSUB 4110
3800 REM MENUITEM
3810 PRINT "CONTINUE"
3820 REM LBL MENU
3840 GOSUB 4110
3850 REM MENUITEM
3860 PRINT "SETUP AND GO"
3870 GOSUB 4110
3880 REM MENUITEM
3890 PRINT "HELP"
3900 GOSUB 4110
3910 REM MENUITEM
3920 PRINT "ABOUT"
3930 GOSUB 4110
3940 REM MENUITEM
3950 PRINT "EXIT"
3955 SCROLL
3960 REM LBL INPUT
3980 PRINT "CHOOSE 1-";
3990 PRINT 4+(L>0);
4000 PRINT ": ";
4010 INPUT A$
4020 LET S=VAL A$
4030 PRINT A$
4035 SCROLL
4040 IF (1>S)+(4+(L>0)<S) THEN GOTO 3960
4050 REM INPUT
4060 LET S=S+(L<=0)
4070 REM ON S GOTO K,E,H,A,Q
4080 GOTO (S=1)*1560+(S=2)*2780+(S=3)*3630+(S=4)*3680+(S=5)*3730
4090 STOP
4110 REM SUB MENUITEM
4115 SCROLL
4120 LET A=A+1
4130 PRINT A;
4140 PRINT " ";
4150 RETURN
4160 REM SUB SIGN
4180 IF (1=C)+(2=C) THEN PRINT "+";
4210 IF (3=C)+(4=C) THEN PRINT "-";
4240 IF 5=C THEN PRINT "*";
4270 IF 6=C THEN PRINT "/";
4280 REM LBL ENDIF
4300 RETURN
4310 REM SUB 10**A, A>0
4330 LET R=1
4340 FOR I=1 TO A
4350 LET R=R*10
4360 NEXT I
4370 RETURN
4380 REM SUB DELAY
4400 REM LET T1=TIME
4410 LET D=50*D/1000
4420 PAUSE D
4430 RETURN
4440 REM SUB CLS
4460 FOR T=1 TO 20
4470 PRINT
4480 SCROLL
4490 NEXT T
4500 PRINT "ARITM"
4505 SCROLL
4510 RETURN
4520 REM SUB HELP
4540 GOSUB 4440
4550 REM CLS
4560 PRINT "HELP"
4565 SCROLL
4570 PRINT "YOU CAN MIX PROBLEMS ANYWAY YOU LIKE."
4575 SCROLL
4580 PRINT "MORE HELP ON <HTTP://ARITM.ORBIN.SE/>."
4585 SCROLL
4590 LET D=5000
4600 GOSUB 4380
4610 REM DELAY
4620 RETURN
4630 REM SUB ABOUT
4650 GOSUB 4440
4660 REM CLS
4670 PRINT "ABOUT"
4675 SCROLL
4680 PRINT "ARITM 0.3 (C) 1992-2019 BY" 
4685 SCROLL
4690 PRINT "MIKAEL O. BONNIER, LUND, SWEDEN."
4695 SCROLL
4700 PRINT "ABSOLUTELY NO WARRANTY."
4705 SCROLL
4710 PRINT "FOSS, SEE LICENSE GPLV3+."
4715 SCROLL
4720 LET D=5000
4730 GOSUB 4380
4740 REM DELAY
4750 RETURN
4770 REM SUB SOUND 
4780 PAUSE 5
4790 RETURN

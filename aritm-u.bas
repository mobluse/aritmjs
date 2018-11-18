1000 Rem Aritm v0.3-beta for uBasic in 4tH is FOSS.
1010 Rem
1020 Rem (C) 1992-2014 by Mikael O. Bonnier, Lund, Sweden.
1030 Rem E-mail: <mikael.bonnier@gmail.com>.
1040 Rem Absolutely no warranty.
1050 Rem License GPLv3+, see 
1060 Rem <http://www.gnu.org/licenses/gpl.html>.
1070 Rem More programs at 
1080 Rem <http://www.df.lth.se.orbin.se/~mikaelb/basic/>.
1090 Rem Documentation:
1100 Rem 876543210, 8:Type, 7-5:Op1, 4-3:Op2, 2:Res'd, 1-0:#Todo.
1110 Rem Program:
1120 Rem Lbl C
1130 GoSub 3410:Rem ClS
1140 Let A=0
1150 If (L>0)*M Then Goto 3000:Rem ContMenu
1160 If 0=M Then Let M=10
1170 Goto 3030:Rem Menu
1180 Rem Lbl S
1190 GoSub 3410:Rem ClS
1200 Print "Generating"
1210 Print "Problems..."
1220 Let U=1
1230 Let @(N)=0
1240 Rem Lbl Add1
1250 If 0=M/10%10 Then Goto 1320:Rem Add2
1260 For I=0 To 9
1270 For J=0 To 9
1280 Let @(U)=100000000+I*100000+J*1000+1
1290 Let U=U+1
1300 Next J
1310 Next I
1320 Rem Lbl Add2
1330 If 0=M/100%10 Then Goto 1410:Rem Sub1
1340 For I=0 To 9
1350 For J=0 To 9
1360 Let T=10*(rnd(8)+1)
1370 Let @(U)=200000000+(T+I)*100000+J*1000+1
1380 Let U=U+1
1390 Next J
1400 Next I
1410 Rem Lbl Sub1
1420 If 0=M/1000%10 Then Goto 1490:Rem Sub2
1430 For I=0 To 9
1440 For J=I To 9+I
1450 Let @(U)=300000000+J*100000+I*1000+1
1460 Let U=U+1
1470 Next J
1480 Next I
1490 Rem Lbl Sub2
1500 If 0=M/10000%10 Then Goto 1580:Rem Mul
1510 For I=0 To 9
1520 For J=I To 9+I
1530 Let T=10*(rnd(9)+1)
1540 Let @(U)=400000000+(T+J)*100000+I*1000+1
1550 Let U=U+1
1560 Next J
1570 Next I
1580 Rem Lbl Mul
1590 If 0=M/100000%10 Then Goto 1660:Rem Div
1600 For I=0 To 9
1610 For J=0 To 9
1620 Let @(U)=500000000+I*100000+J*1000+1
1630 Let U=U+1
1640 Next J
1650 Next I
1660 Rem Lbl Div
1670 If 0=M/1000000%10 Then Goto 1750:Rem EndIf
1680 For I=0 To 9
1690 For J=1 To 9
1700 Let T=I*J+rnd(J)
1710 Let @(U)=600000000+T*100000+J*1000+1
1720 Let U=U+1
1730 Next J
1740 Next I
1750 Rem Lbl EndIf
1760 Let U=U-1
1770 Let L=U
1780 Rem Lbl U
1790 Print "Shuffling..."
1800 For I=U To 2 Step -1
1810 Let J=rnd(I)+1
1820 Let T=@(I)
1830 Let @(I)=@(J)
1840 Let @(J)=T
1850 Next I
1860 Let K=1
1870 Rem Lbl K
1880 GoSub 3410:Rem ClS
1890 Print L;" problems left. -1 Esc"
1900 Let T=@(K)
1910 Let C=T/100000000
1920 If 6=C Then Print "Integer part of ";
1930 Let I=T/100000%1000
1940 Print I;
1950 GoSub 3280:Rem Sign
1960 Let J=T/1000%100
1970 Print J;
1980 Input " = ";A
1990 If -1=A Then Goto 1120:Rem C 
2000 If (1=C)+(2=C) Then Let R=I+J:Goto 2040:Rem EndIf
2010 If (3=C)+(4=C) Then Let R=I-J:Goto 2040:Rem EndIf
2020 If 5=C Then Let R=I*J:Goto 2040:Rem EndIf
2030 If 6=C Then Let R=I/J
2040 Rem Lbl EndIf
2050 If R#A Then GoTo 2140:Rem Wrong
2060 Print "Right! "
2070 If 1>T%100 Then Goto 2100:Rem EndIf
2080 Let L=L-1
2090 Let @(K)=T-1
2100 Rem Lbl EndIf
2110 Let K=K+1
2120 If 0<L Then Let D=2000:GoSub 3610
2130 Goto 2250:Rem End If 2
2140 Rem Lbl Wrong
2150 Print "Wrong. ";
2160 Print I;
2170 GoSub 3280:Rem Sign
2180 Print J;" is ";R;"."
2190 If 98<T%100 Then Goto 2220:Rem EndIf
2200 Let L=L+1
2210 Let @(K)=T+1
2220 Rem Lbl End If
2230 Let K=K+1
2240 Let D=3000:GoSub 3610
2250 Rem Lbl End If 2
2260 If K<U+1 GoTo 1870:Rem K
2270 If 1>L GoTo 2390:Rem W
2280 Print "Checking..."
2290 Let N=1
2300 For K=1 To U
2310 Let T=@(K)
2320 If 0=T%100 Then Goto 2350:Rem EndIf
2330 Let @(N)=T
2340 Let N=N+1
2350 Rem EndIf
2360 Next K
2370 Let U=N-1
2380 Goto 1780:Rem U
2390 Rem Lbl W
2400 Print "Good!!! Well done!"
2410 Let D=5000:GoSub 3610
2420 Goto 1120:Rem C
2430 Rem Lbl E
2440 GoSub 3410:Rem ClS
2450 Let A=0
2460 Let N=0
2470 Let T=M
2480 GoSub 2640:Rem Sub
2490 Print "Addition 1"
2500 GoSub 2640:Rem Sub
2510 Print "Addition 2"
2520 GoSub 2640:Rem Sub
2530 Print "Subtraction 1"
2540 GoSub 2640:Rem Sub
2550 Print "Subtraction 2"
2560 GoSub 2640:Rem Sub
2570 Print "Multiplication"
2580 GoSub 2640:Rem Sub
2590 Print "Division | -1 Esc"
2600 Print "0 OK and Go ";
2610 Goto 2760:Rem After Sub
2640 Rem Sub
2650 Let A=A+1
2660 Let T=T/10
2670 Print A;
2680 If 0=T%10 Then Goto 2720:Rem Else
2690 Print "*";
2700 Let N=N+100-10*(6=A)
2710 Goto 2740:Rem End If
2720 Rem Lbl Else
2730 Print " ";
2740 Rem Lbl End If
2750 Return
2760 Rem Lbl After Sub
2770 Print N
2780 Rem Lbl Input
2790 Input "Toggle item 1-6, or choose 0 or -1: ";A
2800 If (-1>A)+(6<A)+(0=A)*(0=N) Then Goto 2780:Rem Input
2810 If 0=A Then Goto 1180:Rem S
2820 If -1=A Then Goto 1120:Rem C
2830 GoSub 3350:Rem 10^A
2840 If 0=M/R%10 Then Goto 2870:Rem Else
2850 Let M=M-R
2860 Goto 2890:Rem EndIf
2870 Rem Lbl Else
2880 Let M=M+R
2890 Rem EndIf
2900 Goto 2430:Rem E
2910 Rem Lbl H
2920 GoSub 3470:Rem Help
2930 Goto 1120:Rem C
2940 Rem Lbl A
2950 GoSub 3540:Rem About
2960 Goto 1120:Rem C
2970 Rem Lbl Q
2980 GoSub 3410:Rem ClS
2990 Stop
3000 Rem Lbl ContMenu
3010 GoSub 3240:Rem MenuItem
3020 Print "Continue"
3030 Rem Lbl Menu
3040 GoSub 3240:Rem MenuItem
3050 Print "Setup and Go"
3060 GoSub 3240:Rem MenuItem
3070 Print "Help"
3080 GoSub 3240:Rem MenuItem
3090 Print "About"
3100 GoSub 3240:Rem MenuItem
3110 Print "Exit"
3120 Rem Lbl Input
3130 Print "Choose 1-";4+(L>0);
3140 Input ": ";S
3150 If (1>S)+(4+(L>0)<S) Then Goto 3120:Rem Input
3160 Let S=S+(L<1)
3170 Rem On S Goto K,E,H,A,Q 
3180 If 1=S Then Goto 1870:Rem K
3190 If 2=S Then Goto 2430:Rem E
3200 If 3=S Then Goto 2910:Rem H
3210 If 4=S Then Goto 2940:Rem A
3220 If 5=S Then Goto 2970:Rem Q 
3230 Stop
3240 Rem Sub MenuItem
3250 Let A=A+1
3260 Print A;" ";
3270 Return
3280 Rem Sub Sign
3290 If (1=C)+(2=C) Then Print "+";:Goto 3330:Rem EndIf
3300 If (3=C)+(4=C) Then Print "-";:Goto 3330:Rem EndIf
3310 If 5=C Then Print "*";:Goto 3330:Rem EndIf
3320 If 6=C Then Print "/";
3330 Rem Lbl EndIf
3340 Return
3350 Rem Sub 10^A, A>0
3360 Let R=1
3370 For I=1 To A
3380 Let R=R*10
3390 Next I
3400 Return
3410 Rem Sub ClS
3420 For T=1 To 24
3430 Print
3440 Next T
3450 Print "Aritm"
3460 Return
3470 Rem Sub Help
3480 GoSub 3410:Rem ClS
3490 Print "Help"
3500 Print "You can mix problems anyway you like."
3510 Print "More help on <http://aritm.orbin.se/>."
3520 Let D=5000:GoSub 3610
3530 Return
3540 Rem Sub About
3550 GoSub 3410:Rem ClS
3560 Print "About"
3570 Print "Aritm 0.3 (C) 1992-2013 by" 
3575 Print "Mikael O. Bonnier, Lund, Sweden."
3580 Print "Absolutely no warranty." 
3585 Print "FOSS, see license GPLv3+."
3590 Let D=5000:GoSub 3610
3600 Return
3610 Rem Sub Delay
3620 Let Z=time()
3630 Let D=D/1000
3640 If time()-Z<D Then Goto 3640
3650 Return

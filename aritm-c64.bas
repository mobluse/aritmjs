1000 rem aritm v0.3.2 for c64 basic 2.0 is foss.
1020 rem (c) 1992-2018 by mikael o. bonnier, lund, sweden.
1030 rem e-mail: <mikael.bonnier@gmail.com>.
1040 rem absolutely no warranty.
1050 rem license gplv3+, see
1060 rem <http://www.gnu.org/licenses/gpl.html>.
1070 rem more programs at
1080 rem <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
1090 rem documentation:
1100 rem 876543210, 8:type, 7-5:op1, 4-3:op2, 2:res'd, 1-0:#todo.
1110 rem program:
1112 goto 1115
1113 mod%=int((x/y-int(x/y))*y+.5):return
1114 div=int(x/y+.5):return
1115 let r=rnd(-time):let r=rnd(0)
1116 open 1,0:print chr$(142);chr$(158):poke 53281,0:poke 53280,11
1117 dim a(590)
1120 rem lbl c
1130 gosub 3410:rem cls
1140 let a%=0
1150 if (l%>0)*m then goto 3000:rem contmenu
1160 if 0=m then let m=10
1170 goto 3030:rem menu
1180 rem lbl s
1190 gosub 3410:rem cls
1200 print "generating"
1210 print "problems..."
1220 let u%=1
1230 rem dim a(n%)
1240 rem lbl add1
1250 x=m:y=10:gosub 1114:x=div:gosub 1113
1255 if 0=mod% then goto 1320:rem add2
1260 for i=0 to 9
1270 for j=0 to 9
1280 let a(u%)=100000000+i*100000+j*1000+1
1290 let u%=u%+1
1300 next j
1310 next i
1320 rem lbl add2
1330 x=m:y=100:gosub 1114:x=div:y=10:gosub 1113
1335 if 0=mod% then goto 1410:rem sub1
1340 for i=0 to 9
1350 for j=0 to 9
1360 let t%=10*(int(8*rnd(1))+1)
1370 let a(u%)=200000000+(t%+i)*100000+j*1000+1
1380 let u%=u%+1
1390 next j
1400 next i
1410 rem lbl sub1
1420 x=m:y=1000:gosub 1114:x=div:y=10:gosub 1113
1425 if 0=mod% then goto 1490:rem sub2
1430 for i=0 to 9
1440 for j=i to 9+i
1450 let a(u%)=300000000+j*100000+i*1000+1
1460 let u%=u%+1
1470 next j
1480 next i
1490 rem lbl sub2
1500 x=m:y=10000:gosub 1114:x=div:y=10:gosub 1113
1505 if 0=mod% then goto 1580:rem mul
1510 for i=0 to 9
1520 for j=i to 9+i
1530 let t%=10*(int(9*rnd(1))+1)
1540 let a(u%)=400000000+(t%+j)*100000+i*1000+1
1550 let u%=u%+1
1560 next j
1570 next i
1580 rem lbl mul
1590 x=m:y=100000:gosub 1114:x=div:y=10:gosub 1113
1595 if 0=mod% then goto 1660:rem div
1600 for i=0 to 9
1610 for j=0 to 9
1620 let a(u%)=500000000+i*100000+j*1000+1
1630 let u%=u%+1
1640 next j
1650 next i
1660 rem lbl div
1670 x=m:y=1000000:gosub 1114:x=div:y=10:gosub 1113
1675 if 0=mod% then goto 1750:rem endif
1680 for i=0 to 9
1690 for j=1 to 9
1700 let t%=i*j+int(j*rnd(1))
1710 let a(u%)=600000000+t%*100000+j*1000+1
1720 let u%=u%+1
1730 next j
1740 next i
1750 rem lbl endif
1760 let u%=u%-1
1770 let l%=u%
1780 rem lbl u
1790 print "shuffling..."
1800 for i=u% to 2 step -1
1810 let j%=int(i*rnd(1))+1
1820 let t=a(i)
1830 let a(i)=a(j%)
1840 let a(j%)=t
1850 next i
1860 let k%=1
1870 rem lbl k
1880 gosub 3410:rem cls
1890 print mid$(str$(l%),2);" problems left. -1 esc"
1900 let t=a(k%)
1910 x=t:y=100000000:gosub 1114
1915 let c%=div
1920 if 6=c% then print "integer part of ";
1930 x=t:y=100000:gosub 1114:x=div:y=1000:gosub 1113
1935 let i%=mod%
1940 print mid$(str$(i%),2);
1950 gosub 3280:rem sign
1960 x=t:y=1000:gosub 1114:x=div:y=100:gosub 1113
1965 let j%=mod%
1970 print mid$(str$(j%),2);
1980 print " = ";:input#1,a$:a%=val(a$)
1985 print
1990 if -1=a% or ".1"=a$ then goto 1120:rem c
2000 if (1=c%)+(2=c%) then let r%=i%+j%:goto 2040:rem endif
2010 if (3=c%)+(4=c%) then let r%=i%-j%:goto 2040:rem endif
2020 if 5=c% then let r%=i%*j%:goto 2040:rem endif
2030 if 6=c% then let r%=int(i%/j%)
2040 rem lbl endif
2050 if r%<>a% then goto 2140:rem wrong
2060 print "right! ";
2070 x=t:y=100:gosub 1113
2075 if 0>=mod% then goto 2100:rem endif
2080 let l%=l%-1
2090 let a(k%)=t-1
2100 rem lbl endif
2110 let k%=k%+1
2120 if 0<l% then let d=500:gosub 3402:rem delay
2130 goto 2250:rem endif 2
2140 rem lbl wrong
2150 print "wrong.";
2160 print str$(i%);
2170 gosub 3280:rem sign
2180 print mid$(str$(j%),2);" is";str$(r%);"."
2190 x=t:y=100:gosub 1113
2195 if 99<=mod% then goto 2220:rem endif
2200 let l%=l%+1
2210 let a(k%)=t+1
2220 rem lbl endif
2230 let k%=k%+1
2235 gosub 3610:rem sound
2240 let d=1000:gosub 3402:rem delay
2250 rem lbl endif 2
2260 if k%<=u% goto 1870:rem k
2270 if 0>=l% goto 2390:rem w
2280 print "checking..."
2290 let n%=1
2300 for k=1 to u%
2310 let t=a(k)
2320 x=t:y=100:gosub 1113
2325 if 0=mod% then goto 2350:rem endif
2330 let a(n%)=t
2340 let n%=n%+1
2350 rem endif
2360 next k
2370 let u%=n%-1
2380 goto 1780:rem u
2390 rem lbl w
2400 print "good!!! well done!"
2410 let d=5000:gosub 3402:rem delay
2420 goto 1120:rem c
2430 rem lbl e
2440 gosub 3410:rem cls
2450 let a%=0
2460 let n%=0
2470 let t=m
2480 gosub 2640:rem sub
2490 print "addition 1"
2500 gosub 2640:rem sub
2510 print "addition 2"
2520 gosub 2640:rem sub
2530 print "subtraction 1"
2540 gosub 2640:rem sub
2550 print "subtraction 2"
2560 gosub 2640:rem sub
2570 print "multiplication"
2580 gosub 2640:rem sub
2590 print "division Y -1 esc"
2600 print "0 ok and go";
2610 goto 2760:rem after sub
2640 rem sub
2650 let a%=a%+1
2660 x=t:y=10:gosub 1114
2665 let t=div
2670 print mid$(str$(a%),2);
2680 x=t:y=10:gosub 1113
2685 if 0=mod% then goto 2720:rem else
2690 print "*";
2700 let n%=n%+100+10*(6=a%)
2710 goto 2740:rem endif
2720 rem lbl else
2730 print " ";
2740 rem lbl endif
2750 return
2760 rem lbl after sub
2770 print str$(n%)
2780 rem lbl input
2790 print "toggle item 1-6, or choose 0 or -1: ";:input#1,a$:a%=val(a$)
2795 print:rem c64 input# doesn't linefeed
2800 if (-1>a%)+(6<a%)+(0=a%)*(0=n%) then goto 2780:rem input
2810 if 0=a% then goto 1180:rem s
2820 if -1=a% or ".1"=a$ then goto 1120:rem c
2830 gosub 3350:rem 10^a%
2840 x=m:y=r:gosub 1114:x=div:y=10:gosub 1113
2845 if 0=mod% then goto 2870:rem else
2850 let m=m-r
2860 goto 2890:rem endif
2870 rem lbl else
2880 let m=m+r
2890 rem endif
2900 goto 2430:rem e
2910 rem lbl h
2920 gosub 3470:rem help
2930 goto 1120:rem c
2940 rem lbl a
2950 gosub 3540:rem about
2960 goto 1120:rem c
2970 rem lbl q
2980 gosub 3410:rem cls
2990 end
3000 rem lbl contmenu
3010 gosub 3240:rem menuitem
3020 print "continue"
3030 rem lbl menu
3040 gosub 3240:rem menuitem
3050 print "setup and go"
3060 gosub 3240:rem menuitem
3070 print "help"
3080 gosub 3240:rem menuitem
3090 print "about"
3100 gosub 3240:rem menuitem
3110 print "exit"
3120 rem lbl input
3130 print "choose 1-";mid$(str$(4-(l%>0)),2);": ";
3140 input#1,a$:s%=val(a$)
3145 print
3150 if (1>s%)+(4-(l%>0)<s%) then goto 3120:rem input
3160 let s%=s%-(l%<=0)
3170 rem on s goto k,e,h,a,q
3180 on s% goto 1870,2430,2910,2940,2970
3230 stop
3240 rem sub menuitem
3250 let a%=a%+1
3260 print mid$(str$(a%),2);" ";
3270 return
3280 rem sub sign
3290 if (1=c%)+(2=c%) then print "+";:goto 3330:rem endif
3300 if (3=c%)+(4=c%) then print "-";:goto 3330:rem endif
3310 if 5=c% then print "*";:goto 3330:rem endif
3320 if 6=c% then print "/";
3330 rem lbl endif
3340 return
3350 rem sub 10^a, a>0
3360 let r=1
3370 for i=1 to a%
3380 let r=r*10
3390 next i
3400 return
3402 rem delay
3404 let t1=time
3405 let d=60*d/1000
3406 if time-t1<d then goto 3406
3408 return
3410 rem sub cls
3420 for t=1 to 24
3430 print
3440 next t
3450 print "aritm"
3460 return
3470 rem sub help
3480 gosub 3410:rem cls
3490 print "help"
3500 print "you can mix problems anyway you like."
3510 print "more help on <http://aritm.orbin.se/>."
3520 let d=5000:gosub 3402:rem delay
3530 return
3540 rem sub about
3550 gosub 3410:rem cls
3560 print "about"
3570 print "aritm 0.3 (c) 1992-2018 by"
3575 print "mikael o. bonnier, lund, sweden."
3580 print "absolutely no warranty."
3585 print "foss, see license gplv3+."
3590 let d=5000:gosub 3402:rem delay
3600 return
3610 rem sub sound
3615 for x=54272 to 54296:poke x,0:next
3620 poke 54296,15
3630 poke 54277,190
3640 poke 54278,248
3650 poke 54273,17:poke 54272,37
3660 poke 54276,17
3670 for x=1 to 250:next
3680 poke 54276,16
3690 return

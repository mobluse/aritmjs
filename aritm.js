//usr/bin/js24 -s -w -e '
// Aritm v0.3 for JavaScript JS24 is FOSS.
// (C) 1992-2013 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>.
// Documentation:
// 876543210, 8:Type, 7-5:Op1, 4-3:Op2, 2:Res d, 1-0:#Todo.
// Program:
var r=0;
var c=0;
var t=0;
var n=0;
var l=0;
var iA=0;
var d=0.0;
var s=0;
var m=0;
function fnmodulus(x, y) { return x % y; }
function fndiv(x, y) { return Math.round(x/y) }
var a = new Array(591);
// Lbl C
C: for (;;) {
cls();
iA = 0;
if ((l>0)*m)
    contMenu();
if (0 == m)
    m=10;
menu();
switch (s) {
case 1:
    // K
    break;
case 2:
    // E
    try {
        setup();
    }
    catch(e) {
        print(e);
        continue C;
    }
    break;
case 3:
    // H
    help();
    continue C;
case 4:
    // A
    about();
    continue C;
case 5:
    // Q
    cls();
    break C;
}
} // C: for
// Lbl S
function start() {
cls();
print("Generating");
print("Problems...");
var u=1
// Lbl Add1
if (0 != fnmodulus(fndiv(m,10),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=0; j <= 9; ++j) {
            a[u]=100000000+i*100000+j*1000+1;
            ++u;
        }
    }
}
// Lbl Add2
else if (0 != fnmodulus(fndiv(m,100),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=0; j <= 9; ++j) {
            var t=10*(Math.floor(8*Math.random())+1);
            a[u]=200000000+(t+i)*100000+j*1000+1;
            ++u;
        }
    }
}
// Lbl Sub1
else if (0 != fnmodulus(fndiv(m,1000),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=i; j <= 9+i; ++j) {
            a[u]=300000000+j*100000+i*1000+1;
            ++u;
        }
    }
}
// Lbl Sub2
else if (0 != fnmodulus(fndiv(m,10000),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=i; j <= 9+i; ++j) {
            var t=10*(Math.floor(9*Math.random())+1);
            a[u]=400000000+(t+j)*100000+i*1000+1;
            ++u;
        }
    }
}
// Lbl Mul
else if (0 != fnmodulus(fndiv(m,100000),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=0; j <= 9; ++j) {
            a[u]=500000000+i*100000+j*1000+1;
            ++u;
        }
    }
}
// Lbl Div
else if (0 != fnmodulus(fndiv(m,1000000),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j=1; j <= 9; ++j) {
            t=i*j+Math.floor(j*Math.random());
            a[u]=600000000+t*100000+j*1000+1;
            ++u;
        }
    }
}
// EndIf
--u;
var l = u;
// Lbl U
print("Shuffling...")
for (var i = u; i >= 2; --i) {
    var j=Math.floor(i*Math.random())+1;
    var t=a[i];
    a[i]=a[j];
    a[j]=t;
}
var k=1;
// Lbl K
cls();
print(l+" problems left. -1 Esc");
var t=a[k];
c=fndiv(t,100000000);
if (6 == c)
    putstr("Integer part of ");
var i=fnmodulus(fndiv(t,100000),1000);
putstr(i);
sign();
var j=fnmodulus(fndiv(t,1000),100);
putstr(j);
putstr(" = ");
var iA=parseInt(readline(),10);
if (-1 == iA)
    throw "continue C";
switch (c) {
    case 1:
    case 2:
        r=i+j;
        break;
    case 3:
    case 4:
        r=i-j;
        break;
    case 5:
        r=i*j;
        break;
    case 6:
        r=i/j|0;
        break;
}
if (r == a) {
    putstr("Right! ");
    if (0 < fnmodulus(t, 100)) {
        --l;
        a[k]=t-1;
    }
    else {
        ++k;
        if (0 < l) {
            d = 500;
            delay();
        }
    }
}
else {
    putstr("Wrong. ");
    putstr(i);
    sign();
    print(j+" is "+r+".");
    if (99>fnmodulus(t, 100) {
        ++l;
        a[k]=t+1;
    }
    ++k;
    d=1000;
    delay();
}
if (k <= u) {
    goto K
}
if (0 >= l) {
    goto W
}
}

function setup() {
    for (;;) {
        cls();
        iA=0;
        n=0;
        t=m;
        sub();
        print("Addition 1");
        sub();
        print("Addition 2");
        sub();
        print("Subtraktion 1");
        sub();
        print("Subtraktion 2");
        sub();
        print("Multiplikation");
        sub();
        print("Division | -1 Esc");
        putstr("0 OK and Go ");
        print(n);
        // Input
        do {
            print("Toggle item 1-6, or choose 0 or -1: ");
            iA = parseInt(readline());
        } while ((-1>iA)+(6<iA)+(0==iA)*(0==n));
        if (0 == iA)
            start();
        if (-1 == iA)
            break;
        pow10();
        if (fnmodulus(fndiv(m, r), 10))
            m-=r;
        else
            m+=r;
    }
}
function sub() {
    ++iA;
    t=fndiv(t,10);
    putstr(iA);
    if (fnmodulus(t,10)) {
        putstr("*");
        n=n+100-10*(6==iA);
    }
    else {
        putstr(" ");
    }
}
function contMenu() {
    menuItem();
    print("Continue");
}
function menu() {
    menuItem();
    print("Setup and Go");
    menuItem();
    print("Help");
    menuItem();
    print("About");
    menuItem();
    print("Exit");
    do {
        print("Choose 1-" + (4+(l>0)));
        s=parseInt(readline());
    } while (s < 1 || s > 4+(l>0));
    s=s+(l<=0);
}

function menuItem() {
    ++iA;
    putstr(iA+" ");
}
function sign() {
    if (1 == c || 2 == c) {
        putstr("+");
        return;
    }
    if (3 == c || 4 == c) {
        putstr("-");
        return;
    }
    if (5 == c) {
        putstr("*");
        return;
    }
    if (6 == c) {
        putstr("/");
    }
}
function pow10() {
    r=Math.pow(10, iA);
}
function delay() {
    var t1 = new Date();
    while (new Date() - t1 < d);
}
function cls() {
    for (var t=0; t<24; ++t) {
        print();
    }
    print("Aritm");
}
function help() {
    cls()
    print("Help");
    print("You can mix problems anyway you like.");
    print("More help on <http://aritm.orbin.se/>.");
    d=5000; delay();
}
function about() {
    cls();
    print("About");
    print("Aritm 0.3 (C) 1992-2018 by");
    print("Mikael O. Bonnier, Lund, Sweden.");
    print("Absolutely no warranty.");
    print("FOSS, see license GPLv3+.");
    d=5000; delay();
}
//'

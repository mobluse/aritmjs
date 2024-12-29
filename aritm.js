//usr/bin/js102 -w -e '
// WAS: -s // also with js60
// Aritm v0.3 for JavaScript JS24 is FOSS.
// (C) 1992-2021 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>.
// Documentation:
// 76543210, 7:Type, 6-4:Op1, 3-2:Op2, 1-0:#Todo.
// Install js102 or js24 in Debian or Raspberry Pi OS:
// sudo apt install libmozjs-102-dev
// sudo apt install libmozjs-24-bin
// Program:
var c=0;
var t=0;
var n=0;
var d=0.0;
var s=0;
function fnmodulus(x, y) { return x % y; }
function fndiv(x, y) { return Math.round(x/y); }

start:
var r = Math.random();
var m = 0;
cls();
var a = new Array(591); // Uses indices 1-590.

C:
cls();
var iA = 0;
if ((l>0) && m) {
    goto contMenu;
}
if (0 == m) {
    m = 10;
}
goto menu;

S:
cls();
print("Generating");
print("Problems...");
var u = 1;
// a = new Array(n);

add1:
if (0 != fnmodulus(fndiv(m,10),10)) {
    for (var i = 0; i <= 9; ++i) {
        for (var j = 0; j <= 9; ++j) {
            a[u] = 10000000+i*10000+j*100+1;
            ++u;
        }
    }
}

add2:
if (0 != fnmodulus(fndiv(m,100),10)) {
    for (var i=0; i <= 9; ++i) {
        for (var j = 0; j <= 9; ++j) {
            var t = 10*(Math.floor(8*Math.random())+1);
            a[u] = 20000000+(t+i)*10000+j*100+1;
            ++u;
        }
    }
}

sub1:
if (0 != fnmodulus(fndiv(m,1000),10)) {
    for (var i = 0; i <= 9; ++i) {
        for (var j = i; j <= 9+i; ++j) {
            a[u] = 30000000+j*10000+i*100+1;
            ++u;
        }
    }
}

sub2:
if (0 != fnmodulus(fndiv(m,10000),10)) {
    for (var i = 0; i <= 9; ++i) {
        for (var j = i; j <= 9+i; ++j) {
            var t = 10*(Math.floor(9*Math.random())+1);
            a[u] = 40000000+(t+j)*10000+i*100+1;
            ++u;
        }
    }
}

mul:
if (0 != fnmodulus(fndiv(m,100000),10)) {
    for (var i = 0; i <= 9; ++i) {
        for (var j = 0; j <= 9; ++j) {
            a[u] = 50000000+i*10000+j*100+1;
            ++u;
        }
    }
}

div:
if (0 != fnmodulus(fndiv(m,1000000),10)) {
    for (var i = 0; i <= 9; ++i) {
        for (var j = 1; j <= 9; ++j) {
            t = i*j+Math.floor(j*Math.random());
            a[u] = 60000000+t*10000+j*100+1;
            ++u;
        }
    }
}

--u;
var l = u;

U:
print("Shuffling...")
for (var i = u; i >= 2; --i) {
    var j = Math.floor(i*Math.random())+1;
    var t = a[i];
    a[i] = a[j];
    a[j] = t;
}
var k=1;

K:
cls();
print(l+" problems left. -1 Esc");
var t=a[k];
c=fndiv(t, 10000000);
if (6 == c)
    putstr("Integer part of ");
}
var i = fnmodulus(fndiv(t, 10000), 1000);
putstr(i);
sign();
var j = fnmodulus(fndiv(t, 100), 100);
putstr(j);
putstr(" = ");
var ans = readline();
var iA = parseInt(ans, 10);
if (-1 == iA || '.1' == ans || ',1' == ans || '01' == ans) {
    goto C;
}
switch (c) {
case 1:
case 2:
    r = i+j;
    break;
case 3:
case 4:
    r = i-j;
    break;
case 5:
    r = i*j;
    break;
case 6:
    r = i/j|0;
    break;
}
if (r == a) {
    print("Right! ");
    if (0 < fnmodulus(t, 100)) {
        --l;
        a[k] = t-1;
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
    if (99>fnmodulus(t, 100)) {
        ++l;
        a[k]=t+1;
    }
    ++k;
    sound();
    d = 1000;
    delay();
}
if (k <= u) {
    goto K;
}
if (0 >= l) {
    goto W;
}
print("Checking...");
n = 1;
for (k = 1; k <= u; k++) {
    t = a[k];
    if (0 != fnmodulus(t, 100)) {
        a[n] = t;
        ++n;
    }
} // k
u = n - 1;
goto U;

W:
print("Good!!!  Well done!");
$d = 5000;
delay();
goto C;

E:
cls();
iA = 0;
n = 0;
t = m;
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
goto input;

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

input:
do {
    print("Toggle item 1-6, or choose 0 or -1: ");
    ans = readline();
    iA = parseInt(ans);
} while (-1 > iA || 6 < iA || 0 == iA && 0 == n);
if (0 == iA) {
    goto S;
}
if (-1 == iA || '.1' == ans || ',1' == ans || '01' == ans) {
    goto C;
}
pow10();
if (fnmodulus(fndiv(m, r), 10)) {
    m -= r;
}
else {
    m += r;
}
goto E;

contMenu:
menuItem();
print("Continue");

menu:
menuItem();
print("Setup and go");
menuItem();
print("Help");
menuItem();
print("About");
menuItem();
print("Exit");
do {
    print("Choose 1-" + (4+(l>0)) + ": ");
    s=parseInt(readline());
} while (s < 1 || s > 4+(l>0));
s = s + (l<=0);
// on s goto k,e,h,a,q
switch (s) {
case 1: goto K;
case 2: goto E;
case 3: goto H;
case 4: goto A;
case 5: goto Q;
}
quit(-1);

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
    for (var t=0; t<40; ++t) {
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
    print("Aritm 0.3 (C) 1992-2024 by");
    print("Mikael O. Bonnier, Lund, Sweden.");
    print("Absolutely no warranty.");
    print("FOSS, see license GPLv3+.");
    d=5000; delay();
}

function sound()
{
    putstr("\x07");
    d=100; delay();
}
//'

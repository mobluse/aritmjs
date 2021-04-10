#!/usr/bin/env php
<?php
// Aritm v0.3.3 for PHP 7.3 is FOSS.
// (c) 1992-2021 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
// Documentation:
// 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.
// Program:
goto start;

function mod()
{
    global $md, $x, $y;
    $md = floor(0.5 + ($x / $y - floor($x / $y)) * $y);
}

function idiv()
{
    global $dv, $x, $y;
    $dv = floor(0.5 + $x / $y);
}

start:
srand();
function rnd()
{
    return mt_rand() / (mt_getrandmax() + 1.0);
}
$r = rnd();
$l = 0;
$m = 0;
cls();
$aa = array_fill(1, 590, 0.0);

c:
cls();
$a = 0;
if ($l > 0 && $m) {
    goto contmenu;
}
if (0 == $m) {
    $m = 10;
}
goto menu;

s:
cls();
echo "Generating\n";
echo "Problems...\n";
$u = 1;
// $aa=array_fill(1, n, 0.0);

add1:
$x = $m;
$y = 10;
idiv();
$x = $dv;
mod();
if (0 == $md) {
    goto add2;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = 0; $j <= 9; $j++) {
        $aa[$u] = 10000000 + $i * 10000 + $j * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i

add2:
$x = $m;
$y = 100;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto sub1;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = 0; $j <= 9; $j++) {
        $t = 10 * (floor(8 * rnd()) + 1);
        $aa[$u] = 20000000 + ($t + $i) * 10000 + $j * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i

sub1:
$x = $m;
$y = 1000;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto sub2;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = $i; $j <= 9 + $i; $j++) {
        $aa[$u] = 30000000 + $j * 10000 + $i * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i

sub2:
$x = $m;
$y = 10000;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto mul;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = $i; $j <= 9 + $i; $j++) {
        $t = 10 * (floor(9 * rnd()) + 1);
        $aa[$u] = 40000000 + ($t + $j) * 10000 + $i * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i

mul:
$x = $m;
$y = 100000;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto div;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = 0; $j <= 9; $j++) {
        $aa[$u] = 50000000 + $i * 10000 + $j * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i

div:
$x = $m;
$y = 1000000;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto endif1;
}
for ($i = 0; $i <= 9; $i++) {
    for ($j = 1; $j <= 9; $j++) {
        $t = $i * $j + floor($j * rnd());
        $aa[$u] = 60000000 + $t * 10000 + $j * 100 + 1;
        $u = $u + 1;
    } // $j
} // $i
endif1:
$u = $u - 1;
$l = $u;

u:
print "Shuffling...\n";
for ($i = $u; $i >= 2; $i--) {
    $j = floor($i * rnd()) + 1;
    $t = $aa[$i];
    $aa[$i] = $aa[$j];
    $aa[$j] = $t;
} // $i
$k = 1;

k:
cls();
echo $l;
echo " problems left. -1 Esc\n";
$t = $aa[$k];
$x = $t;
$y = 10000000;
idiv();
$c = $dv;
if (6 == $c) {
    echo 'Integer part of ';
}
$x = $t;
$y = 10000;
idiv();
$x = $dv;
$y = 1000;
mod();
$i = $md;
echo $i;
sign();
$x = $t;
$y = 100;
idiv();
$x = $dv;
$y = 100;
mod();
$j = $md;
echo $j;
echo ' = ';
$ans = readline();
$a = (float) $ans;
// print $ans;
if (-1 == $a || '.1' == $ans) {
    goto c;
}
if (1 == $c || 2 == $c) {
    $r = $i + $j;
    goto endif2;
}
if (3 == $c || 4 == $c) {
    $r = $i - $j;
    goto endif2;
}
if (5 == $c) {
    $r = $i * $j;
    goto endif2;
}
if (6 == $c) {
    $r = floor($i / $j);
}
endif2:
if ($r != $a) {
    goto wrong;
}
echo "Right!\n";
$x = $t;
$y = 100;
mod();
if (0 >= $md) {
    goto endif3;
}
$l = $l - 1;
$aa[$k] = $t - 1;
endif3:
$k = $k + 1;
if (!(0 < $l)) {
    goto endif4;
}
$d = 500;
delay();
endif4:
goto endif5;

wrong:
print 'Wrong. ';
echo $i;
sign();
echo $j;
echo ' is ';
echo $r;
echo ".\n";
$x = $t;
$y = 100;
mod();
if (99 <= $md) {
    goto endif6;
}
$l = $l + 1;
$aa[$k] = $t + 1;
endif6:
$k = $k + 1;
sound();
$d = 1000;
delay();
endif5:
if ($k <= $u) {
    goto k;
}
if (0 >= $l) {
    goto w;
}
echo "Checking...\n";
$n = 1;
for ($k = 1; $k <= $u; $k++) {
    $t = $aa[$k];
    $x = $t;
    $y = 100;
    mod();
    if (0 == $md) {
        goto endif7;
    }
    $aa[$n] = $t;
    $n = $n + 1;
    endif7:
} // $k
$u = $n - 1;
goto u;

w:
print "Good!!!  Well done!\n";
$d = 5000;
delay();
goto c;

e:
cls();
$a = 0;
$n = 0;
$t = $m;
sub();
echo "Addition 1\n";
sub();
echo "Addition 2\n";
sub();
echo "Subtraction 1\n";
sub();
echo "Subtraction 2\n";
sub();
echo "Multiplication\n";
sub();
echo "Division | -1 Esc\n";
echo '0 OK and go ';
echo "$n\n";
goto input;

function sub()
{
    global $a, $x, $t, $y, $dv, $md, $n;
    $a = $a + 1;
    $x = $t;
    $y = 10;
    idiv();
    $t = $dv;
    echo $a;
    $x = $t;
    $y = 10;
    mod();
    if (0 == $md) {
        goto else0;
    }
    echo '*';
    $n = $n + 100 - 10 * (6 == $a);
    goto endif0;
    else0:
    print ' ';
    endif0:
}

input:
print 'Toggle item 1-6, or choose 0 or -1: ';
$ans = readline();
$a = (float) $ans;
// print $ans;
if (-1 > $a || 6 < $a || 0 == $a && 0 == $n) {
    goto input;
}
if (0 == $a) {
    goto s;
}
if (-1 == $a || '.1' == $ans) {
    goto c;
}
pow10();
$x = $m;
$y = $r;
idiv();
$x = $dv;
$y = 10;
mod();
if (0 == $md) {
    goto else1;
}
$m = $m - $r;
goto endif8;
else1:
$m = $m + $r;
endif8:
goto e;

h:
help();
goto c;

a:
about();
goto c;

q:
cls();
exit(0);

contmenu:
menuitem();
echo "Continue\n";

menu:
menuitem();
echo "Setup and go\n";
menuitem();
echo "Help\n";
menuitem();
echo "About\n";
menuitem();
echo "Exit\n";
input2:
print 'Choose 1-';
echo 4 + ($l > 0);
echo ': ';
$ans = readline();
$s = (int) $ans;
// print $ans;
if (1 > $s || 4 + ($l > 0) < $s) {
    goto input2;
}
$s = $s + ($l <= 0);
// on s goto k,e,h,a,q
switch ($s) {
case 1: goto k;
case 2: goto e;
case 3: goto h;
case 4: goto a;
case 5: goto q;
}
exit(1);

function menuitem()
{
    global $a;
    $a = $a + 1;
    echo $a;
    echo ' ';
}

function sign()
{
    global $c;
    if (1 == $c || 2 == $c) {
        echo '+';

        return;
    }
    if (3 == $c || 4 == $c) {
        echo '-';

        return;
    }
    if (5 == $c) {
        echo '*';

        return;
    }
    if (6 == $c) {
        echo '/';
    }
}

function pow10()
{
    global $r, $i, $a;
    $r = 1;
    for ($i = 1; $i <= $a; $i++) {
        $r = $r * 10;
    } // $i
}

function delay()
{
    global $d;
    $d = $d * 1000;
    usleep($d);
}

function cls()
{
    global $t;
    for ($t = 1; $t <= 40; $t++) {
        echo "\n";
    } // $t
    echo "Aritm\n";
}

function help()
{
    global $d;
    cls();
    echo "Help\n";
    echo "You can mix problems anyway you like.\n";
    echo "More help on <http://aritm.orbin.se/>.\n";
    $d = 5000;
    delay();
}

function about()
{
    global $d;
    cls();
    echo "About\n";
    echo "Aritm 0.3 (c) 1992-2019 by\n";
    echo "Mikael O. Bonnier, Lund, Sweden.\n";
    echo "Absolutely no warranty.\n";
    echo "FOSS, see license GPLv3+.\n";
    $d = 5000;
    delay();
}

function sound()
{
    fprintf(STDOUT, '%s', "\x07");
    usleep(100000);
}
?>

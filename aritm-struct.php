#!/usr/bin/env php
<?php
// Aritm v0.3.4 for PHP 8.2.29 is FOSS.
// (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
// Documentation:
// 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.

// Global variables
$md = 0.0;
$dv = 0.0;
$x = 0.0;
$y = 0.0;
$r = 0.0;
$l = 0;
$m = 0;
$aa = array();
$a = 0;
$u = 0;
$k = 0;
$t = 0;
$c = 0;
$i = 0;
$j = 0;
$ans = "";
$n = 0;
$d = 0;

function delay() {
    global $d;
#    usleep($d * 1000);
}

function mod() {
    global $md, $x, $y;
    $md = floor(0.5 + ($x / $y - floor($x / $y)) * $y);
}

function idiv() {
    global $dv, $x, $y;
    $dv = floor(0.5 + $x / $y);
}

function rnd() {
    return mt_rand() / (mt_getrandmax() + 1.0);
}

function cls() {
    global $t;
    for ($t = 1; $t <= 40; $t++) {
        echo "\n";
    }
    echo "Aritm\n";
}

function sound() {
    fprintf(STDOUT, '%s', "\x07");
    usleep(100000);
}

function sign() {
    global $c;
    switch ($c) {
        case 1:
        case 2:
            echo '+';
            break;
        case 3:
        case 4:
            echo '-';
            break;
        case 5:
            echo '*';
            break;
        case 6:
            echo '/';
            break;
    }
}

function pow10() {
    global $r, $i, $a;
    $r = 1;
    for ($i = 1; $i <= $a; $i++) {
        $r *= 10;
    }
}

function help() {
    cls();
    echo "Help\n";
    echo "You can mix problems anyway you like.\n";
    echo "More help on <http://aritm.orbin.se/>.\n";
    global $d;
    $d = 5000;
    delay();
}

function about() {
    cls();
    echo "About\n";
    echo "Aritm 0.3 (c) 1992-2025 by\n";
    echo "Mikael O. Bonnier, Lund, Sweden.\n";
    echo "Absolutely no warranty.\n";
    echo "FOSS, see license GPLv3+.\n";
    global $d;
    $d = 5000;
    delay();
}

function menuitem() {
    global $a;
    $a++;
    echo $a . ' ';
}

function generateProblems() {
    global $m, $md, $dv, $x, $y, $u, $aa, $l, $i, $j, $t;

    cls();
    echo "Generating\nProblems...\n";
    $u = 1;

    // Addition 1
    $x = $m;
    $y = 10;
    idiv();
    $x = $dv;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = 0; $j <= 9; $j++) {
                $aa[$u] = 10000000 + $i * 10000 + $j * 100 + 1;
                $u++;
            }
        }
    }

    // Addition 2
    $x = $m;
    $y = 100;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = 0; $j <= 9; $j++) {
                $t = 10 * (floor(8 * rnd()) + 1);
                $aa[$u] = 20000000 + ($t + $i) * 10000 + $j * 100 + 1;
                $u++;
            }
        }
    }

    // Subtraction 1
    $x = $m;
    $y = 1000;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = $i; $j <= 9 + $i; $j++) {
                $aa[$u] = 30000000 + $j * 10000 + $i * 100 + 1;
                $u++;
            }
        }
    }

    // Subtraction 2
    $x = $m;
    $y = 10000;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = $i; $j <= 9 + $i; $j++) {
                $t = 10 * (floor(9 * rnd()) + 1);
                $aa[$u] = 40000000 + ($t + $j) * 10000 + $i * 100 + 1;
                $u++;
            }
        }
    }

    // Multiplication
    $x = $m;
    $y = 100000;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = 0; $j <= 9; $j++) {
                $aa[$u] = 50000000 + $i * 10000 + $j * 100 + 1;
                $u++;
            }
        }
    }

    // Division
    $x = $m;
    $y = 1000000;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    if ($md != 0) {
        for ($i = 0; $i <= 9; $i++) {
            for ($j = 1; $j <= 9; $j++) {
                $t = $i * $j + floor($j * rnd());
                $aa[$u] = 60000000 + $t * 10000 + $j * 100 + 1;
                $u++;
            }
        }
    }

    $u--;
    $l = $u;
}

function shuffleProblems() {
    global $u, $aa, $i, $j, $t;

    echo "Shuffling...\n";
    for ($i = $u; $i >= 2; $i--) {
        $j = floor($i * rnd()) + 1;
        $t = $aa[$i];
        $aa[$i] = $aa[$j];
        $aa[$j] = $t;
    }
}

function practiceSession() {
    global $k, $u, $l, $t, $x, $y, $c, $dv, $md, $i, $j, $ans, $a, $r, $aa, $d;

    while ($l > 0) {
        // Practice loop
        while ($k <= $u && $l > 0) {
            cls();
            echo $l . " problems left. -1 Esc\n";

            echo $k . "!!!\n";
            $t = $aa[$k];
            $x = $t;
            $y = 10000000;
            idiv();
            $c = $dv;

            if ($c == 6) {
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

            if (-1 == $a || strcmp('.1', $ans) == 0 || strcmp(',1', $ans) == 0 || strcmp('01', $ans) == 0) {
                return;
            }

            switch ($c) {
                case 1:
                case 2:
                    $r = $i + $j;
                    break;
                case 3:
                case 4:
                    $r = $i - $j;
                    break;
                case 5:
                    $r = $i * $j;
                    break;
                case 6:
                    $r = floor($i / $j);
                    break;
            }

            if ($r != $a) {
                echo 'Wrong. ';
                echo $i;
                sign();
                echo $j;
                echo ' is ';
                echo $r;
                echo ".\n";

                $x = $t;
                $y = 100;
                mod();
                if ($md < 99) {
                    $l++;
                    $aa[$k] = $t + 1;
                }

                $k++;
                sound();
                $d = 1000;
                delay();
            } else {
                echo "Right!\n";
                $x = $t;
                $y = 100;
                mod();
                if ($md > 0) {
                    $l--;
                    $aa[$k] = $t - 1;
                }
                $k++;
                if ($l > 0) {
                    $d = 500;
                    delay();
                }
            }
        }

        if ($l <= 0) {
            echo "Good!!!Well done!\n";
            $d = 5000;
            delay();
            return;
        } else {
            echo "Checking...\n";
            $n = 1;
            for ($k = 1; $k <= $u; $k++) {
                $t = $aa[$k];
                $x = $t;
                $y = 100;
                mod();
                if ($md != 0) {
                    $aa[$n] = $t;
                    $n++;
                }
            }
            $u = $n - 1;
            shuffleProblems();
            $k = 1;
        }
    }
}

function nr() {
    global $a, $m, $x, $y, $r, $dv, $md;
    $a++;
    $x = $m;
    pow10();
    $y = $r;
    idiv();
    $x = $dv;
    $y = 10;
    mod();
    echo $a . (($md != 0) ? '*' : ' ');
}

function setupMenu() {
    global $m, $md, $dv, $x, $y, $n, $ans, $a, $i, $r, $k;

    while (true) {
        cls();
        $n = 0;

        // Calculate the number of selected exercises
        for ($a = 1; $a <= 6; $a++) {
            pow10();
            $x = $m;
            $y = $r;
            idiv();
            $x = $dv;
            $y = 10;
            mod();
            if ($md != 0) {
                $n += ($i == 6) ? 90 : 100;
            }
        }

        // Display menu items
        $a = 0;
        nr();
        echo "Addition 1\n";

        nr();
        echo "Addition 2\n";

        nr();
        echo "Subtraction 1\n";

        nr();
        echo "Subtraction 2\n";

        nr();
        echo "Multiplication\n";

        nr();
        echo "Division|-1 Esc\n";

        echo '0 OK and go ' . $n . "\n";

        while (true) {
            echo 'Toggle item 1-6, or choose 0 or -1: ';
            $ans = readline();
            $a = (int)$ans;

            if (-1 == $a || strcmp('.1', $ans) == 0 || strcmp(',1', $ans) == 0 || strcmp('01', $ans) == 0) {
                return;
            }

            if ($ans == "" || $a < -1 || $a > 6 || ($a == 0 && $n == 0)) {
                continue;
            }

            if ($a == 0) {
                if ($n > 0) {
                    generateProblems();
                    shuffleProblems();
                    $k = 1;
                    practiceSession();
                    return;
                } else {
                    continue;
                }
            }
            break;
        }

        // Toggle the selected exercise type
        pow10();
        $x = $m;
        $y = $r;
        idiv();
        $x = $dv;
        $y = 10;
        mod();

        if ($md == 0) {
            $m += $r;
        } else {
            $m -= $r;
        }
    }
}

function mainMenu() {
    global $l, $m, $a;

    cls();
    $a = 0;

    if ($l > 0 && $m) {
        menuitem();
        echo "Continue\n";
    }

    if ($m == 0) {
        $m = 10;
    }

    menuitem();
    echo "Setup and go\n";
    menuitem();
    echo "Help\n";
    menuitem();
    echo "About\n";
    menuitem();
    echo "Exit\n";

    $maxOption = 4 + ($l > 0 ? 1 : 0);
    $s = 0;

    while ($s < 1 || $s > $maxOption) {
        echo 'Choose 1-' . $maxOption . ': ';
        $ans = readline();
        $s = (int) $ans;
    }

    if ($l > 0 && $m) {
        switch ($s) {
            case 1: practiceSession(); break;
            case 2: setupMenu(); break;
            case 3: help(); break;
            case 4: about(); break;
            case 5: quit(); break;
        }
    } else {
        switch ($s) {
            case 1: setupMenu(); break;
            case 2: help(); break;
            case 3: about(); break;
            case 4: quit(); break;
        }
    }
}

function quit() {
    cls();
    exit(0);
}

function mainLoop() {
    while (true) {
        mainMenu();
    }
}

// Initialize and start the program
srand();
$r = rnd();
$aa = array_fill(1, 590, 0.0);
mainLoop();

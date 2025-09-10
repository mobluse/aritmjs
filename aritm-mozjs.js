#!/usr/bin/env js102
// Aritm v0.3.4 for SpiderMonkey js102 is FOSS.
// (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
// Documentation:
// 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.
// Install js102 or js24 in Debian or Raspberry Pi OS:
// sudo apt install libmozjs-102-dev
// sudo apt install libmozjs-24-bin

// Global variables
var md = 0.0;
var dv = 0.0;
var x = 0.0;
var y = 0.0;
var r = 0.0;
var l = 0;
var m = 10;
var aa = [];
var a = 0;
var u = 0;
var k = 0;
var t = 0;
var c = 0;
var i = 0;
var j = 0;
var ans = "";
var n = 0;
var d = 0;

function delay() {
    var start = new Date().getTime();
    //d = 0;
    while (new Date().getTime() < start + d);
}

function mod() {
    md = Math.floor(0.5 + (x / y - Math.floor(x / y)) * y);
}

function idiv() {
    dv = Math.floor(0.5 + x / y);
}

function rnd() {
    return Math.random();
}

function cls() {
    for (t = 1; t <= 40; t++) {
        print();
    }
    print("Aritm");
}

function sound() {
    print("\x07");
    delay(100);
}

function sign() {
    switch (c) {
        case 1:
        case 2:
            putstr('+');
            break;
        case 3:
        case 4:
            putstr('-');
            break;
        case 5:
            putstr('*');
            break;
        case 6:
            putstr('/');
            break;
    }
}

function pow10() {
    r = 1;
    for (i = 1; i <= a; i++) {
        r *= 10;
    }
}

function help() {
    cls();
    print("Help");
    print("You can mix problems anyway you like.");
    print("More help on <http://aritm.orbin.se/>.");
    d = 5000;
    delay();
}

function about() {
    cls();
    print("About");
    print("Aritm 0.3 (c) 1992-2025 by");
    print("Mikael O. Bonnier, Lund, Sweden.");
    print("Absolutely no warranty.");
    print("FOSS, see license GPLv3+.");
    d = 5000;
    delay();
}

function menuitem() {
    a++;
    putstr(a + ' ');
}

function generateProblems() {
    cls();
    print("Generating\nProblems...");
    u = 1;

    // Addition 1
    x = m;
    y = 10;
    idiv();
    x = dv;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = 0; j <= 9; j++) {
                aa[u] = 10000000 + i * 10000 + j * 100 + 1;
                u++;
            }
        }
    }

    // Addition 2
    x = m;
    y = 100;
    idiv();
    x = dv;
    y = 10;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = 0; j <= 9; j++) {
                t = 10 * (Math.floor(8 * rnd()) + 1);
                aa[u] = 20000000 + (t + i) * 10000 + j * 100 + 1;
                u++;
            }
        }
    }

    // Subtraction 1
    x = m;
    y = 1000;
    idiv();
    x = dv;
    y = 10;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = i; j <= 9 + i; j++) {
                aa[u] = 30000000 + j * 10000 + i * 100 + 1;
                u++;
            }
        }
    }

    // Subtraction 2
    x = m;
    y = 10000;
    idiv();
    x = dv;
    y = 10;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = i; j <= 9 + i; j++) {
                t = 10 * (Math.floor(9 * rnd()) + 1);
                aa[u] = 40000000 + (t + j) * 10000 + i * 100 + 1;
                u++;
            }
        }
    }

    // Multiplication
    x = m;
    y = 100000;
    idiv();
    x = dv;
    y = 10;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = 0; j <= 9; j++) {
                aa[u] = 50000000 + i * 10000 + j * 100 + 1;
                u++;
            }
        }
    }

    // Division
    x = m;
    y = 1000000;
    idiv();
    x = dv;
    y = 10;
    mod();
    if (md != 0) {
        for (i = 0; i <= 9; i++) {
            for (j = 1; j <= 9; j++) {
                t = i * j + Math.floor(j * rnd());
                aa[u] = 60000000 + t * 10000 + j * 100 + 1;
                u++;
            }
        }
    }

    u--;
    l = u;
}

function shuffleProblems() {
    print("Shuffling...");
    for (i = u; i >= 2; i--) {
        j = Math.floor(i * rnd()) + 1;
        t = aa[i];
        aa[i] = aa[j];
        aa[j] = t;
    }
}

function practiceSession() {
    while (l > 0) {
        // Practice loop
        while (k <= u && l > 0) {
            cls();
            putstr(l + " problems left. -1 Esc\n");

            t = aa[k];
            x = t;
            y = 10000000;
            idiv();
            c = dv;

            if (c == 6) {
                putstr('Integer part of ');
            }

            x = t;
            y = 10000;
            idiv();
            x = dv;
            y = 1000;
            mod();
            i = md;
            putstr(i.toString());

            sign();

            x = t;
            y = 100;
            idiv();
            x = dv;
            y = 100;
            mod();
            j = md;
            putstr(j.toString());
            putstr(' = ');

            ans = readline();
            a = parseFloat(ans);

            if (-1 == a || '.1' === ans || ',1' === ans || '01' === ans) {
                return;
            }

            switch (c) {
                case 1:
                case 2:
                    r = i + j;
                    break;
                case 3:
                case 4:
                    r = i - j;
                    break;
                case 5:
                    r = i * j;
                    break;
                case 6:
                    r = Math.floor(i / j);
                    break;
            }

            if (r != a) {
                putstr('Wrong. ');
                putstr(i.toString());
                sign();
                putstr(j.toString());
                putstr(' is ');
                print(r.toString());

                x = t;
                y = 100;
                mod();
                if (md < 99) {
                    l++;
                    aa[k] = t + 1;
                }

                k++;
                sound();
                d = 1000;
                delay();
            } else {
                print("Right!");
                x = t;
                y = 100;
                mod();
                if (md > 0) {
                    l--;
                    aa[k] = t - 1;
                }
                k++;
                if (l > 0) {
                    d = 500;
                    delay();
                }
            }
        }

        if (l <= 0) {
            print("Good!!! Well done!");
            d = 5000;
            delay();
            return;
        } else {
            print("Checking...");
            n = 1;
            for (k = 1; k <= u; k++) {
                t = aa[k];
                x = t;
                y = 100;
                mod();
                if (md != 0) {
                    aa[n] = t;
                    n++;
                }
            }
            u = n - 1;
            shuffleProblems();
            k = 1;
        }
    }
}

function nr() {
    a++;
    x = m;
    pow10();
    y = r;
    idiv();
    x = dv;
    y = 10;
    mod();
    putstr(a + (md != 0 ? '*' : ' '));
}

function setupMenu() {
    while (true) {
        cls();
        n = 0;

        // Calculate the number of selected exercises
        for (a = 1; a <= 6; a++) {
            pow10();
            x = m;
            y = r;
            idiv();
            x = dv;
            y = 10;
            mod();
            if (md != 0) {
                n += (a == 6) ? 90 : 100;
            }
        }

        // Display menu items
        a = 0;
        nr();
        print("Addition 1");

        nr();
        print("Addition 2");

        nr();
        print("Subtraction 1");

        nr();
        print("Subtraction 2");

        nr();
        print("Multiplication");

        nr();
        print("Division|-1 Esc");

        print('0 OK and go ' + n);

        while (true) {
            putstr('Toggle item 1-6, or choose 0 or -1: ');
            ans = readline();
            a = parseInt(ans);

            if (-1 == a || '.1' === ans || ',1' === ans || '01' === ans) {
                return;
            }

            if (ans === "" || a < -1 || a > 6 || (a == 0 && n == 0)) {
                continue;
            }

            if (a == 0) {
                if (n > 0) {
                    generateProblems();
                    shuffleProblems();
                    k = 1;
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
        x = m;
        y = r;
        idiv();
        x = dv;
        y = 10;
        mod();

        if (md == 0) {
            m += r;
        } else {
            m -= r;
        }
    }
}

function mainMenu() {
    cls();
    a = 0;

    if (l > 0) {
        menuitem();
        print("Continue");
    }

    menuitem();
    print("Setup and go");
    menuitem();
    print("Help");
    menuitem();
    print("About");
    menuitem();
    print("Exit");

    var maxOption = a;
    var s = 0;

    while (s < 1 || s > maxOption) {
        putstr('Choose 1-' + maxOption + ': ');
        ans = readline();
        s = parseInt(ans);
    }

    var optionIndex = l > 0 ? s : s + 1;

    switch (optionIndex) {
        case 1:
            practiceSession();
            break;
        case 2:
            setupMenu();
            break;
        case 3:
            help();
            break;
        case 4:
            about();
            break;
        case 5:
            quit2();
            break;
    }
}

function quit2() {
    cls();
    quit();
}

function mainLoop() {
    while (true) {
        mainMenu();
    }
}

// Initialize and start the program
aa = new Array(591);
for (var idx = 0; idx < 591; idx++) {
    aa[idx] = 0.0;
}
mainLoop();

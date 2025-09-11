#!/usr/bin/env python3
# Aritm v0.3.4 for Python 3.11.2 is FOSS.
# (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
# E-mail: <mikael.bonnier@gmail.com>.
# Absolutely no warranty.
# License GPLv3+, see
# <http://www.gnu.org/licenses/gpl.html>.
# More programs at
# <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
# Documentation:
# 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.

import math
import random
import time
import os
import sys

# Global variables
md = 0.0
dv = 0.0
x = 0.0
y = 0.0
r = 0.0
l = 0
m = 0
aa = []
a = 0
u = 0
k = 0
t = 0
c = 0
i = 0
j = 0
ans = ""
n = 0
d = 0

def delay():
    time.sleep(d / 1000)

def mod():
    global md, x, y
    md = math.floor(0.5 + (x / y - math.floor(x / y)) * y)

def idiv():
    global dv, x, y
    dv = math.floor(0.5 + x / y)

def rnd():
    return random.random()

def cls():
    os.system('cls' if os.name == 'nt' else 'clear')
    print("Aritm")

def sound():
    print('\a', end='', flush=True)
    time.sleep(0.1)

def sign():
    global c
    if c in [1, 2]:
        print('+', end='')
    elif c in [3, 4]:
        print('-', end='')
    elif c == 5:
        print('*', end='')
    elif c == 6:
        print('/', end='')

def pow10():
    global r, i, a
    r = 1
    for i in range(1, a + 1):
        r *= 10

def help():
    cls()
    print("Help")
    print("You can mix problems anyway you like.")
    print("More help on <http://aritm.orbin.se/>.")
    global d
    d = 5000
    delay()

def about():
    cls()
    print("About")
    print("Aritm 0.3 (c) 1992-2025 by")
    print("Mikael O. Bonnier, Lund, Sweden.")
    print("Absolutely no warranty.")
    print("FOSS, see license GPLv3+.")
    global d
    d = 5000
    delay()

def menuitem():
    global a
    a += 1
    print(f"{a} ", end='')

def generateProblems():
    global m, md, dv, x, y, u, aa, l, i, j, t
    
    cls()
    print("Generating")
    print("Problems...")
    u = 1
    aa = [0] * 591  # Initialize with zeros

    # Addition 1
    x = m
    y = 10
    idiv()
    x = dv
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(0, 10):
                aa[u] = 10000000 + i * 10000 + j * 100 + 1
                u += 1

    # Addition 2
    x = m
    y = 100
    idiv()
    x = dv
    y = 10
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(0, 10):
                t = 10 * (math.floor(8 * rnd()) + 1)
                aa[u] = 20000000 + (t + i) * 10000 + j * 100 + 1
                u += 1

    # Subtraction 1
    x = m
    y = 1000
    idiv()
    x = dv
    y = 10
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(i, 10 + i):
                aa[u] = 30000000 + j * 10000 + i * 100 + 1
                u += 1

    # Subtraction 2
    x = m
    y = 10000
    idiv()
    x = dv
    y = 10
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(i, 10 + i):
                t = 10 * (math.floor(9 * rnd()) + 1)
                aa[u] = 40000000 + (t + j) * 10000 + i * 100 + 1
                u += 1

    # Multiplication
    x = m
    y = 100000
    idiv()
    x = dv
    y = 10
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(0, 10):
                aa[u] = 50000000 + i * 10000 + j * 100 + 1
                u += 1

    # Division
    x = m
    y = 1000000
    idiv()
    x = dv
    y = 10
    mod()
    if md != 0:
        for i in range(0, 10):
            for j in range(1, 10):
                t = i * j + math.floor(j * rnd())
                aa[u] = 60000000 + t * 10000 + j * 100 + 1
                u += 1

    u -= 1
    l = u

def shuffleProblems():
    global u, aa, i, j, t
    
    print("Shuffling...")
    for i in range(u, 1, -1):
        j = math.floor(i * rnd()) + 1
        t = aa[i]
        aa[i] = aa[j]
        aa[j] = t

def practiceSession():
    global k, u, l, t, x, y, c, dv, md, i, j, ans, a, r, aa, d
    
    while l > 0:
        # Practice loop
        while k <= u and l > 0:
            cls()
            print(f"{l} problems left. -1 Esc")

            t = aa[k]
            x = t
            y = 10000000
            idiv()
            c = dv

            if c == 6:
                print('Integer part of ', end='')

            x = t
            y = 10000
            idiv()
            x = dv
            y = 1000
            mod()
            i = md
            print(i, end='')

            sign()

            x = t
            y = 100
            idiv()
            x = dv
            y = 100
            mod()
            j = md
            print(j, end='')
            print(' = ', end='')

            ans = input().strip()
            try:
                a = float(ans)
            except ValueError:
                a = -1

            if a == -1 or ans in ['.1', ',1', '01']:
                return

            if c in [1, 2]:
                r = i + j
            elif c in [3, 4]:
                r = i - j
            elif c == 5:
                r = i * j
            elif c == 6:
                r = math.floor(i / j)

            if r != a:
                print('Wrong. ', end='')
                print(i, end='')
                sign()
                print(j, end='')
                print(' is ', end='')
                print(r, end='')
                print(".")

                x = t
                y = 100
                mod()
                if md < 99:
                    l += 1
                    aa[k] = t + 1

                k += 1
                sound()
                d = 1000
                delay()
            else:
                print("Right!")
                x = t
                y = 100
                mod()
                if md > 0:
                    l -= 1
                    aa[k] = t - 1
                k += 1
                if l > 0:
                    d = 500
                    delay()

        if l <= 0:
            print("Good!!! Well done!")
            d = 5000
            delay()
            return
        else:
            print("Checking...")
            n = 1
            for k in range(1, u + 1):
                t = aa[k]
                x = t
                y = 100
                mod()
                if md != 0:
                    aa[n] = t
                    n += 1
            u = n - 1
            shuffleProblems()
            k = 1

def nr():
    global a, m, x, y, r, dv, md
    a += 1
    x = m
    pow10()
    y = r
    idiv()
    x = dv
    y = 10
    mod()
    print(f"{a}{'*' if md != 0 else ' '}", end='')

def setupMenu():
    global m, md, dv, x, y, n, ans, a, r, k
    
    while True:
        cls()
        n = 0

        # Calculate the number of selected exercises
        for a in range(1, 7):
            pow10()
            x = m
            y = r
            idiv()
            x = dv
            y = 10
            mod()
            if md != 0:
                n += 90 if a == 6 else 100

        # Display menu items
        a = 0
        nr()
        print("Addition 1")

        nr()
        print("Addition 2")

        nr()
        print("Subtraction 1")

        nr()
        print("Subtraction 2")

        nr()
        print("Multiplication")

        nr()
        print("Division|-1 Esc")

        print(f'0 OK and go {n}')

        while True:
            ans = input('Toggle item 1-6, or choose 0 or -1: ').strip()
            try:
                a = int(ans)
            except ValueError:
                a = -2  # Invalid value

            if a == -1 or ans in ['.1', ',1', '01']:
                return

            if ans == "" or a < -1 or a > 6 or (a == 0 and n == 0):
                continue

            if a == 0:
                if n > 0:
                    generateProblems()
                    shuffleProblems()
                    k = 1
                    practiceSession()
                    return
                else:
                    continue
            break

        # Toggle the selected exercise type
        pow10()
        x = m
        y = r
        idiv()
        x = dv
        y = 10
        mod()

        if md == 0:
            m += r
        else:
            m -= r

def mainMenu():
    global l, m, a
    
    cls()
    a = 0

    if l > 0:
        menuitem()
        print("Continue")

    menuitem()
    print("Setup and go")
    menuitem()
    print("Help")
    menuitem()
    print("About")
    menuitem()
    print("Exit")

    maxOption = a
    s = 0

    while s < 1 or s > maxOption:
        try:
            s = int(input(f'Choose 1-{maxOption}: '))
        except ValueError:
            s = 0

    optionIndex = s if l > 0 else s + 1

    if optionIndex == 1:
        practiceSession()
    elif optionIndex == 2:
        setupMenu()
    elif optionIndex == 3:
        help()
    elif optionIndex == 4:
        about()
    elif optionIndex == 5:
        quit()

def quit():
    cls()
    sys.exit(0)

def mainLoop():
    while True:
        mainMenu()

# Initialize and start the program
if __name__ == "__main__":
    aa = [0.0] * 591
    mainLoop()

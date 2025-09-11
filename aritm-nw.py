# Aritm v0.3.4 for NumWorks with MicroPython 1.17.0 is FOSS.
# (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
# E-mail: <mikael.bonnier@gmail.com>.
# Absolutely no warranty.
# License GPLv3+, see
# <http://www.gnu.org/licenses/gpl.html>.
# More programs at
# <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
# Documentation:
# 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.

from math import floor
import random
import time

# Global variables
md = 0.0
dv = 0.0
x = 0.0
y = 0.0
r = 0.0
l = 0
m = 10
aa = []
a = 0
u = 0
k = 0
t = 0
c = 0
i = 0
j = 0
ans = ''
n = 0
d = 0
sb = ''

def delay():
  global d
  #d=0
  time.sleep(d/1000)

def mod():
  global md, x, y
  md = x%y

def idiv():
  global dv, x, y
  dv = x//y

def rnd():
  return random.random()

def cls():
  global i
  for i in range(10):
    print()
  print("Aritm")

def sound():
  # MicroPython doesn't have a standard beep function
  global d
  d = 100
  delay()

def sign():
  global c, sb
  if c in [1, 2]:
    sb += '+'
  elif c in [3, 4]:
    sb += '-'
  elif c == 5:
    sb += '*'
  elif c == 6:
    sb += '/'

def pow10():
  global r, a
  r = 10**a

def help():
  cls()
  print("Help")
  print("You can mix problems\nanyway you like.")
  print("More help on\n<http://aritm.orbin.se/>.")
  global d
  d = 5000
  delay()

def about():
  cls()
  print("About")
  print("Aritm 0.3 (c) 1992-2025 by")
  print("Mikael O. Bonnier, Lund,\nSweden.")
  print("Absolutely no warranty.")
  print("FOSS, see license GPLv3+.")
  global d
  d = 5000
  delay()

def menuitem():
  global a
  a += 1
  print(end='%d '%a)

def generateProblems():
  global m, md, dv, x, y, u, aa, l, i, j, t

  cls()
  print("Generating")
  print("Problems...")
  u = 1

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
        t = 10 * (floor(8 * rnd()) + 1)
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
        t = 10 * (floor(9 * rnd()) + 1)
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
        t = i * j + floor(j * rnd())
        aa[u] = 60000000 + t * 10000 + j * 100 + 1
        u += 1

  u -= 1
  l = u

def shuffleProblems():
  global u, aa, i, j, t

  print("Shuffling...")
  for i in range(u, 1, -1):
    j = floor(i * rnd()) + 1
    t = aa[i]
    aa[i] = aa[j]
    aa[j] = t

def practiceSession():
  global k, u, l, t, x, y, c, dv, md, i, j, ans, a, r, aa, d, sb

  while l > 0:
    # Practice loop
    while k <= u and l > 0:
      cls()
      print("%d problems left. -1 Esc"%l)

      t = aa[k]
      x = t
      y = 10000000
      idiv()
      c = dv
      sb = ''
      if c == 6:
          sb += 'Integer part of '

      x = t
      y = 10000
      idiv()
      x = dv
      y = 1000
      mod()
      i = md
      sb += str(i)

      sign()

      x = t
      y = 100
      idiv()
      x = dv
      y = 100
      mod()
      j = md
      sb += str(j)
      sb += ' = '

      ans = input(sb).strip()
      try:
        a = float(ans)
      except:
        a = -2

      if a == -1 or ans in ['.1', ',1', '01']:
        return
      if a == -2:
        continue

      if c in [1, 2]:
        r = i + j
      elif c in [3, 4]:
        r = i - j
      elif c == 5:
        r = i * j
      elif c == 6:
        x = i
        y = j
        idiv()
        r = dv

      if r != a:
        sb = ''
        sb += 'Wrong. '
        sb += str(i)
        sign()
        sb += str(j)
        sb += ' is '
        sb += str(r)
        sb += '.'
        print(sb)

        x = t
        y = 100
        mod()
        if md < 99:
          l += 1
          aa[k] = t + 1

        k += 1
        sound()
        d = 1200
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
          d = 600
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
  print(end='%d%c'%(a,('*' if md != 0 else ' ')))

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

    print('0 OK and go %d'%n)

    while True:
      ans = input('Toggle 1-6, or 0 or -1: ').strip()
      try:
        a = int(ans)
      except:
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

  s = 0

  while s < 1 or s > a:
    try:
      s = int(input('Choose 1-%d: '%a))
    except:
      s = 0

  oi = s if l > 0 else s + 1

  if oi == 1:
    practiceSession()
  elif oi == 2:
    setupMenu()
  elif oi == 3:
    help()
  elif oi == 4:
    about()
  elif oi == 5:
    quit()

def quit():
  cls()
  raise KeyboardInterrupt

def mainLoop():
  while True:
    mainMenu()

# Initialize and start the program
aa = [0.0] * 591
mainLoop()

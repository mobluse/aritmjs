# Aritm v0.3.4 for TI-82 Advanced Edition Python V5.6.5 is FOSS.
# (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
# Absolutely no warranty.
# License GPLv3+, see
# <http://www.gnu.org/licenses/gpl.html>.
# More programs at
# <https://github.com/mobluse/aritmjs>.
# Documentation:
# 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.

from time import sleep, monotonic
from random import random
from gc import collect, mem_free
from atco import co

l = 0
m = 10
aa = []
a = 0
u = 0
k = 0
c = 0
n = 0
sb = ''

def delay(d):
  #d=0
  sleep(d/1000)

def rnd():
  return random()

def cls():
  for i in range(8):
    print()
  print("Aritm")

def sign(c):
  global sb
  if c in [1, 2]:
    sb += '+'
  elif c in [3, 4]:
    sb += '-'
  elif c == 5:
    sb += '*'
  elif c == 6:
    sb += '/'

#def help():
#  cls()
#  print("Help")
#  print("You can mix problems")
#  print("anyway you like.")
#  print("More help on")
#  print("<http://aritm.orbin.se/>.")
#  delay(5000)

#def about():
#  cls()
#  print("About")
#  print("Aritm 0.3 (c) 1992-2025 by")
#  print("Mikael O. Bonnier, Lund,")
#  print("Absolutely no warranty.")
#  print("FOSS, see license GPLv3+.")
#  delay(5000)

def menuitem():
  global a
  a += 1
  print(end='%d '%a)

def generate():
  global m, u, aa, l

  cls()
  print("Generating")
  print("Problems...")
  u = 1

  # Addition 1
  x = m
  y = 10
  dv = x//y
  x = dv
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(0, 10):
        aa[u] = 10000000 + i * 10000 + j * 100 + 1
        u += 1

  # Addition 2
  x = m
  y = 100
  dv = x//y
  x = dv
  y = 10
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(0, 10):
        t = 10 * (int(8 * rnd()) + 1)
        aa[u] = 20000000 + (t + i) * 10000 + j * 100 + 1
        u += 1

  # Subtraction 1
  x = m
  y = 1000
  dv = x//y
  x = dv
  y = 10
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(i, 10 + i):
        aa[u] = 30000000 + j * 10000 + i * 100 + 1
        u += 1

  # Subtraction 2
  x = m
  y = 10000
  dv = x//y
  x = dv
  y = 10
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(i, 10 + i):
        t = 10 * (int(9 * rnd()) + 1)
        aa[u] = 40000000 + (t + j) * 10000 + i * 100 + 1
        u += 1

  # Multiplication
  x = m
  y = 100000
  dv = x//y
  x = dv
  y = 10
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(0, 10):
        aa[u] = 50000000 + i * 10000 + j * 100 + 1
        u += 1

  # Division
  x = m
  y = 1000000
  dv = x//y
  x = dv
  y = 10
  md = x%y
  if md != 0:
    for i in range(0, 10):
      for j in range(1, 10):
        t = i * j + int(j * rnd())
        aa[u] = 60000000 + t * 10000 + j * 100 + 1
        u += 1
  u -= 1
  l = u

def shuffle():
  global u, aa

  print("Shuffling...")
  for i in range(u, 1, -1):
    j = int(i * rnd()) + 1
    t = aa[i]
    aa[i] = aa[j]
    aa[j] = t

def practice():
  global k, u, l, aa, sb
  while l > 0:
    while k <= u and l > 0:
      cls()
      print("%s%d problems left.%s %s-1 Esc%s"%(co(4,7),l,co(0,7),co(11,7),co(0,7)))
      t = aa[k]
      x = t
      y = 10000000
      dv = x//y
      c = dv
      sb = ''
      if c == 6:
          sb += 'Integer part of  '
      x = t
      y = 10000
      dv = x//y
      x = dv
      y = 1000
      md = x%y
      i = md
      sb += str(i)
      sign(c)
      x = t
      y = 100
      dv = x//y
      x = dv
      y = 100
      md = x%y
      j = md
      sb += str(j)
      sb += ' = '
      ans = input(sb)
      try:
        a = float(ans)
      except:
        a = -9
      if a == -1 or ans in ['.1', ',1', '01']:
        return
      if a == -9:
        continue
      r = int(eval(sb[-8:-3].strip())) 
      if r != a:
        sb = ''
        sb += '%sWrong. %s'%(co(1,7),co(0,7))
        sb += str(i)
        sign(c)
        sb += str(j)
        sb += ' is '
        sb += str(r)
        sb += '.'
        print(sb)
        x = t
        y = 100
        md = x%y
        if md < 99:
          l += 1
          aa[k] = t + 1
        k += 1
        delay(1300)
      else:
        print("%sRight!%s"%(co(2,7),co(0,7)))
        x = t
        y = 100
        md = x%y
        if md > 0:
          l -= 1
          aa[k] = t - 1
        k += 1
        if l > 0:
          delay(600)
    if l <= 0:
      print("Good!!! Well done!")
      delay(5000)
      return
    else:
      print("Checking...")
      n = 1
      for k in range(1, u + 1):
        t = aa[k]
        x = t
        y = 100
        md = x%y
        if md != 0:
          aa[n] = t
          n += 1
      u = n - 1
      shuffle()
      k = 1

def nr():
  global a, m
  a += 1
  x = m
  r = 10**a
  y = r
  dv = x//y
  x = dv
  y = 10
  md = x%y
  print(end='%d%c'%(a,('*' if md != 0 else ' ')))

def setupMenu():
  global m, n, a, k
  while True:
    cls()
    n = 0
    for a in range(1, 7):
      r = 10**a
      x = m
      y = r
      dv = x//y
      x = dv
      y = 10
      md = x%y
      if md != 0:
        n += 90 if a == 6 else 100
    a = 0
    for i in range(1,3):
      nr()
      print("Addition %d"%i)
    for i in range(1,3):
      nr()
      print("Subtraction %d"%i)
    nr()
    print("Multiplication")
    nr()
    print("Division")
    print('0 OK and go %d | -1 Esc'%n)
    while True:
      ans = input('Toggle 1-6, or 0 or -1: ')
      try:
        a = int(ans)
      except:
        a = -2
      if a == -1 or ans in ['.1', ',1', '01']:
        return
      if ans == "" or a < -1 or a > 6 or (a == 0 and n == 0):
        continue
      if a == 0:
        if n > 0:
          generate()
          shuffle()
          k = 1
          practice()
          return
        else:
          continue
      break
    r = int(10**a)
    x = m
    y = r
    dv = x//y
    x = dv
    y = 10
    md = x%y
    if md == 0:
      m += r
    else:
      m -= r

def menu():
  global l, m, a
  print(mem_free())
  collect()
  print(mem_free())
  cls()
  a = 0
  if l > 0:
    menuitem()
    print("Continue")
  menuitem()
  print("Setup and go")
  menuitem()
  print("N/A")
  menuitem()
  print("N/A")
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
    practice()
  elif oi == 2:
    setupMenu()
  #elif oi== 3:
  #  pass
  #elif oi== 4:
  #  pass
  elif oi == 5:
    quit()

def quit():
  cls()
  raise KeyboardInterrupt

def main():
  try:
    while True:
      menu()
  except:
    pass

aa = [0]*401
main()

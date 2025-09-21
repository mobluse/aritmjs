# Aritm for TI-82 Advanced Edition Python in MicroPython
from time import sleep, ticks_us

# Global variables
l = 0
m = 10
aa = []
a = 0
u = 0
k = 0
c = 0
n = 0
sb = ''
_seed = 12345

def delay(d):
  #d=0
  sleep(d/1000)
    
def my_random():
    global _seed
    _seed = (1664525 * _seed + 1013904223) & 0xFFFFFFFF
    return _seed / 4294967296.0

def rnd():
  return my_random()

def cls():
  for i in range(10):
    print()
  print("Aritm")

def sign(c):
  global sb
  if c == 5:
    sb += '*'
  elif c == 6:
    sb += '/'

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
    # Practice loop
    while k <= u and l > 0:
      cls()
      print("%d problems left. -1 Esc"%l)

      t = aa[k]
      x = t
      y = 10000000
      dv = x//y
      c = dv
      sb = ''
      if c == 6:
          sb += 'Integer part of '

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
        a = -2

      if a == -1 or ans in ['.1', ',1', '01']:
        return
      if a == -2:
        continue

      if c == 5:
        r = i * j
      elif c == 6:
        x = i
        y = j
        dv = x//y
        r = dv

      if r != a:
        sb = ''
        sb += 'Wrong. '
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
        d = 1300
        delay(d)
      else:
        print("Right!")
        x = t
        y = 100
        md = x%y
        if md > 0:
          l -= 1
          aa[k] = t - 1
        k += 1
        if l > 0:
          d = 600
          delay(d)

    if l <= 0:
      print("Good!!! Well done!")
      d = 5000
      delay(d)
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
  global m, n, a, k, _seed

  while True:
    cls()
    n = 0
    # Calculate the number of selected exercises
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

    # Display menu items
    a = 0
    nr()
    print('N/A')

    nr()
    print('N/A')

    nr()
    print('N/A')

    nr()
    print('N/A')

    nr()
    print("Multiplication")

    nr()
    print("Division|-1 Esc")

    print('0 OK and go %d'%n)

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
          _seed = ticks_us()
          generate()
          shuffle()
          k = 1
          practice()
          return
        else:
          continue
      break

    r = 10**a
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

  cls()
  a = 0

  if l > 0:
    menuitem()
    print("Continue")

  menuitem()
  print("Setup and go")
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
  elif oi == 3:
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

def start():
  global aa
  aa = [0.0]*191
  main()

if __name__ == '__main__':
  start()

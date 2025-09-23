# AtCo (C) 2024 by Mikael O. Bonnier, Lund, Sweden.  License: GPLv3+.
def co(fg,bg):
  return "\x1B[%d;%dm"%(fg,bg)

def at(r,c):
  return "\x1B[%d;%dH"%(r,c)

def cls():
  return "\x1B[2J"

def cll():
  return "\x1B[K"

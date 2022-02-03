#!/usr/bin/python3
import pexpect
import math

#c='php aritm.php'
#c='pcbasic aritm-bc3c-gw.bas -n -i=stdio'
#c='~/Downloads/mmb4l-2022.01.00-a3-armv6l/mmbasic aritm-mm.bas'
#c='picocom /dev/ttyACM0' # PicoMite MMBasic
#c='~/Downloads/zce/zce -r0 -xc aritm-zx81.bas'
#c='./faux1 -a 6000 -l apps/applesoft.woz -c 6000R'
c='yabasic aritm-ya.bas'

s=': ' # PHP/Applesoft-&MM-&GW-BASIC
#s='\? ' # BASICODE
#s='> ' # ZX81

s3='= ' # PHP/Applesoft-&MM-&GW-BASIC
#s2='> ' # ZX81
#s2='\? '

b,e=-6,-1 # PHP/Applesoft-&MM-&GW-BASIC
#b,e=-9,-3 # BASICODE
#b,e=-9,-4 # ZX81

print(c)
child=pexpect.spawn(c)

# PicoMite via picocom
#child.expect('dy')
#child.sendline('')
#child.expect('> ')
#child.sendline('run')
# End PicoMite

# Applesoft Lite via Faux1
#fn='/home/pi/aritmjs/aritm-al.bas'
#print(fn)
#file=open(fn,'r')
#lines=file.readlines()
#for line in lines:
#    child.expect(']')
#    line=line.strip()
#    print(line)
#    child.sendline(line)
#child.expect(']')
#child.sendline('run')
# End Applesoft Lite

#child.interact()

n=5*100+90-1
child.expect(s)
print('L1')
child.sendline('1')
child.expect(s)
print('L2a')
child.sendline('2')
child.expect(s)
print('L2b')
child.sendline('3')
child.expect(s)
print('L2c')
child.sendline('4')
child.expect(s)
print('L2d')
child.sendline('5')
child.expect(s)
print('L2e')
child.sendline('6')
child.expect(s)
print('L3')
child.sendline('0')
child.expect(s3)
print('L4')
for i in range(n):
    s=child.before[b:e]
    s=s.replace(b'f',b' ') # PHP/MM-&GW-BASIC
    s=s.replace(b'F',b' ') # ZX81
    s=s.replace(b'\n',b' ')
    s=s.replace(b'\r',b' ')
    print(s)
    r=int(math.floor(eval(s)))
    print('%i: result %g'%(i,r))
    child.sendline(str(r))
    child.expect(s3)
print('L5')
print(child.before)
child.interact()

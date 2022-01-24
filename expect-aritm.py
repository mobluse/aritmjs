#!/usr/bin/python3
import pexpect
import math
#c='php aritm.php'
#c='pcbasic aritm-gw.bas -n -i=stdio'
c='../zce/zce -r0 -xc aritm-zx81.bas'
#s=': ' # PHP/GW-BASIC
s='> ' # ZX81
#b,e=-6,-1 # PHP/GW-BASIC
b,e=-9,-4 # ZX81
print(c)
child=pexpect.spawn(c)
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
child.expect('[=>] ')
print('L4')
for i in range(n):
    s=child.before[b:e]
    s = s.replace(b'f',b' ') # PHP/GW-BASIC
    s = s.replace(b'F',b' ') # ZX81
    print(s)
    r=int(math.floor(eval(s)))
    print('%i: result %g'%(i,r))
    child.sendline(str(r))
    child.expect('[=>] ')
print('L5')
print(child.before)
child.interact()
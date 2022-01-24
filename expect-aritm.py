#!/usr/bin/python3
import pexpect
import math
#s='php aritm.php'
s='pcbasic aritm-gw.bas -n -i=stdio'
#s='../zce/zce -r0 -xc aritm-zx81.bas'
print(s)
child=pexpect.spawn(s)
s=': ' # PHP/GW-BASIC
#s='> ' # ZX81
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
for i in range(589): # 1-5: 99, 6 (div): 89
    s=child.before[-6:-1] # PHP/GW-BASIC, 4 (sub 2): -6, 6 (div): -5
    #s=child.before[-7:-4] # ZX81
    s = s.replace(b'f',b' ')
    print(s)
    r=int(math.floor(eval(s)))
    print('%i: result %g'%(i,r))
    child.sendline(str(r))
    child.expect('[=>] ')
print('L5')
print(child.before)
child.interact()

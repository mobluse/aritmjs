#!/bin/sh
sed -E 's/^rem /# /;/^scroll/d;s/let (.+)=(.+)/$\1=\2;/;s/^for (.*)/for (\1) {/;s/^if /if (/;s/return/return;\n}/;s/^next (.+)/} # $\1/;\
s/ then/)/;s/^# sub (.+)/function \1() {/;s/\((.)=(.+) to (.+)\)/($\1=\2; $\1<=\3; ++$\1)/;s/^# lbl (.+)/\1:/;s/rnd/rnd()/;s/input (.+)/\1 = readline();/;\
s/rand/srand();\nfunction rnd() {\nreturn mt_rand()\/(mt_getrandmax()+1.0);\n}/;s/print (.+)"$/print \1\\n";/;s/gosub /# gosub /;s/^@ls.+//;\
s/@lt(.+)/lt\1/;s/10\*\*a/pow10/;s/int\(/floor(/g' $1

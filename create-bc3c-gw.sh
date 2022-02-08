#!/bin/sh
cat ../basicode/tools/BASCODER.BAS aritm-bc3c.bas | sed '//d' | sed '/^$/d' > aritm-bc3c-gw.bas

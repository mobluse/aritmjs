10 FOR I=133 TO 134
20 GO SUB 90
30 NEXT I
60 FOR I=230 TO 255
70 IF NOT(I=231 OR I=232 OR 236<=I AND I<=237 OR I=249 OR I=252) THEN GO SUB 90
80 NEXT I
89 STOP
90 PRINT STR$ I;":";CHR$ I;"."
99 RETURN

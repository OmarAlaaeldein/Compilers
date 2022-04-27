grammar CSV;
file : (row '\n')* ;
row : field (',' field)* ;
field : INT|STRING ;
STRING: ~[,\n]+;
INT : [0-9]+;
WS : [ \r\t]+ -> skip ;
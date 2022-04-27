grammar XML;
file : (entry )* ;
entry : '<'ALPHA ' '* (ALPHA'='DBL field+ DBL)? ' '* (ALPHA'='field+)? '>' ((field ' '?)|entry)* ' '* '</'ALPHA+'>' ;
field
 :ALPHA
 |INT
 ;
INT : [0-9]+ ;

COMMENT
   : '<!--' (COMMENT |.)*? '-->' -> skip
   ;
WS : [ \r\t]+ -> skip ;
ALPHA: [a-zA-Z,.]+;
DBL: '"';
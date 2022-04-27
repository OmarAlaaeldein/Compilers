grammar JSON;

// Lexer Rules
WHITESPACE: [ \t\r\n ] -> skip ;
STRING_LITERAL: '"' CHAR* '"' ;
CHAR: ' ' | '!' | [\u0023-\u005B] | [\u005D-\u10FFFF] | ESCAPE ;
ESCAPE: '\\' '"'|'\\'|'/'|'b'|'f'|'n'|'r'|'t'|('u' HEX HEX HEX HEX);
HEX: DIGIT|HEX_1;
HEX_1: 'a'..'f'|'A'..'F';
NUMBER_LITERAL: '-'? (FLOATING_LITERAL|DECIMAL_LITERAL) EXPONENT ;
EXPONENT: ('e'|'E' SIGN DIGIT+)?;
SIGN: ('+'|'-')?;
FLOATING_LITERAL: DIGIT* '.' DIGIT+ ;
DECIMAL_LITERAL: DIGIT+ ;
DIGIT: '0'..'9';
NULL: 'null';
BOOLEAN: 'true' | 'false';
L_BRACKET: '{';
R_BRACKET: '}';
// Parser Rules
objects: L_BRACKET (pair (',' pair)*)?  R_BRACKET;
array: '[' (value (',' value)*)? ']';
pair: STRING_LITERAL ':' value;
value: STRING_LITERAL
     | NUMBER_LITERAL
     | objects
     | array
     | BOOLEAN
     | NULL
     ;

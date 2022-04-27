grammar COOLParser;

program
   : programBlocks
   ;

programBlocks
   : classDefine # classes
   | EOF # eof
   ;

classDefine
   : CLASS OBJECTID (INHERITS OBJECTID)? '{' (feature (';'))+ '}' #class
   ;
feature
   : (TYPES OBJECTID '(' ((formal (',' formal)))? ')' '{' ((feature|expression) (';'))* '}')|('callout' '('((STRING|OBJECTID) (','(STRING|OBJECTID))*)')')
   | TYPES 'callout'
   | TYPES OBJECTID '[' (DIGIT|INT|HEX_LITERAL) ']'
   | OBJECTID '=' ((DIGIT|INT|OBJECTID|expression|HEX_LITERAL) (ARITH_OP expression)?)
   | TYPES (OBJECTID (','OBJECTID)*)
   ;

formal
   : TYPES OBJECTID
   ;
/* method argument */
expression
   :'{' (expression ';')* '}' # block
   | OBJECTID '('((expression)* (','expression)*)')' # call
   | expression ARITH_OP expression # arith_op
   | expression COND expression # cond_op
   | expression REL_OP expression # rel_op
   | expression EQUAL expression # equal
   | IF '('(expression|feature)+')' '{' ((feature|expression) ';')+ '}' # if
   | ELSE '{' ((feature|expression)';')+ '}' # else
   | FORLOOP OBJECTID'='(DIGIT|INT|INTEGER_NEGATIVE|OBJECTID|HEX_LITERAL)','(OBJECTID|INT|DIGIT|HEX_LITERAL)'{' ((expression|feature)*';') '}'# for_loop
   | RETURN ((OBJECTID|DIGIT|INT|OBJECTID|NEG OBJECTID) ('('(expression)*')')?)  # return
  // | expression METHODS '('
   | NOT expression # boolNot
   | '(' expression ')' # parentheses
   | COND # cond_op
   | INT # int
   | NEG OBJECTID # negative_object
   | STRING # string
   | CHAR # character
   | BOOL # bool
   | DIGIT # digit
   | HEX # hex_digit
   | DECIMAL # decimal_literal
   | HEX_LITERAL # hex_literal
   | OBJECTID # object
   ;
COMMENT
   : OPEN_COMMENT (COMMENT | .)*? CLOSE_COMMENT -> skip
   ;
ONE_LINE_COMMENT
   : '//' (~ '\n')* '\n'? -> skip
   ;
WHITESPACE
   : ([ \t\r\n\f]|'}')+-> skip
   ;
INHERITS
   : 'inherits'
   ;
CLASS
   : 'class'
   ;
IF
   : 'i' 'f'
   ;
LET
   : 'l' 'e' 't'
   ;
TYPES
   : 'void'|'String'|'int'|'float'|'char'|'boolean'
   ;
RETURN
   : 'return'
   ;
FORLOOP
   :
   'for'
   ;
BOOL
   : 'true'| 'false'
   ;
// primitives
DECIMAL
   :
   DIGIT'.'DIGIT*
   ;
COND
   :'&&'|'||'
   ;
ELSE
   :'else'
   ;
NEG
   : '-'
   ;
STRING
   : '"' (ESC | ~ [\\"\r\n])* '"'
   ;
CHAR
   : '\'' (ESC | ~ [\\"\r\n])* '\''
   ;
DIGIT
   : ('-'[0-9]|[0-9])
   ;
INT
   : [0-9] +
   ;
OBJECTID
   : ([A-Za-z_] [_0-9A-Za-z]*)
   ;
ASSIGNMENT
   : '<-'
   ;
CASE_ARROW
   : '=>'
   ;
ARITH_OP
   : '+'|'-'|'*'|'/'|'%'
   ;
REL_OP
   : '<'|'<='|'>='|'>'|'=='
   ;
NOT
   : 'not'
   ;
EQUAL
   : '='|'!='
   ;
INTEGER_NEGATIVE
   : '~'
   ;
HEX_LITERAL
   : '0x'HEX+
   ;
 ESC
   : '\\' (["\\/bfnrt] | UNICODE)
   ;
 UNICODE
   : 'u' HEX HEX HEX HEX
   ;
 HEX
   : [0-9a-fA-F]+
   ;
// comments
OPEN_COMMENT
   : '/*'
   ;
CLOSE_COMMENT
   : '*/'
   ;
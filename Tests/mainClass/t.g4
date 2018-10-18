grammar t;

program 
	:
		everything
	;

everything
	:
		'class' Identifier '{' mainmethod '}'
	;

mainmethod
	:	DEF 'main' LParentheses RParentheses COLON 'int' '{' '}'
	;

LParentheses
	:
		'('
	;

RParentheses
	:
		')'
	;

DEF
	:
		'def'
	;

Identifier
	:
		[a-zA-Z_][a-zA-Z_0-9]*
	;

COLON
	:
		':'
	;

WhiteSpace
	:
		[\n\t\r ]+ -> skip
	;
grammar our_smoola;

program
	:
		MainClass(ClassDefinition)*
	;

MainClass
	:
		CLASS Identifier LBrackets MainMethod RBrackets
	;

ClassDefinition
	:
		CLASS Identifier ExtendClause LBrackets VariableDeclaration (Method)* RBrackets

MainMethod
	:

	;

Method
	:
		DEF Identifier LParentheses Arguments RParentheses COLON TYPE LBrackets MethodBody RBrackets
	;

MethodBody
	:

	;	

Arguments
	:
		(Identifier COLON TYPE COMMA)*(Identifier COLON TYPE)
		|  
	;

ReturnExpression
	:
		RETURN ReturnValue Delimiter
	;

ReturnValue
	:
		
	;

String
	:
		Quotation Sentence Quotation
	;

VariableDeclaration
	:

	;

ExtendClause
	:
		EXTENDS identifier
		|  
	;

EXTENDS
	:
		'extends'
	;

DEF
	:
		'def'
	;

VAR
	:
		'var'
	;

RETURN
	:
		'return'
	;	

CLASS
	:
		'class'
	;

IF
	:
		'if'
	;

ELSE
	:
		'else'
	;

THEN
	:
		'then'
	;

TYPE
	:
		 'string'
		| 'int'
		| 'boolean'
	;

ARRAY
	:
		'int' LSquareBrackets Number RSquareBrackets 
	;

BooleanValue
	:
		'true'
		| 'false'
	;

LParentheses
	:
		'('
	;

RParentheses
	:
		')'
	;

LBrackets
	:
		'{'
	;

RBrackets
	:
		'}'
	;

LSquareBrackets
	:
		'['
	;

RSquareBrackets
	:
		']'
	;

Quotation
	:
		'"'
	;

Delimiter
	:
		';'
	;

COLON
	:
		':'
	;	

COMMA
	:
		','
	;

Number
	:
		[1-9][0-9]*
	;

Identifier
	:
		[a-zA-Z_][a-zA-Z_0-9]*
	;

Comment
	:
		'#' Sentense
	;

Sentense
	:
		[a-zA-Z0-9!@$%^&*(){}[]\/?,.]*
	;

WhiteSpace
	:
		[ \t\r]
	;
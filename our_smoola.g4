grammar our_smoola;

program
	:
		MainClass (ClassDefinition)*
	;

MainClass
	:
		CLASS Identifier LBrackets MainMethod RBrackets
	;

ClassDefinition
	:
		CLASS Identifier ExtendClause LBrackets VariableDeclaration (Method)* RBrackets
	;

MainMethod
	:
		DEF 'main' LParentheses RParentheses COLON 'int' LBrackets MainBody RBrackets
	;

MainBody
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
		RETURN (Expression | ++Expression) Delimiter
	;

Expression
	:
		MatheticalExpression | LogicalExpression | String
	;

MatheticalExpression 
	:
		MultiplyExpression
        ( BinaryArithmaticalOperatorsPriorityTwo MultiplyExpression )*
	;

MultiplyExpression
	:
		AtomExpression
        ( BinaryArithmaticalOperatorsPriorityOne AtomExpression )*
    ;

AtomExpression
	:
		MathematicalTerm
		| (UnaryArithmaticalOperators |  ) LParentheses MatheticalExpression RParentheses
	;

MathematicalTerm
	:
		(UnaryArithmaticalOperators |  ) NumericalTerm
	;

NumericalTerm
	:
		Identifier
		| Number
		| ArrayAccess
		| SelfVariableAccess
		| SelfMethodAccess
	;

LogicalExpression
	:
		( UnaryLogicalOperators Expression1 | Expression1 BinaryLogicalOperators Expression1 ) ( UnaryLogicalOperators Expression1 |  BinaryLogicalOperators Expression1 )*
	;

Expression1
	:
		LogicalAtomExpression
		| '(' LogicalExpression ')'
	;

LogicalAtomExpression
	:
		Identifier
		| Number
		| BooleanValue
		| ArrayAccess
		| String
		| SelfVariableAccess
		| SelfMethodAccess

Term
	:
		Identifier
		| Number
		| BooleanValue
		| ArrayAccess
		| String
		| SelfVariableAccess
		| SelfMethodAccess
	;


SelfVariableAccess
	:
		THIS DOT Identifier
	;

SelfMethodAccess
	:
		THIS DOT Identifier LParentheses Arguments RParentheses
	;

String
	:
		Quotation StringSentence Quotation
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

THIS
	:
		'this'
	;

TYPE
	:
		 'string'
		| 'int'
		| 'boolean'
	;

ArrayDefinition
	:
		'new int' LSquareBrackets Number RSquareBrackets 
	;

ArrayAccess
	:
		Identifier LSquareBrackets Number RSquareBrackets
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

DOT
	:
		'.'
	;

BinaryArithmaticalOperatorsPriorityOne
	:	
		'*'
		| '/'
	;	

BinaryArithmaticalOperatorsPriorityTwo
	:	
		'+'
		| '-'
	;


UnaryArithmaticalOperators
	:
		'-'
	;

BinaryLogicalOperators
	:
		'&&'
		| '||'
	;

UnaryLogicalOperators
	:
		'!'
	;

ComparisonOperators
	:
		'<'
		| '>'
		| '=='
		| '<>'
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

StringSentence
	:
		[a-zA-Z0-9!@$%^&*(){}[]\/?,.]*
	;

Sentense
	:
		[a-zA-Z0-9!@$%^&*(){}[]\/?,.""'']*
	;

WhiteSpace
	:
		[ \t\r]
	;
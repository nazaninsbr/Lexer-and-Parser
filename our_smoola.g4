grammar our_smoola;

program
	:
		mainClass (classDefinition)*
	;

mainClass
	:
		'class' Identifier LBrackets mainMethod RBrackets
	;

classDefinition
	:
		'class' Identifier extendClause LBrackets (variableDeclaration)* (method)* RBrackets
	;

mainMethod
	:
		DEF 'main' LParentheses RParentheses COLON 'int' LBrackets methodBody RBrackets
	;

method
	:
		DEF Identifier LParentheses Arguments RParentheses COLON TYPE LBrackets methodBody RBrackets
	;

methodBody
	:
		(variableDeclaration)* (Statement)* ReturnExpression
	;	

Statement
	:
		Assignment | Conditional | Loop | PrintStatement | methodCall
	;

Assignment 
	:
		( Identifier | THIS DOT Identifier ) AssignmentOperator Expression Delimiter
	;

Conditional
	:
		IF LParentheses Condition RParentheses THEN Statement 
		| IF LParentheses Condition RParentheses THEN Statement ELSE Statement
	;

Condition
	:
		LogicalExpression | BooleanValue
	;

Loop
	:
		WHILE LParentheses Condition RParentheses LBrackets (Statement)* RBrackets
	;

PrintStatement
	:
		PrintCommand LParentheses Expression RParentheses
	;

fragment Arguments
	:
		(Identifier COLON TYPE COMMA)* (Identifier COLON TYPE)
		|  
	;

ReturnExpression
	:
		RETURN ReturnValue Delimiter
	;

ReturnValue
	:
		Expression
	;

Expression
	:
		LogicalExpression | String | BooleanValue | ClassInstantiation
	;

LogicalExpression
	:
		(UnaryLogicalOperators + UnaryArithmaticalOperators) LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime 
		| LParentheses LogicalExpression RParentheses LogicalExpressionPrime
		| LogicalTerm AnyBinaryOperator LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime
	;

fragment HalfLogicalExpression 
	:
		( AnyBinaryOperator LogicalAtomExpression)*
	;

fragment LogicalExpressionPrime
	:
		AnyBinaryOperator LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime
		| 
	;

LogicalAtomExpression
	:
		LogicalExpression
		| LogicalTerm
	;

AnyBinaryOperator
	:
		ComparisonOperators | BinaryLogicalOperators | BinaryArithmaticalOperatorsPriorityOne | BinaryArithmaticalOperatorsPriorityTwo
	;

LogicalTerm
	:
		Identifier
		| Number
		| BooleanValue
		| arrayAccess
		| SelfVariableAccess
		| SelfMethodAccess
		| ArrayLength
		| MethodCall
		| ClassInstantiationAndCall
	;

SelfVariableAccess
	:
		THIS DOT Identifier
	;

SelfMethodAccess
	:
		THIS DOT Identifier (PassingArgument | )
	;

ArrayLength
	:
		Identifier DOT LENGTH
	;

String
	:
		Quotation StringSentence Quotation
	;

variableDeclaration
	:
		VAR Identifier COLON (TYPE | 'int' LSquareBrackets RSquareBrackets) Delimiter
	;

extendClause
	:
		EXTENDS Identifier
		|  
	;

ArrayDefinition
	:
		'new int' LSquareBrackets Number RSquareBrackets 
	;

ClassInstantiation
	:
		'new' Identifier LParentheses RParentheses 
	;

ClassInstantiationAndCall
	:
		ClassInstantiation DOT Identifier (PassingArgument | LParentheses RParentheses)
	;

methodCall
	:
		 Identifier DOT Identifier (PassingArgument | LParentheses RParentheses)
	;

PassingArgument
	:
		LParentheses (Expression COMMA)* Expression RParentheses
	;

arrayAccess
	:
		Identifier LSquareBrackets Number RSquareBrackets
	;


// lexer rules are down here and parser rules are up there


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

WHILE
	:
		'while'
	;

LENGTH
	:
		'length'
	;

TYPE
	:
		 'string'
		| 'int'
		| 'boolean'
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
		'.' -> skip
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

PrintCommand
	:
		'writeln'
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

AssignmentOperator
	:
		'='
	;

Number
	:
		[1-9][0-9]*
		| '0'
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
		[a-zA-Z_0-9]*
	;

Sentense
	:
		[a-zA-Z_0-9%]*
	;

Dollor
	:
		'$'
	;

Underscore
	:
		'_'
	;

WhiteSpace
	:
		[\n\t\r ]+ -> skip
	;
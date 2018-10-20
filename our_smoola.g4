grammar our_smoola;

program
	:
		mainClass (classDefinition)*
	;

mainClass
	:
		CLASS Identifier LBrackets mainMethod RBrackets
	;

classDefinition
	:
		CLASS Identifier extendClause LBrackets (variableDeclaration)* (method)* RBrackets
	;

mainMethod
	:
		DEF 'main' LParentheses RParentheses COLON 'int' LBrackets methodBody RBrackets
	;

method
	:
		DEF Identifier LParentheses arguments RParentheses COLON type LBrackets methodBody RBrackets
	;

methodBody
	:
		(variableDeclaration)* (statement)* returnexpression
	;	

statement
	:
		assignment | conditional | loop | printstatement | methodCall
	;

assignment 
	:
		( Identifier | THIS DOT Identifier ) AssignmentOperator expression Delimiter
	;

conditional
	:
		IF LParentheses condition RParentheses THEN statement 
		| IF LParentheses condition RParentheses THEN statement ELSE statement
	;

condition
	:
		logicalexpression | BooleanValue
	;

loop
	:
		WHILE LParentheses condition RParentheses LBrackets (statement Delimiter)* RBrackets
	;

printstatement
	:
		PrintCommand LParentheses expression RParentheses
	;

arguments
	:
		(Identifier COLON type COMMA)* (Identifier COLON type)
		|  
	;

returnexpression
	:
		RETURN returnValue Delimiter
	;

returnValue
	:
		expression
	;

expression
	:
		logicalexpression | string | BooleanValue | classInstantiation | logicalTerm
	;

logicalexpression
	:
		(UnaryLogicalOperators | SubtractionOperators) logicalAtomexpression halflogicalexpression logicalexpressionPrime 
		| LParentheses logicalexpression RParentheses logicalexpressionPrime
		| logicalTerm anyBinaryOperator logicalAtomexpression halflogicalexpression logicalexpressionPrime
	;

halflogicalexpression 
	:
		( anyBinaryOperator logicalAtomexpression)*
	;

logicalexpressionPrime
	:
		anyBinaryOperator logicalAtomexpression halflogicalexpression logicalexpressionPrime
		| 
	;

logicalAtomexpression
	:
		logicalexpression
		| logicalTerm
	;

anyBinaryOperator
	:
		ComparisonOperators | BinaryLogicalOperators | BinaryArithmaticalOperatorsPriorityOne | AdditionArithmaticalOperatorPriorityTwo | SubtractionOperators
	;

logicalTerm
	:
		Identifier
		| Number
		| BooleanValue
		| arrayAccess
		| selfVariableAccess
		| selfMethodAccess
		| arrayLength
		| methodCall
		| classInstantiationAndCall
	;

selfVariableAccess
	:
		THIS DOT Identifier
	;

selfMethodAccess
	:
		THIS DOT Identifier (passingArgument | )
	;

arrayLength
	:
		Identifier DOT LENGTH
	;

string
	:
		Quotation (stringSentence)* Quotation
	;

stringSentence
	:
		Identifier | Number | LParentheses | RParentheses | LBrackets | RBrackets | LSquareBrackets | RSquareBrackets | Quotation | Delimiter | COLON | COMMA |
		IF | ELSE | WHILE | THEN | BinaryArithmaticalOperatorsPriorityOne | AdditionArithmaticalOperatorPriorityTwo | SubtractionOperators |  BinaryLogicalOperators | PrintCommand | ComparisonOperators | AssignmentOperator | Dollor | Underscore
	;

variableDeclaration
	:
		VAR Identifier COLON type Delimiter
		| VAR Identifier COLON 'int' LSquareBrackets RSquareBrackets Delimiter
	;

extendClause
	:
		EXTENDS Identifier
		|  
	;


arrayDefinition
	:
		'new int' LSquareBrackets Number RSquareBrackets 
	;

classInstantiation
	:
		'new' Identifier LParentheses RParentheses 
	;

classInstantiationAndCall
	:
		classInstantiation DOT Identifier (passingArgument | LParentheses RParentheses)
	;

methodCall
	:
		 Identifier DOT Identifier (passingArgument | LParentheses RParentheses)
	;

passingArgument
	:
		LParentheses (expression COMMA)* expression RParentheses
	;

arrayAccess
	:
		Identifier LSquareBrackets Number RSquareBrackets
	;

type
	:
		 'string'
		| 'int'
		| 'boolean'
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

WHILE
	:
		'while'
	;

LENGTH
	:
		'length'
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

BinaryArithmaticalOperatorsPriorityOne
	:	
		'*'
		| '/'
	;	

AdditionArithmaticalOperatorPriorityTwo
	:	
		'+'
	;


SubtractionOperators
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

Sentense
	:
		[a-zA-Z_0-9%]+
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

DOT
	:
		'.' -> skip
	;
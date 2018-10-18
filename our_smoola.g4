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
		CLASS Identifier ExtendClause LBrackets (VariableDeclaration)* (Method)* RBrackets
	;

MainMethod
	:
		DEF 'main' LParentheses RParentheses COLON 'int' LBrackets MethodBody RBrackets
	;

Method
	:
		DEF Identifier LParentheses Arguments RParentheses COLON TYPE LBrackets MethodBody RBrackets
	;

MethodBody
	:
		(VariableDeclaration)* (Statement)* ReturnExpression
	;	

Statement
	:
		Assignment | Conditional | Loop | PrintStatement 
	;

Assignment 
	:
		( Identifier | THIS DOT Identifier ) AssignmentOperator Expression Delimeter
	;

Conditional
	:
		IF LParentheses Condition RParentheses THEN Statement 
		| IF LParentheses Condition RParentheses THEN Statement ELSE Statement
	;

Condition
	:
		Expression
	;

Loop
	:
		WHILE LParentheses Condition RParentheses LBrackets (Statement)* RBrackets
	;

PrintStatement
	:
		PrintCommand LParentheses Expression RParentheses
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
		Expression
	;

Expression
	:
		MatheticalExpression | LogicalExpression | String | BooleanValue | ClassInstantiation
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
		| LogicalExpression
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
		| ArrayLength
		| MethodCall
		| ClassInstantiationAndCall
	;

LogicalExpression
	:
		UnaryLogicalOperators LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime 
		| LParentheses LogicalExpression RParentheses LogicalExpressionPrime
		| MatheticalExpression (ComparisonOperators | BinaryLogicalOperators) LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime
		| LogicalTerm (ComparisonOperators | BinaryLogicalOperators) LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime
	;

HalfLogicalExpression 
	:
		((ComparisonOperators | BinaryLogicalOperators) LogicalAtomExpression)*
	;

LogicalExpressionPrime
	:
		((ComparisonOperators | BinaryLogicalOperators) LogicalAtomExpression HalfLogicalExpression LogicalExpressionPrime
		|  
	;

LogicalAtomExpression
	:
		LogicalExpression
		| LogicalTerm
		| MatheticalExpression
	;

LogicalTerm
	:
		Identifier
		| Number
		| BooleanValue
		| ArrayAccess
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
		THIS DOT Identifier LParentheses Arguments RParentheses
	;

ArrayLength
	:
		Identifier DOT LENGTH
	;

String
	:
		Quotation StringSentence Quotation
	;

VariableDeclaration
	:
		VAR Identifier COLON (TYPE | 'int' LSquareBrackets RSquareBrackets) Delimeter
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

MethodCall
	:
		 Identifier DOT Identifier (PassingArgument | LParentheses RParentheses)
	;

PassingArgument
	:
		LParentheses (Expression COMMA)* Expression RParentheses
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
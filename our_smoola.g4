grammar our_smoola;

program
	:
		mainClass (classDefinition)* EOF
	;

mainClass
	:
		CLASS className1 = identifierOrMain { System.out.print("ClassDec:"); System.out.println($className1.text); } LBrackets mainMethod RBrackets 
	;

classDefinition
	:
		CLASS className = identifierOrMain (EXTENDS parentClass = identifierOrMain| ) {  if($parentClass.text != null) { System.out.print("ClassDec:"); System.out.print($className.text); System.out.print(','); System.out.println($parentClass.text); } else {System.out.print("ClassDec:"); System.out.println($className.text);}} LBrackets (variableDeclaration)* (method)* RBrackets 
	;

mainMethod
	:
		DEF mainMethodName = MAIN {System.out.print("MethodDec:");System.out.println($mainMethodName.text);} LParentheses RParentheses COLON 'int' LBrackets mainMethodBody RBrackets
	;

method
	:
		DEF MethodName = identifierOrMain {System.out.print("MethodDec:");System.out.print($MethodName.text);}LParentheses arguments {System.out.println("");} RParentheses COLON type LBrackets methodBody RBrackets

	;
mainMethodBody
	:
		(statement | classInstantiationAndCall Delimiter)* returnexpression
	;
methodBody
	:
		(variableDeclaration)* (statement)* returnexpression
	;	

statement 
	:
		LBrackets statement RBrackets | (atomStatement)+
	;

atomStatement
	:
		statementwithoutDelimiter | statementwithDelimiter Delimiter | LBrackets statement RBrackets
	;

statementwithoutDelimiter
	:
		loop | conditional 
	;
statementwithDelimiter
	:
		assignment | printstatement
	;
assignment 
	:
		( identifierOrMain | THIS DOT identifierOrMain | arrayAccess) op = AssignmentOperator {System.out.println("Operator:"+$op.getText());} (expression | arrayDefinition) 
	;

conditional
	:
		op = IF {System.out.println("Conditional:"+$op.getText());} LParentheses condition RParentheses THEN (LBrackets (statement)* RBrackets | statement ) 
		| op1 = IF {System.out.println("Conditional:"+$op1.getText());} LParentheses condition RParentheses THEN statement op2 = ELSE {System.out.println("Conditional:"+$op2.getText());} (LBrackets (statement)* RBrackets | statement ) 
	;

condition
	:
		logicalOrExpression
	;

loop
	:
		WHILE {System.out.println("Loop:While");} LParentheses condition RParentheses LBrackets (statement)* RBrackets 
	;

printstatement
	:
		PrintCommand LParentheses expression RParentheses
	;

arguments
	:
		(argname = identifierOrMain {System.out.print(','); System.out.print($argname.text);} COLON type COMMA)* argname2 = identifierOrMain {System.out.print(',');System.out.print($argname2.text);} COLON type
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
		logicalOrExpression | string | classInstantiation 
	;

logicalOrExpression
	:
		logicalAndExpression (op = LOGICALOR {System.out.println("Operator:"+$op.getText());} logicalAndExpression)*
	;

logicalAndExpression 
	:
		comparingExpression (op = LOGICALAND {System.out.println("Operator:"+$op.getText());} comparingExpression)*
	;

comparingExpression
	:
		relationExpression (op = ComparisonOperators {System.out.println("Operator:"+$op.getText());} relationExpression)*
	;

relationExpression
	:
		addSubtractExpression (op = RelationOperators addSubtractExpression)*
	;

addSubtractExpression
	:
		multiplyExpression (op = (MINUS | PLUS) {System.out.println("Operator:"+$op.getText());} multiplyExpression )* 
	;

multiplyExpression
	:
		signedAtomExpression (op = (MULT | DIVIDE) {System.out.println("Operator:"+$op.getText());} signedAtomExpression )*
	;

signedAtomExpression
	:
		op = (UnaryLogicalOperators | MINUS ) {System.out.println("Operator:"+$op.getText());} logicalTerm 
		| logicalTerm 
	;

logicalTerm
	:
		LParentheses logicalOrExpression RParentheses
		| BooleanValue
		| identifierOrMain
		| numberAndZero
		| arrayAccess
		| selfMethodAccess
		| arrayLength
		| methodCall
		| classInstantiationAndCall
	;

selfMethodAccess
	:
		THIS DOT identifierOrMain (passingArgument | LParentheses RParentheses)
	;

arrayLength
	:
		identifierOrMain DOT LENGTH
		| arrayDefinition DOT LENGTH
	;

string
	:
		Quotation (stringSentence)* Quotation
	;

variableDeclaration
	:
		VAR varName = identifierOrMain COLON varType = type Delimiter {System.out.print("VarDec:"); System.out.print($varName.text); System.out.print(","); System.out.println($varType.text);}
	;


arrayDefinition
	:
		NEW 'int' LSquareBrackets expression RSquareBrackets 
	;

classInstantiation
	:
		NEW identifierOrMain LParentheses RParentheses 
		| LParentheses classInstantiation RParentheses
	;

classInstantiationAndCall
	:
		classInstantiation DOT identifierOrMain (passingArgument | LParentheses RParentheses)
	;

methodCall
	:
		LParentheses methodCall RParentheses (DOT atomMethodCall)*
		| atomMethodCall (DOT atomMethodCall)*
	;

atomMethodCall
	:
		identifierOrMain DOT identifierOrMain (passingArgument | LParentheses RParentheses)
		| identifierOrMain (passingArgument | LParentheses RParentheses)
	;

passingArgument
	:
		LParentheses (expression COMMA)* expression RParentheses
	;

arrayAccess
	:
		identifierOrMain LSquareBrackets expression RSquareBrackets
	;

type
	:
		 'string'
		| 'int'
		| 'boolean'
		| 'int' LSquareBrackets RSquareBrackets
		| identifierOrMain	
	;

numberAndZero
	:
		Number | (ZERO)+
	;

identifierOrMain
	:
		Identifier | MAIN
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

MAIN
	:
		'main'
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

MULT
	:	
		'*'
	;	

DIVIDE
	:
 		'/'
	;

PLUS
	:	
		'+'
	;


MINUS
	:
		'-'
	;

LOGICALOR
	:
		'||'
	;

LOGICALAND
	:
		'&&'
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
		'=='
		| '<>'
	;

RelationOperators
	:
		'<' 
		| '>'
	;

AssignmentOperator
	:
		'='
	;

ZERO
	:
		'0'
	;

Number
	:
		[0]*[1-9][0-9]*
	;
NEW
	:
		'new'
	;

Identifier
	:
		[a-zA-Z_][a-zA-Z_0-9]*
	;

Dollor
	:
		'$'
	;
QMARK
	:
		'?'
	;

AT
	:
		'@'
	;
PERSENT
	:
		'%'
	;
HAT
	:
		'^'
	;
TILDA
	:
		'~'
	;
BACKTICK
	:
		'`'
	;

Underscore
	:
		'_'
	;

DOT
	:
		'.'
	;

WhiteSpace
	:
		[\n\t\r ]+ -> skip
	;

stringSentence
	:
		numberAndZero | LParentheses | RParentheses | LBrackets | RBrackets | LSquareBrackets | RSquareBrackets |  Delimiter | COLON | COMMA | IF | ELSE | WHILE | THEN | MULT | DIVIDE | PLUS | MINUS |  LOGICALOR | LOGICALAND | PrintCommand | ComparisonOperators | RelationOperators | AssignmentOperator | Dollor | Underscore | UnaryLogicalOperators | QMARK | type | EXTENDS | DEF | VAR | RETURN | CLASS | THIS | LENGTH | BooleanValue | AT | PERSENT | HAT | TILDA | BACKTICK | '|' | '&' | '\\' | Identifier
	;

LINE_COMMENT
    :   '#' ~[\r\n]* -> skip
    ;
grammar our_smoola;

program
	:
		mainClass (classDefinition)*
	;

mainClass
	:
		CLASS className = Identifier LBrackets mainMethod RBrackets { System.out.print("ClassDec:"); System.out.println($className.text); }
	;

classDefinition
	:
		CLASS className = Identifier (EXTENDS parentClass = Identifier | ) LBrackets (variableDeclaration)* (method)* RBrackets {  if($parentClass.text != null) { System.out.print("ClassDec:"); System.out.print($className.text); System.out.print(','); System.out.println($parentClass.text); } else {System.out.print("ClassDec:"); System.out.println($className.text);}} 
	;

mainMethod
	:
		DEF Identifier LParentheses RParentheses COLON 'int' LBrackets methodBody RBrackets
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
		statementwithoutDelimiter | statementwithDelimiter Delimiter 
	;
statementwithoutDelimiter
	:
		loop | conditional 
	;
statementwithDelimiter
	:
		assignment | printstatement | methodCall | classInstantiationAndCall
	;
assignment 
	:
		( Identifier | THIS DOT Identifier | arrayAccess) AssignmentOperator (expression | arrayDefinition)
	;

conditional
	:
		IF LParentheses condition RParentheses THEN statement 
		| IF LParentheses condition RParentheses THEN statement ELSE (LBrackets statement RBrackets | statement )
	;

condition
	:
		logicalexpression | BooleanValue
	;

loop
	:
		WHILE LParentheses condition RParentheses LBrackets (statement)* RBrackets
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
		logicalexpression | string | BooleanValue | logicalTerm | classInstantiation 
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

variableDeclaration
	:
		VAR varName = Identifier COLON (varType = type | varTypeName = Identifier) Delimiter {System.out.print("VarDec:"); System.out.print($varName.text); System.out.print(","); if($varType.text != null) {System.out.println($varType.text);} else {System.out.println($varTypeName.text);} }
		| VAR varName = Identifier COLON 'int' LSquareBrackets RSquareBrackets Delimiter {System.out.print("VarDec:"); System.out.print($varName.text); System.out.print(","); System.out.println("int[]");}
	;


arrayDefinition
	:
		NEW 'int' LSquareBrackets Number RSquareBrackets 
	;

classInstantiation
	:
		NEW Identifier LParentheses RParentheses 
		| LParentheses classInstantiation RParentheses
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
		Identifier LSquareBrackets (Number| Identifier) RSquareBrackets
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
		'if' { System.out.println("Conditional:if"); }
	;

ELSE
	:
		'else' { System.out.println("Conditional:else"); }
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
		'while' { System.out.println("Loop:while"); }
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
		'+' { System.out.println("Operator:+"); }
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
		Identifier | Number | LParentheses | RParentheses | LBrackets | RBrackets | LSquareBrackets | RSquareBrackets |  Delimiter | COLON | COMMA | IF | ELSE | WHILE | THEN | BinaryArithmaticalOperatorsPriorityOne | AdditionArithmaticalOperatorPriorityTwo | SubtractionOperators |  BinaryLogicalOperators | PrintCommand | ComparisonOperators | AssignmentOperator | Dollor | Underscore | UnaryLogicalOperators | QMARK | type | EXTENDS | DEF | VAR | RETURN | CLASS | THIS | LENGTH | BooleanValue | AT | PERSENT | HAT | TILDA | BACKTICK
	;

LINE_COMMENT
    :   '#' ~[\r\n]* -> skip
    ;
grammar number;

program 
	:
		'hello' Number*
	;

Number 
	:
		[0-9]+
	;

WhiteSpace
	:
		[ \r\n]+ -> skip
	;
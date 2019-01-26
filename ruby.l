%{

	#include <stdio.h>
/*
	#include "y.tab.h"
	void yyerror(char *s);
	int yylex();
*/

%}


RESERVED "BEGIN"|"do"|"next"|"then"|"END"|"else"|"nil"|"true"|"alias"|"elsif"|"not"|"undef"|"and"|"end"|"or"|"unless"|"begin"|"ensure"|"redo"|"until"|"break"|"false"|"rescue"|"when"|"case"|"for"|"retry"|"while"|"class"|"if"|"return"|"while"|"def"|"in"|"self"|"__FILE__"|"defined?"|"module"|"super"|"__LINE__"

ALPHABET [a-zA-Z]
VALID [_a-zA-Z]
DIGIT [0-9]
SPACES [ \t\n\f]


VAR {VALID}({VALID}|{DIGIT})*
G_VAR "$"{VAR}
INST_VAR "@"{VAR}
CLASS_VAR "@@"{VAR}

/*	not strong, string checking	*/
STRING \"(.*)\" | \'(.*)\'


SIGN (\+|\-)
INT 0|(({SIGN}?)([0-9]{DIGIT}*)){0,9}
FLOAT ({SIGN}?{DIGIT}+(\.({DIGIT}+))(["e"]{INT})?)

/* ranges are verified by the parser */
IN_RANGE	\({INT}..{INT}\)
EX_RANGE	\({INT}...{INT}\)

ARITH_OP "+"|"-"|"*"|"\"|"**"|"%"
BOOL_OP "&&"|"||"|"^"|"and"|"or"|"not"
REL_OP ">"|"<"|">="|"<="|"=="|"!="|"<=>"|"==="|".eql?"|"equal?"


S_AS_OP "="
C_ARITH_AS_OP {ARITH_OP}?=
C_BOOL_AS_OP {BOOL_OP}?=


/*
	if we user parallel assignment then, 
	number of tokens on the rhs should be 
	at least equal to that in lhs,  
	parenthesis are handled in a different way (complex)
*/

P_AS_OP ({VAR}\,)*{VAR}=

%%

/*	rules	*/




{VAR}	{}
{INT}	{}
{FLOAT}	{}

{STRING}	{}

{IN_RANGE}	{}
{EX_RANGE}	{}


"puts" return puts;
. {printf("other\n");}


%%

int main(){
	yylex();
}

/*
int yywrap(void){
	return 1;
}
*/

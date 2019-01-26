%{

void yyerror(char *s);
int yylex();
#include<stdio.h>
#include<stdlib.h>
int sTable[100];
int sVal[100];

void updateTable(char *symbol, int val);

%}

%union {
	int num;
	char *id;
	float fnum;
}

%start line

%token <num> number
%token <id> identifier
%token <fnum> f_number;

%token puts

%type <num> line exp term
%type <id>	assignment

%%

/* grammar */

line :	assignment ';'	{;}
		|	line assignment
		;

exp	:	relExp
		|	opExp
		|	boolExp
		;

relExp	:	term <rel_op> term
			|	relExp
			|	(relExp)
			;

boolExp	:	term <bool_op> term
			|	boolExp
			|	(boolExp)
			|	relExp
			;

operExp	:	term <arith_op>	term
			|	operExp
			;

condExp	:	relExp
			|	boolExp
			;

assignExp	:	<id> <s_as_op> exp
			;

multiassignExp	:	<id> <s_as_op> multiAssignRhs
					|



%%




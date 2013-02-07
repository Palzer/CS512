%{
#include <stdio.h>
#include <stdbool.h>
#include <math.h>
double symtbl[26];
bool issym[26];
%}

%union {
	double dbl;
	int num;
}

%token <dbl> DOUBLE 
%token <num> NUMBER NAME
%token EXP SQRT LOG NEWLINE

%type <dbl> expression

%%
statement_list : statement NEWLINE statement_list
   |
   ;

statement: NAME '=' expression { symtbl[$1] = $3; issym[$1] = true; }
   | expression { printf("%f\n", $1); }
   ;

expression: expression '+' NUMBER { $$ = $1 + $3; }
   | expression '-' NUMBER { $$ = $1 - $3; }
   | expression '+' DOUBLE { $$ = $1 + $3; }
   | expression '-' DOUBLE { $$ = $1 - $3; }
   | expression '+' NAME  { if (issym[$3] == true) { $$ = symtbl[$3] + $1; } else {printf("variable %c not set\n",$3+'a'); $$ = 0;} }
   | expression '-' NAME { if (issym[$3] == true) { $$ = symtbl[$3] - $1; } else {printf("variable %c not set\n",$3+'a'); $$ = 0;} }
   | NUMBER { $$ = $1; }
   | DOUBLE { $$ = $1; }
   | NAME { if (issym[$1] == true) { $$ = symtbl[$1]; } else {printf("variable %c not set\n",$1+'a'); $$ = 0;} }
   | EXP '(' expression ')' { $$ = exp($3); }
   | SQRT '(' expression ')' { $$ = sqrt($3); }
   | LOG '(' expression ')' { $$ = log($3); }
   ;

%%


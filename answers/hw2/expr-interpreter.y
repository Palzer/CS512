%{
#include <stdio.h>
#include <stdbool.h>
int symtbl[26];
bool issym[26];
%}

%token DOUBLE NUMBER NAME EXP SQRT LOG

%%
statement_list : statement '\n' statement_list
   |
   ;

statement: NAME '=' expression
   | expression
   ;

expression: expression '+' NUMBER
   | expression '-' NUMBER
   | expression '+' DOUBLE
   | expression '-' DOUBLE
   | expression '+' NAME 
   | expression '-' NAME 
   | NUMBER
   | DOUBLE
   | NAME 
   | EXP '(' expression ')'
   | SQRT '(' expression ')'
   | LOG '(' expression ')'
   ;

%%


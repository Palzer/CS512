%{
#include <stdio.h>
#include <stdbool.h>
int symtbl[26];
bool issym[26];
%}

%union {
  int rvalue; /* value of evaluated expression */
  int lvalue; /* index into symtbl for variable name */
}

%token <rvalue> NUMBER
%token <lvalue> NAME 
%token NEWLINE

%type <rvalue> expression

%left '+' '-'

%%
line: statement NEWLINE | statement NEWLINE line | NEWLINE line;

statement: NAME '=' expression { symtbl[$1] = $3; issym[$1] = true; }
         | expression  { printf("%d\n", $1); }
         ;

expression: expression '+' expression { $$ = $1 + $3; }
         | expression '-' expression { $$ = $1 - $3; }
         | NUMBER { $$ = $1; }
         | NAME { if (issym[$1] == true) { $$ = symtbl[$1]; } else {printf("variable %c not set\n",$1+'a'); $$ = 0;} }
         ;
%%


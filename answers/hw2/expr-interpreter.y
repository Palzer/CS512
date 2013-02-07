%{
#include <stdio.h>
#include <stdbool.h>
#include <math.h>
double symtbl[26];
bool issym[26];
%}

%token DOUBLE NUMBER NAME EXP SQRT LOG NEWLINE

%%
statement_list : statement NEWLINE statement_list
   |
   ;

statement: NAME '=' expression { symtbl[$1] = $3; issym[$1] = true; printf("%c set to %d\n",$1+'a',$3); }
   | expression { printf("%d\n", $1); }
   ;

expression: expression '+' NUMBER { $$ = $1 + $3; }
   | expression '-' NUMBER { $$ = $1 + $3; }
   | expression '+' DOUBLE { $$ = $1 + $3; }
   | expression '-' DOUBLE { $$ = $1 + $3; }
   | expression '+' NAME  { if (issym[$1] == true) { $$ = symtbl[$3] + $1; } else {printf("variable %c not set\n",$1+'a'); $$ = 0;} }
   | expression '-' NAME { if (issym[$1] == true) { $$ = symtbl[$3] - $1; } else {printf("variable %c not set\n",$1+'a'); $$ = 0;} }
   | NUMBER { $$ = $1; }
   | DOUBLE { $$ = $1; }
   | NAME { if (issym[$1] == true) { $$ = symtbl[$1]; } else {printf("variable %c not set\n",$1+'a'); $$ = 0;} }
   | EXP '(' expression ')' { $$ = exp($3); }
   | SQRT '(' expression ')' { $$ = sqrt($3); }
   | LOG '(' expression ')' { $$ = log($3); }
   ;

%%


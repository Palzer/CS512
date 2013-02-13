%{
/* example that illustrates using C++ code and flex/bison */
using namespace std;

#include "expr-parse-defs.h"
#include "expr-parse.tab.h"
#include <cstring>
#include <stdio.h>

int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }

%}


%%
"+"   return PLUS; 
"*"   return TIMES;
"("	  return LPAREN;
")"	  return RPAREN;
[a-zA-Z_][a-zA-Z_0-9]* { yylval.cstr = strdup(yytext); return ID; }
[ \t\n]  /* ignore whitespace */
.     return ERROR;
%%

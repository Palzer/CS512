%{
<<<<<<< HEAD
/* example that illustrates using C++ code and flex/bison */
using namespace std;
=======
>>>>>>> finished hw2

#include "expr-parse-defs.h"
#include "expr-parse.tab.h"
#include <cstring>
#include <stdio.h>
<<<<<<< HEAD

int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }
=======
>>>>>>> finished hw2

int yyerror (const char *s) {
    fprintf (stderr, "%s\n", s);
    return 0;
  }
%}

<<<<<<< HEAD

%%
"+"   return PLUS; 
"*"   return TIMES;
"("	  return LPAREN;
")"	  return RPAREN;
[a-zA-Z_][a-zA-Z_0-9]* { yylval.cstr = strdup(yytext); return ID; }
[ \t\n]  /* ignore whitespace */
.     return ERROR;
=======
%%

[\t\n ]			{ /* ignore whitespace */ }			
\(				{ return LPAREN; }
\)				{ return RPAREN; }
\+				{ return PLUS; }
\*				{ return TIMES; }
[a-zA-Z_0-9]*		{ yylval.cstr=strdup(yytext); return ID; }
.         		{ return ERROR; }
>>>>>>> finished hw2
%%

%{
#include "expr-parse.tab.h"
#include <string.h>
#include <stdlib.h>
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
}

%}



%%
"+"   { fprintf(stderr,"plus\n"); return PLUS; }
"*"   { fprintf(stderr,"times\n"); return TIMES;}
"("	  return LPAREN;
")"	  return RPAREN;
[a-zA-Z_][a-zA-Z_0-9]* { yylval.str = strdup(yytext); return ID; }
[ \t\n]  /* ignore whitespace */
.        return yytext[0];
%%

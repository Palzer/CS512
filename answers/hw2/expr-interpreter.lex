%{
#include "expr-interpreter.tab.h"
#include <math.h>
int yyerror (const char *s) {
    fprintf (stderr, "%s\n", s);
    return 0;
  }
%}

%%
[0-9]+    { yylval.num = atoi(yytext); return NUMBER; } /* convert NUMBER token value to integer */
[0-9]+\.[0-9]+ { yylval.dbl = atof(yytext); return DOUBLE; }
[\n]	return NEWLINE;
[ \t]   ;  /* ignore whitespace */
"sqrt"  return SQRT;
"exp" 	return EXP;
"log"	return LOG;
[a-z]     { yylval.num = yytext[0] - 'a'; return NAME; } /* convert NAME token into index */
.         return yytext[0];
%%

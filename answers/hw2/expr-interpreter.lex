%{
#include "expr-interpreter.tab.h"
#include <math.h>
int yyerror (const char *s) {
    fprintf (stderr, "%s\n", s);
    return 0;
  }
%}

%%
[0-9]+    { yylval = atoi(yytext); return NUMBER; } /* convert NUMBER token value to integer */
[0-9]+\.[0-9]+ { return DOUBLE; }
[ \t\n]   ;  /* ignore whitespace */
[a-z]     { yylval = yytext[0] - 'a'; return NAME; } /* convert NAME token into index */
.         return yytext[0];
%%
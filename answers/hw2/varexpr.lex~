%{
#include "simple-varexpr.tab.h"
#include <math.h>
int yyerror (const char *s) {
    fprintf (stderr, "%s\n", s);
    return 0;
  }
%}

%%
[0-9]+    { yylval.rvalue = atoi(yytext); return NUMBER; } /* convert NUMBER token value to integer */
[\n]		return NEWLINE;
[ \t]   ;  /* ignore whitespace */
[a-z]     { yylval.lvalue = yytext[0] - 'a'; return NAME; } /* convert NAME token into index */
.         return yytext[0];
%%

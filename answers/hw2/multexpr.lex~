%{
#include "simple-expr.tab.h"
#include <stdlib.h>
extern int yylval;
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }


%}
%%
[0-9]+   { yylval = atoi(yytext); return NUMBER; }
[a-z]    { yylval = yytext[0]; return NAME; }
[\n]	 { yylval = yytext[0]; return NEWLINE; }
[ \t]  /* ignore whitespace */
.        return yytext[0];
%%

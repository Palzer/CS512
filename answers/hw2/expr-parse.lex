%{

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

[\t\n ]			{ /* ignore whitespace */ }			
\(				{ return LPAREN; }
\)				{ return RPAREN; }
\+				{ return PLUS; }
\*				{ return TIMES; }
[a-zA-Z_0-9]*		{ yylval.cstr=strdup(yytext); return ID; }
.         		{ return ERROR; }
%%

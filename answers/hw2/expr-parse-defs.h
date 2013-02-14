
#ifndef _EXPR_PARSER_DEFS
#define _EXPR_PARSER_DEFS

#include <string>

using namespace std;

extern "C"
{
  int yyerror(const char *);
  int yyparse(void);
  int yylex(void);  
  int yywrap(void);
}

#endif


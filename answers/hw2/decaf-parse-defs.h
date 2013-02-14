
#ifndef _DECAF_PARSER_DEFS
#define _DECAF_PARSER_DEFS

#include <string>

using namespace std;

extern int lineno;
extern int tokenpos;

extern "C"
{
  int yyerror(const char *);
  
  int yyparse(void);
  int yylex(void);  
  int yywrap(void);
}

#endif


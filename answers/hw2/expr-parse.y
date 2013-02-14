%{
#include "expr-parse-defs.h"
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>
#include <stdio.h>

  using namespace std;

  string *build_tree(const char *root, int n,...) {
    string *tree = new string;
    ostringstream s;
    va_list dtrs;
    va_start(dtrs, n);
    s << "(" << root;
    for (string *dtr = va_arg(dtrs, string *); n; dtr = va_arg(dtrs, string *), --n) {
      s << " " << *dtr;
      //delete dtr;
    }
    s << ")";
    *tree = string(s.str());
    return tree;
  }
	string str1;
%}

%union {
	char *cstr;
	string *sval;
}

%type <sval> s e t f

%token <cstr> ID
%token PLUS
%token TIMES
%token LPAREN
%token RPAREN
%token ERROR

%%
s:
	e { cout << *($1) << endl; }
	;

e:
	e PLUS t { str1 = "(PLUS +)"; $$ = build_tree("e", 3, $1, &str1, $3); }
	|
	t { $$ = build_tree("e", 1, $1); }
	;

t:
	t TIMES f { str1 = "(TIMES *)"; $$ = build_tree("t", 3, $1, &str1, $3); }
	|
	f { $$ = build_tree("t", 1, $1); }
	;

f:
	LPAREN e RPAREN { str1 = string("(LPAREN \\()") + *$2 + string("(RPAREN \\))"); $$ = build_tree("f", 1, &str1); } 
	|
	ID { str1 = string("(ID ") + $1 + string(")"); $$ = build_tree("f", 1, &str1); }
	;
%%


%{
#include "expr-parse-defs.h"
#include <stdio.h>
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>

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

%}

%union{
	char* cstr;
	string *sval;
}

%token <cstr> ID
%token PLUS TIMES RPAREN LPAREN ERROR

%type <sval> E e t f


%%
//call in each rule to buildtree(root, numarguments, arg1,arg2,...) 
//args are string pointers
//assign buildtree to $$, print $1 at end

E : e { cout << *$1 << endl;}
    ;

e : e PLUS t {string str = "(PLUS +)"; $$ = build_tree("e", 3, $1, &str, $3);}
	| t { $$ = build_tree("e", 1, $1);}
	;

t : t TIMES f {string str = "(TIMES *)"; $$ = build_tree("t", 3, $1, &str, $3); }
	| f { $$ = build_tree("t", 1, $1); }
	;
	
f : LPAREN e RPAREN {string strl = "(LPAREN \\()"; string strr = "(RPAREN \\))"; $$ = build_tree("t", 3, &strl, $2, &strr);}
	| ID {string str = string("(ID") + $1 + string(" )"); $$ = build_tree("e", 1, &str);}
	;

%%


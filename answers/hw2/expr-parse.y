%{
#include "expr-parse-defs.h"
<<<<<<< HEAD
#include <stdio.h>
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>

using namespace std;
=======
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>
#include <stdio.h>

  using namespace std;
>>>>>>> finished hw2

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
<<<<<<< HEAD

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
	| ID {string str = string("(ID ") + $1 + string(")"); $$ = build_tree("e", 1, &str);}
=======
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
>>>>>>> finished hw2
	;

f:
	LPAREN e RPAREN { str1 = string("(LPAREN \\()") + *$2 + string("(RPAREN \\))"); $$ = build_tree("f", 1, &str1); } 
	|
	ID { str1 = string("(ID ") + $1 + string(")"); $$ = build_tree("f", 1, &str1); }
	;
%%


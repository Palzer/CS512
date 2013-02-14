%{
#include "decaf-parse-defs.h"
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
    }
    s << ")";
    *tree = string(s.str());
    return tree;
  }
	string str1 = string("\\(");
	string str2 = string("\\)");
	string blank = string("EPSILON");
%}

%union { string *sval; }

%token <sval> T_AND T_ASSIGN T_BOOLTYPE T_BREAK T_CHARCONSTANT T_CLASS T_COMMENT T_COMMA T_CONTINUE T_DIV T_DOT T_ELSE T_EQ T_EXTENDS T_EXTERN T_FALSE T_FOR T_GEQ T_GT T_IF T_INTCONSTANT T_INTTYPE T_LCB T_LEFTSHIFT T_LEQ T_LPAREN T_LSB T_LT T_MINUS T_MOD T_MULT T_NEQ T_NEW T_NOT T_NULL T_OR T_PLUS T_RCB T_RETURN T_RIGHTSHIFT T_RPAREN T_RSB T_SEMICOLON T_STRINGTYPE T_STRINGCONSTANT T_TRUE T_VOID T_WHILE T_ID T_WHITESPACE

%left T_LT T_GT T_LEQ T_GEQ T_EQ T_NEQ T_AND T_OR T_NOT
%left T_RIGHTSHIFT T_LEFTSHIFT
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_MOD

%type <sval> s program extern_defn_list extern_defn extern_type_list extern_type field_decl_list field_decl method_decl_list method_decl id_list type_id_list block var_decl var_decl_list id_comma_list type statement statement_list assign_list assign method_call method_arg_list method_arg l_value expr constant bool_constant

%%

s: program { cout << *$1 << endl; }
	;

program: extern_defn_list T_CLASS T_ID T_LCB field_decl_list method_decl_list T_RCB 		{ $$ = build_tree("program", 7, $1, $2, $3, $4, $5, $6, $7); }
	| extern_defn_list T_CLASS T_ID T_LCB field_decl_list T_RCB 					{ $$ = build_tree("program", 6, $1, $2, $3, $4, $5, $6); }
	| extern_defn_list T_CLASS T_ID T_LCB method_decl_list T_RCB 					{ $$ = build_tree("program", 6, $1, $2, $3, $4, $5, $6); }
	| T_CLASS T_ID T_LCB field_decl_list method_decl_list T_RCB 					{ $$ = build_tree("program", 6, $1, $2, $3, $4, $5, $6); }
	| T_CLASS T_ID T_LCB field_decl_list T_RCB 									{ $$ = build_tree("program", 5, $1, $2, $3, $4, $5); }
	| T_CLASS T_ID T_LCB method_decl_list T_RCB 									{ $$ = build_tree("program", 5, $1, $2, $3, $4, $5); }
	;

extern_defn_list: extern_defn extern_defn_list 	{ $$ = build_tree("extern_defn_list", 2, $1, $2); }
	| extern_defn 							{ $$ = build_tree("extern_defn_list", 1, $1); }
	;

extern_defn: T_EXTERN type T_ID T_LPAREN extern_type_list T_RPAREN T_SEMICOLON 	{ $$ = build_tree("extern_defn", 7, $1, $2, $3, &str1, $5, &str2, $7); }
	| T_EXTERN T_VOID T_ID T_LPAREN extern_type_list T_RPAREN T_SEMICOLON 	{ $$ = build_tree("extern_defn", 7, $1, $2, $3, &str1, $5, &str2, $7); }
	;

extern_type_list: extern_type T_COMMA extern_type_list 	{ $$ = build_tree("extern_type_list", 1, $1); }
	| extern_type 									{ $$ = build_tree("extern_type_list", 1, $1); }
	| { $$ = &blank; }
	;

extern_type: T_STRINGTYPE 	{ $$ = build_tree("extern_type", 1, $1); }
	| type 				{ $$ = build_tree("extern_type", 1, $1); }
	;

field_decl_list: field_decl 		{ $$ = build_tree("field_decl_list", 1, $1); }
	| field_decl_list field_decl 	{ $$ = build_tree("field_decl_list", 2, $1, $2); }
	;

method_decl_list: method_decl 		{ $$ = build_tree("method_decl_list", 1, $1); }
	| method_decl_list method_decl 	{ $$ = build_tree("method_decl_list", 2, $1, $2); }
	;

field_decl: type T_ID T_SEMICOLON 									{ $$ = build_tree("field_decl", 3, $1, $2, $3); }
	| type T_ID T_ASSIGN constant T_SEMICOLON 						{ $$ = build_tree("field_decl", 5, $1, $2, $3, $4, $5); }
	| type T_ID T_COMMA id_list T_SEMICOLON 						{ $$ = build_tree("field_decl", 5, $1, $2, $3, $4, $5); }
	| type T_ID T_LSB T_INTCONSTANT T_RSB T_COMMA id_list T_SEMICOLON 	{ $$ = build_tree("field_decl", 8, $1, $2, $3, $4, $5, $6, $7, $8); }
	| type T_ID T_LSB T_INTCONSTANT T_RSB T_SEMICOLON 				{ $$ = build_tree("field_decl", 6, $1, $2, $3, $4, $5, $6); }
	;

id_list: id_list T_COMMA T_ID 						{ $$ = build_tree("id_list", 3, $1, $2, $3); }
	| id_list T_COMMA T_ID T_LSB T_INTCONSTANT T_RSB 		{ $$ = build_tree("id_list", 6, $1, $2, $3, $4, $5, $6); }
	| T_ID 										{ $$ = build_tree("id_list", 1, $1); }
	;

method_decl: type T_ID T_LPAREN type_id_list T_RPAREN block 	{ $$ = build_tree("method_decl", 6, $1, $2, &str1, $4, &str2, $6); }
	| T_VOID T_ID T_LPAREN type_id_list T_RPAREN block 		{ $$ = build_tree("method_decl", 6, $1, $2, &str1, $4, &str2, $6); }
	;

type_id_list: type T_ID T_COMMA type_id_list 	{ $$ = build_tree("type_id_list", 4, $1, $2, $3, $4); }
	| type T_ID 							{ $$ = build_tree("type_id_list", 2, $1, $2); }
	| { $$ = &blank; }
	;

block: T_LCB var_decl_list statement_list T_RCB 	{ $$ = build_tree("block", 4, $1, $2, $3, $4); }
	| T_LCB var_decl_list T_RCB				{ $$ = build_tree("block", 3, $1, $2, $3); }
	| T_LCB statement_list T_RCB				{ $$ = build_tree("block", 3, $1, $2, $3); }
	| T_LCB T_RCB							{ $$ = build_tree("block", 2, $1, $2); }
	;

var_decl_list: var_decl var_decl_list		{ $$ = build_tree("var_decl_list", 2, $1, $2); }
	| var_decl						{ $$ = build_tree("var_decl_list", 1, $1); }
	;

var_decl: type id_comma_list T_SEMICOLON 	{ $$ = build_tree("var_decl", 2, $1, $2); }
	;

statement_list: statement statement_list	{ $$ = build_tree("statement_list", 2, $1, $2); }
	| statement						{ $$ = build_tree("statement_list", 1, $1); }
	;

id_comma_list: id_comma_list T_COMMA T_ID 		{ $$ = build_tree("id_list", 3, $1, $2, $3); }
	| T_ID 								{ $$ = build_tree("id_list", 1, $1); }
	;

type: T_INTTYPE 	{ $$ = build_tree("type", 1, $1); }
	| T_BOOLTYPE 	{ $$ = build_tree("type", 1, $1); }
	;

statement: assign T_SEMICOLON 													{ $$ = build_tree("statement", 2, $1, $2); }
	| method_call T_SEMICOLON 													{ $$ = build_tree("statement", 2, $1, $2); }
	| T_IF T_LPAREN expr T_RPAREN block T_ELSE block 									{ $$ = build_tree("statement", 7, $1, &str1, $3, &str2, $5, $6, $7); }
	| T_IF T_LPAREN expr T_RPAREN block 											{ $$ = build_tree("statement", 5, $1, &str1, $3, &str2, $5); }
	| T_WHILE T_LPAREN expr T_RPAREN block 											{ $$ = build_tree("statement", 5, $1, &str1, $3, &str2, $5); }
	| T_FOR T_LPAREN assign_list T_SEMICOLON expr T_SEMICOLON assign_list T_RPAREN block 	{ $$ = build_tree("statement", 9, $1, &str1, $3, $4, $5, $6, $7, &str2, $9); }
	| T_RETURN T_LPAREN expr T_RPAREN T_SEMICOLON 									{ $$ = build_tree("statement", 5, $1, &str1, $3, &str2, $5); }
	| T_RETURN T_LPAREN T_RPAREN T_SEMICOLON 										{ $$ = build_tree("statement", 4, $1, &str1, &str2, $4); }
	| T_RETURN T_SEMICOLON														{ $$ = build_tree("statement", 2, $1, $2); }
	| T_BREAK T_SEMICOLON 														{ $$ = build_tree("statement", 2, $1, $2); }
	| T_CONTINUE T_SEMICOLON 													{ $$ = build_tree("statement", 2, $1, $2); }
	| block 																	{ $$ = build_tree("statement", 1, $1); }
	;

assign_list: assign_list T_COMMA assign 	{ $$ = build_tree("assign_list", 3, $1, $2, $3); }
	| assign 							{ $$ = build_tree("assign_list", 1, $1); }
	;

assign: l_value T_ASSIGN expr 	{ $$ = build_tree("assign", 3, $1, $2, $3); }
	;

method_call: T_ID T_LPAREN method_arg_list T_RPAREN 	{ $$ = build_tree("method_call", 4, $1, &str1, $3, &str2); }
	| T_ID T_LPAREN T_RPAREN 					{ $$ = build_tree("method_call", 3, $1, &str1, &str2); }
	;

method_arg_list: method_arg_list T_COMMA method_arg 	{ $$ = build_tree("method_arg_list", 3, $1, $2, $3); }
	| method_arg 								{ $$ = build_tree("method_arg_list", 1, $1); }
	;

method_arg: expr 			{ $$ = build_tree("method_arg", 1, $1); }
	| T_STRINGCONSTANT 		{ $$ = build_tree("method_arg", 1, $1); }
	;

l_value: T_ID T_LSB expr T_RSB 	{ $$ = build_tree("l_value", 4, $1, $2, $3, $4); }
	| T_ID 					{ $$ = build_tree("l_value", 1, $1); }
	;

expr: l_value 					{ $$ = build_tree("expr", 1, $1); }
	| method_call 				{ $$ = build_tree("expr", 1, $1); }
	| constant 				{ $$ = build_tree("expr", 1, $1); }
	| expr T_PLUS expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_MINUS expr 		{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_MULT expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_DIV expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_RIGHTSHIFT expr 	{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_LEFTSHIFT expr 		{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_MOD expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_LT expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_GT expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_LEQ expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_GEQ expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_EQ expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_NEQ expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_AND expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| expr T_OR expr 			{ $$ = build_tree("expr", 3, $1, $2, $3); }
	| T_MINUS expr 			{ $$ = build_tree("expr", 2, $1, $2); }
	| T_NOT expr 				{ $$ = build_tree("expr", 2, $1, $2); }
	| T_LPAREN expr T_RPAREN 	{ $$ = build_tree("expr", 3, &str1, $2, &str2); }
	;

constant: T_INTCONSTANT 		{ $$ = build_tree("constant", 1, $1); }
	| T_CHARCONSTANT 		{ $$ = build_tree("constant", 1, $1); }
	| bool_constant 		{ $$ = build_tree("constant", 1, $1); }
	;

bool_constant: T_TRUE 	{ $$ = build_tree("bool_constant", 1, $1); }
	| T_FALSE 		{ $$ = build_tree("bool_constant", 1, $1); }
	;

%%

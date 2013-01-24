%{
#include <stdio.h>
int yycolno = 1;
char error[100];
int error_length = 0;
void print_error();
%}

charconstant 	\'(\\[tvrnafb\\']|[^'\\\n])\'
intconstant		[0-9]+|"0x"[0-9a-fA-F]+
stringconstant	\"(\\[tvrnafb\\]|[^\\"\n])*\"
id				[a-zA-Z_][a-zA-Z_0-9]*
whitespace		[ \t\n\v\f\r]
%%

"&&"								print_error(); printf("T_AND\n"); yycolno = yycolno + yyleng;
"="									print_error(); printf("T_ASSIGN\n");  yycolno = yycolno + yyleng;
bool								print_error(); printf("T_BOOLTYPE\n"); yycolno = yycolno + yyleng;
break								print_error(); printf("T_BREAK\n"); yycolno = yycolno + yyleng;
{charconstant}						print_error(); printf("T_CHARCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
class								print_error(); printf("T_CLASS\n"); yycolno = yycolno + yyleng;
"//".*								print_error(); printf("T_COMMENT %s\n",yytext); yycolno = yycolno + yyleng;
"," 								print_error(); printf("T_COMMA\n"); yycolno = yycolno + yyleng;
continue							print_error(); printf("T_CONTINUE\n"); yycolno = yycolno + yyleng;
"/"									print_error(); printf("T_DIV\n"); yycolno = yycolno + yyleng;
"."									print_error(); printf("T_DOT\n"); yycolno = yycolno + yyleng;
else								print_error(); printf("T_ELSE\n"); yycolno = yycolno + yyleng;
"=="								print_error(); printf("T_EQ\n"); yycolno = yycolno + yyleng;
extends								print_error(); printf("T_EXTENDS\n"); yycolno = yycolno + yyleng;
extern								print_error(); printf("T_EXTERN\n"); yycolno = yycolno + yyleng;
false								print_error(); printf("T_FALSE\n"); yycolno = yycolno + yyleng;
for									print_error(); printf("T_FOR\n"); yycolno = yycolno + yyleng;
">="								print_error(); printf("T_GEQ\n"); yycolno = yycolno + yyleng;
">"									print_error(); printf("T_GT\n"); yycolno = yycolno + yyleng;
if									print_error(); printf("T_IF\n"); yycolno = yycolno + yyleng;
{intconstant}						print_error(); printf("T_INTCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
int									print_error(); printf("T_INTTYPE\n"); yycolno = yycolno + yyleng;
"{"									print_error(); printf("T_LCB\n"); yycolno = yycolno + yyleng;
"<<"								print_error(); printf("T_LEFTSHIFT\n"); yycolno = yycolno + yyleng;
"<="								print_error(); printf("T_LEQ\n"); yycolno = yycolno + yyleng;
"("									print_error(); printf("T_LPAREN\n"); yycolno = yycolno + yyleng;
"["									print_error(); printf("T_LSB\n"); yycolno = yycolno + yyleng;
"<"									print_error(); printf("T_LT\n"); yycolno = yycolno + yyleng;
"-"									print_error(); printf("T_MINUS\n"); yycolno = yycolno + yyleng;
"%"									print_error(); printf("T_MOD\n"); yycolno = yycolno + yyleng;
"*"									print_error(); printf("T_MULT\n"); yycolno = yycolno + yyleng;
"!="								print_error(); printf("T_NEQ\n"); yycolno = yycolno + yyleng;
new									print_error(); printf("T_NEW\n"); yycolno = yycolno + yyleng;
"!"									print_error(); printf("T_NOT\n"); yycolno = yycolno + yyleng;
null								print_error(); printf("T_NULL\n"); yycolno = yycolno + yyleng;
"||"								print_error(); printf("T_OR\n"); yycolno = yycolno + yyleng;
"+"									print_error(); printf("T_PLUS\n"); yycolno = yycolno + yyleng;
"}"									print_error(); printf("T_RCB\n"); yycolno = yycolno + yyleng;
return								print_error(); printf("T_RETURN\n"); yycolno = yycolno + yyleng;
">>"								print_error(); printf("T_RIGHTSHIFT\n"); yycolno = yycolno + yyleng;
")"									print_error(); printf("T_RPAREN\n"); yycolno = yycolno + yyleng;
"]"									print_error(); printf("T_RSB\n"); yycolno = yycolno + yyleng;
";"									print_error(); printf("T_SEMICOLON\n"); yycolno = yycolno + yyleng;
string								print_error(); printf("T_STRINGTYPE\n"); yycolno = yycolno + yyleng;
{stringconstant}					print_error(); printf("T_STRINGCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
true								print_error(); printf("T_TRUE\n"); yycolno = yycolno + yyleng;
void								print_error(); printf("T_VOID\n"); yycolno = yycolno + yyleng;
while								print_error(); printf("T_WHILE\n"); yycolno = yycolno + yyleng;
{id}								print_error(); printf("T_ID %s\n",yytext); yycolno = yycolno + yyleng;
{whitespace}						print_error(); if (strcmp("\n",yytext) == 0){ yytext = "\\n"; yylineno++; yycolno = 1;} else {yycolno = yycolno + yyleng;} printf("T_WHITESPACE %s\n",yytext);
.									error[error_length] = yytext[0]; error_length++; error[error_length] = 0;//printf("unrecognized token: %s, on line %i, columns %i-%i\n",yytext,yylineno,yycolno,yycolno+yyleng-1); yycolno = yycolno + yyleng;

%%

void print_error(){

	if (error_length > 0){
		printf("unrecognized token: %s, on line %i, columns %i-%i\n",error,yylineno,yycolno,yycolno+error_length-1); yycolno = yycolno + error_length;
		error_length = 0;
	}
}


%{
#include <stdio.h>
int yycolno = 1;
%}

%%

"&&"								printf("T_AND\n"); yycolno = yycolno + yyleng;
"="									printf("T_ASSIGN\n");  yycolno = yycolno + yyleng;
bool								printf("T_BOOLTYPE\n"); yycolno = yycolno + yyleng;
break								printf("T_BREAK\n"); yycolno = yycolno + yyleng;
\'(\\[tvrnafb\\']|[^'\\\n])\'		printf("T_CHARCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
class								printf("T_CLASS\n"); yycolno = yycolno + yyleng;
"//".*								printf("T_COMMENT %s\n",yytext); yycolno = yycolno + yyleng;
"," 								printf("T_COMMA\n"); yycolno = yycolno + yyleng;
continue							printf("T_CONTINUE\n"); yycolno = yycolno + yyleng;
"/"									printf("T_DIV\n"); yycolno = yycolno + yyleng;
"."									printf("T_DOT\n"); yycolno = yycolno + yyleng;
else								printf("T_ELSE\n"); yycolno = yycolno + yyleng;
"=="								printf("T_EQ\n"); yycolno = yycolno + yyleng;
extends								printf("T_EXTENDS\n"); yycolno = yycolno + yyleng;
extern								printf("T_EXTERN\n"); yycolno = yycolno + yyleng;
false								printf("T_FALSE\n"); yycolno = yycolno + yyleng;
for									printf("T_FOR\n"); yycolno = yycolno + yyleng;
">="								printf("T_GEQ\n"); yycolno = yycolno + yyleng;
">"									printf("T_GT\n"); yycolno = yycolno + yyleng;
if									printf("T_IF\n"); yycolno = yycolno + yyleng;
[0-9]+|"0x"[0-9a-fA-F]+				printf("T_INTCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
int									printf("T_INTTYPE\n"); yycolno = yycolno + yyleng;
"{"									printf("T_LCB\n"); yycolno = yycolno + yyleng;
"<<"								printf("T_LEFTSHIFT\n"); yycolno = yycolno + yyleng;
"<="								printf("T_LEQ\n"); yycolno = yycolno + yyleng;
"("									printf("T_LPAREN\n"); yycolno = yycolno + yyleng;
"["									printf("T_LSB\n"); yycolno = yycolno + yyleng;
"<"									printf("T_LT\n"); yycolno = yycolno + yyleng;
"-"									printf("T_MINUS\n"); yycolno = yycolno + yyleng;
"%"									printf("T_MOD\n"); yycolno = yycolno + yyleng;
"*"									printf("T_MULT\n"); yycolno = yycolno + yyleng;
"!="								printf("T_NEQ\n"); yycolno = yycolno + yyleng;
new									printf("T_NEW\n"); yycolno = yycolno + yyleng;
"!"									printf("T_NOT\n"); yycolno = yycolno + yyleng;
null								printf("T_NULL\n"); yycolno = yycolno + yyleng;
"||"								printf("T_OR\n"); yycolno = yycolno + yyleng;
"+"									printf("T_PLUS\n"); yycolno = yycolno + yyleng;
"}"									printf("T_RCB\n"); yycolno = yycolno + yyleng;
return								printf("T_RETURN\n"); yycolno = yycolno + yyleng;
">>"								printf("T_RIGHTSHIFT\n"); yycolno = yycolno + yyleng;
")"									printf("T_RPAREN\n"); yycolno = yycolno + yyleng;
"]"									printf("T_RSB\n"); yycolno = yycolno + yyleng;
";"									printf("T_SEMICOLON\n"); yycolno = yycolno + yyleng;
string								printf("T_STRINGTYPE\n"); yycolno = yycolno + yyleng;
\"(\\[tvrnafb\\]|[^\\"\n])*\"		printf("T_STRINGCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
true								printf("T_TRUE\n"); yycolno = yycolno + yyleng;
void								printf("T_VOID\n"); yycolno = yycolno + yyleng;
while								printf("T_WHILE\n"); yycolno = yycolno + yyleng;
[a-zA-Z_][a-zA-Z_0-9]*				printf("T_ID %s\n",yytext); yycolno = yycolno + yyleng;
[ \t\n\v\f\r]						if (strcmp("\n",yytext) == 0){ yytext = "\\n"; yylineno++; yycolno = 1;} else {yycolno = yycolno + yyleng;} printf("T_WHITESPACE %s\n",yytext);
[^ \n()\[\]\=\;\,\/\.\>\{\<\}\*\-\%\!\|\+&\^]*						printf("unrecognized token: %s, on line %i, columns %i-%i\n",yytext,yylineno,yycolno,yycolno+yyleng-1); yycolno = yycolno + yyleng;
[&\|\^]									printf("unrecognized token: %s, on line %i, columns %i-%i\n",yytext,yylineno,yycolno,yycolno+yyleng-1); yycolno = yycolno + yyleng;

%%


%{
#include <stdio.h>
%}

%%

"&&"								printf("T_AND\n");
"="									printf("T_ASSIGN\n");
bool								printf("T_BOOLTYPE\n");
break								printf("T_BREAK\n");
\'(\\[tvrnafb\\']|[^'\\\n])\'		printf("T_CHARCONSTANT %s\n",yytext);
class								printf("T_CLASS\n");
"//".*								printf("T_COMMENT %s\n",yytext); yylineno++;
"," 								printf("T_COMMA\n");
continue							printf("T_CONTINUE\n");
"/"									printf("T_DIV\n");
"."									printf("T_DOT\n");
else								printf("T_ELSE\n");
"=="								printf("T_EQ\n");
extends								printf("T_EXTENDS\n");
extern								printf("T_EXTERN\n");
false								printf("T_FALSE\n");
for									printf("T_FOR\n");
">="								printf("T_GEQ\n");
">"									printf("T_GT\n");
if									printf("T_IF\n");
[0-9]+|"0x"[0-9a-fA-F]+				printf("T_INTCONSTANT %s\n",yytext);
int									printf("T_INTTYPE\n");
"{"									printf("T_LCB\n");
"<<"								printf("T_LEFTSHIFT\n");
"<="								printf("T_LEQ\n");
"("									printf("T_LPAREN\n");
"["									printf("T_LSB\n");
"<"									printf("T_LT\n");
"-"									printf("T_MINUS\n");
"%"									printf("T_MOD\n");
"*"									printf("T_MULT\n");
"!="								printf("T_NEQ\n");
new									printf("T_NEW\n");
"!"									printf("T_NOT\n");
null								printf("T_NULL\n");
"||"								printf("T_OR\n");
"+"									printf("T_PLUS\n");
"}"									printf("T_RCB\n");
return								printf("T_RETURN\n");
">>"								printf("T_RIGHTSHIFT\n");
")"									printf("T_RPAREN\n");
"]"									printf("T_RSB\n");
";"									printf("T_SEMICOLON\n");
string								printf("T_STRINGTYPE\n");
\"(\\[tvrnafb\\]|[^\\"\n])*\"		printf("T_STRINGCONSTANT %s\n",yytext);
true								printf("T_TRUE\n");
void								printf("T_VOID\n");
while								printf("T_WHILE\n");
[a-zA-Z_][a-zA-Z_0-9]*				printf("T_ID %s\n",yytext);
[ \t\n\v\f\r]						if (strcmp("\n",yytext) == 0){ yytext = "\\n"; yylineno++; } printf("T_WHITESPACE %s\n",yytext);
[^ \n()\[\]\=\;\,\/\.\>\{\<\}\*\-\%\!\|\+]*						printf("unrecognized token: %s\n",yytext);

%%

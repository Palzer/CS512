%{
#include <stdio.h>
int yycolno = 1;
char error[100];
int error_length = 0;
int i;
void print_error();
void print_error_info();
%}

charconstant 	\'(\\[tvrnafb\\']|[^'\\\n])\'
intconstant		[0-9]+|"0x"[0-9a-fA-F]+
stringconstant	\"(\\[tvrnafb"\\]|[^\\"\n])+\"
id				[a-zA-Z_][a-zA-Z_0-9]*
whitespace		[ \t\n\v\f\r]
escape (\\[tvrnafb\\])
%%


"&&"								print_error(); printf("T_AND %s\n", yytext); yycolno = yycolno + yyleng;
"="									print_error(); printf("T_ASSIGN %s\n", yytext);  yycolno = yycolno + yyleng;
bool								print_error(); printf("T_BOOLTYPE %s\n", yytext); yycolno = yycolno + yyleng;
break								print_error(); printf("T_BREAK %s\n", yytext); yycolno = yycolno + yyleng;
{charconstant}						print_error(); printf("T_CHARCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
class								print_error(); printf("T_CLASS %s\n", yytext); yycolno = yycolno + yyleng;
"//".*[\n]								yytext[yyleng-1] = 0; print_error(); printf("T_COMMENT %s\\n\n",yytext); yycolno = yycolno + yyleng;                            
"," 								print_error(); printf("T_COMMA %s\n", yytext); yycolno = yycolno + yyleng;
continue							print_error(); printf("T_CONTINUE %s\n", yytext); yycolno = yycolno + yyleng;
"/"									print_error(); printf("T_DIV %s\n", yytext); yycolno = yycolno + yyleng;
"."									print_error(); printf("T_DOT %s\n", yytext); yycolno = yycolno + yyleng;
else								print_error(); printf("T_ELSE %s\n", yytext); yycolno = yycolno + yyleng;
"=="								print_error(); printf("T_EQ %s\n", yytext); yycolno = yycolno + yyleng;
extends								print_error(); printf("T_EXTENDS %s\n", yytext); yycolno = yycolno + yyleng;
extern								print_error(); printf("T_EXTERN %s\n", yytext); yycolno = yycolno + yyleng;
false								print_error(); printf("T_FALSE %s\n", yytext); yycolno = yycolno + yyleng;
for									print_error(); printf("T_FOR %s\n", yytext); yycolno = yycolno + yyleng;
">="								print_error(); printf("T_GEQ %s\n", yytext); yycolno = yycolno + yyleng;
">"									print_error(); printf("T_GT %s\n", yytext); yycolno = yycolno + yyleng;
if									print_error(); printf("T_IF %s\n", yytext); yycolno = yycolno + yyleng;
{intconstant}						print_error(); printf("T_INTCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
int									print_error(); printf("T_INTTYPE %s\n", yytext); yycolno = yycolno + yyleng;
"{"									print_error(); printf("T_LCB %s\n", yytext); yycolno = yycolno + yyleng;
"<<"								print_error(); printf("T_LEFTSHIFT %s\n", yytext); yycolno = yycolno + yyleng;
"<="								print_error(); printf("T_LEQ %s\n", yytext); yycolno = yycolno + yyleng;
"("									print_error(); printf("T_LPAREN %s\n", yytext); yycolno = yycolno + yyleng;
"["									print_error(); printf("T_LSB %s\n", yytext); yycolno = yycolno + yyleng;
"<"									print_error(); printf("T_LT %s\n", yytext); yycolno = yycolno + yyleng;
"-"									print_error(); printf("T_MINUS %s\n", yytext); yycolno = yycolno + yyleng;
"%"									print_error(); printf("T_MOD %s\n", yytext); yycolno = yycolno + yyleng;
"*"									print_error(); printf("T_MULT %s\n", yytext); yycolno = yycolno + yyleng;
"!="								print_error(); printf("T_NEQ %s\n", yytext); yycolno = yycolno + yyleng;
new									print_error(); printf("T_NEW %s\n", yytext); yycolno = yycolno + yyleng;
"!"									print_error(); printf("T_NOT %s\n", yytext); yycolno = yycolno + yyleng;
null								print_error(); printf("T_NULL %s\n", yytext); yycolno = yycolno + yyleng;
"||"								print_error(); printf("T_OR %s\n", yytext); yycolno = yycolno + yyleng;
"+"									print_error(); printf("T_PLUS %s\n", yytext); yycolno = yycolno + yyleng;
"}"									print_error(); printf("T_RCB %s\n", yytext); yycolno = yycolno + yyleng;
return								print_error(); printf("T_RETURN %s\n", yytext); yycolno = yycolno + yyleng;
">>"								print_error(); printf("T_RIGHTSHIFT %s\n", yytext); yycolno = yycolno + yyleng;
")"									print_error(); printf("T_RPAREN %s\n", yytext); yycolno = yycolno + yyleng;
"]"									print_error(); printf("T_RSB %s\n", yytext); yycolno = yycolno + yyleng;
";"									print_error(); printf("T_SEMICOLON %s\n", yytext); yycolno = yycolno + yyleng;
string								print_error(); printf("T_STRINGTYPE %s\n", yytext); yycolno = yycolno + yyleng;
{stringconstant}					print_error(); printf("T_STRINGCONSTANT %s\n",yytext); yycolno = yycolno + yyleng;
true								print_error(); printf("T_TRUE %s\n", yytext); yycolno = yycolno + yyleng;
void								print_error(); printf("T_VOID %s\n", yytext); yycolno = yycolno + yyleng;
while								print_error(); printf("T_WHILE %s\n", yytext); yycolno = yycolno + yyleng;
{id}								print_error(); printf("T_ID %s\n", yytext); yycolno = yycolno + yyleng;
{whitespace}+					{   print_error(); printf("T_WHITESPACE ");
                                    for (i = 0; i < yyleng; i++) 
                                    {
                                       if (yytext[i] == ' ')
                                          printf(" ");
                                       if (yytext[i] == '\t')
                                          printf("\t");
                                       if (yytext[i] == '\n')
                                          printf("\\n");
                                       if (yytext[i] == '\v')
                                          printf("\\v");
                                       if (yytext[i] == '\f')
                                          printf("\\f");
                                       if (yytext[i] == '\r')
                                          printf("\\r");                                   
                                    }
                                    printf("\n");
                                }


\'\\[^[tvrnafb'\\]]\'               fprintf(stderr, "Error: Unknown escape sequence in string constant:"); print_error_info(); 
\'[\n]\'                            fprintf(stderr, "Error: Character constant contains newline:"); print_error_info();   
\'[^\'][^\']++\'                    fprintf(stderr, "Error: Character constant length is greater than one:"); print_error_info(); 
\'\\\'                              fprintf(stderr, "Error: Unterminated character :"); print_error_info();
\'\'                                fprintf(stderr, "Error: Character constant contain zero characters :"); print_error_info();
\'[^\'\n][^\'\n][\n]                fprintf(stderr, "Error: Unterminated character constant:"); print_error_info(); 

\"[^\"\n][^\"\n]+[\n]               fprintf(stderr, "Error: Unterminated string constant:"); print_error_info(); 
\"..+\"                             fprintf(stderr, "Error: String constant has invalid closing delimiter:"); print_error_info();
\"[^\"]*[\\][^[tvrnafb"\\]][^\"]**\" fprintf(stderr, "Error: Unknown escape sequence in string constant:"); print_error_info();
\"[\n]                              fprintf(stderr, "Error: Newline in string constant:"); print_error_info(); 


.									error[error_length] = yytext[0]; error_length++; error[error_length] = 0;//printf("unrecognized token: %s, on line %i, columns %i-%i\n",yytext,yylineno,yycolno,yycolno+yyleng-1); yycolno = yycolno + yyleng;

%%

void print_error(){

	if (error_length > 0){
		fprintf(stderr, "Error: Unrecognized token: %s, on line %i, columns %i-%i\n",error,yylineno,yycolno,yycolno+error_length-1); yycolno = yycolno + error_length;
		error_length = 0;
		exit(1);
	}
}

void print_error_info(){
	fprintf(stderr, "%s, on line %i, columns %i-%i\n",yytext,yylineno,yycolno,yycolno+yycolno+yyleng-1);
	exit(1);
}


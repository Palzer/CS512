%{
#include <stdio.h>
#define T_A 	256
#define T_B 	257
#define T_C		258
%}

%%

a				{return T_A;}
abb				{return T_B;} 
a*b+			{return T_C;} 

%%

int main() {
	int token;
	while (token = yylex()) {
		switch (token) {
			case T_A: fprintf(stderr,"T_A: %s\n",yytext); break;
			case T_B: fprintf(stderr,"T_B: %s\n",yytext); break;
			case T_C: fprintf(stderr,"T_C: %s\n",yytext); break;
			default: fprintf(stderr,"Error: %s not recognized\n", yytext);
		}
	}
	exit(0);
}

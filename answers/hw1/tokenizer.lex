%{
#include <stdio.h>
#define T_A 	256
#define T_B 	257
#define T_C		258
#define ERROR   259
#define NEWLINE 260
%}

%%

a				{return T_A;}
abb				{return T_B;} 
a*b+			{return T_C;} 
.               {return ERROR;}
"\n"            {return NEWLINE;}

%%

int main() {
	int token;
	while (token = yylex()) {
		switch (token) {
			case T_A: printf("T_A %s\n",yytext); break;
			case T_B: printf("T_B %s\n",yytext); break;
			case T_C: printf("T_C %s\n",yytext); break;
			case ERROR: printf("ERROR %s\n", yytext);
			case NEWLINE: printf("");
		}
	}
	exit(0);
}

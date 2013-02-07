%{
#include <stdio.h>
%}

%union{
	char* str;
}

%token <str> IDgit 
%token PLUS TIMES RPAREN LPAREN

%%
e : e PLUS t { fprintf(stderr,"e -> e + t\n"); }
	| t { fprintf(stderr,"e -> t\n"); }
	;

t : t TIMES f { fprintf(stderr,"t -> t * f\n"); }
	| f { fprintf(stderr,"t -> f\n"); }
	;
	
f : LPAREN e RPAREN { fprintf(stderr,"f -> e\n"); }
	| ID { fprintf(stderr,"ID: %s\n",$1); }
	;

%%


%{
#include <stdio.h>
int i;
%}

%s BLOCK_COMMENT
%s LINE_COMMENT
%s QUOTE

%%

<INITIAL>{
	 \"				printf("\""); BEGIN(QUOTE);
     "/*"           printf("  "); BEGIN(BLOCK_COMMENT); //replace with two spaces and go to block
     "//"			printf("  "); BEGIN(LINE_COMMENT); //rpalce with two spaces and go to line
}
<BLOCK_COMMENT>{
     "*/"     		printf("  "); BEGIN(INITIAL); //replace with two spaces and begin initial
     [^\n\t]   		printf(" "); //replace with matching length of spaces
     \t				printf("\t");
     \n        		printf("\n"); //do not replace, just copy over
}
<LINE_COMMENT>{
	[^\n\t]			printf(" ");
	\t				printf("\t");
	\n				printf("\n"); BEGIN(INITIAL); //replace with matching length of spaces and make sure \n copies
}
<QUOTE>{
	\\\"			printf("\\\""); //make sure not to think quote ended by mistaking an escaped quote
	\"				printf("\""); BEGIN(INITIAL);
	\n				printf("\n"); BEGIN(INITIAL);
}

%%

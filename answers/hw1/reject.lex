/*
	
	PREDICTIONS			
	input |  a+  | a*b?
		  |      |
	aaa	  |  6   | 6 
	aa    |  3   | 3
	ab    |  1   | 3
	
	Total  =  10  | 12
	Actual =  10  | 12	

*/
%{
int numpat1, numpat2;
%}

%%
a+     { numpat1++; REJECT; }
a*b?   { numpat2++; REJECT; }
.|\n   /* do nothing */
%%

int main () {
  yylex();
  printf("pattern a+: %d -- pattern a*b?: %d\n", numpat1, numpat2);
  exit(0);
}


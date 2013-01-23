%{
/* example illustrating the use of states in lex 

   declare a state called INPUT using: %s INPUT

   enter a state using: BEGIN INPUT

   match a token only if in a certain state: <INPUT>\".*\"
*/
%}

%s INPUT
%s OUTPUT

%%

[ \t\n]+        		;
inputfile       		BEGIN INPUT;
outputfile				BEGIN OUTPUT;	

<INPUT>
						\".*\"   { BEGIN 0; ECHO; printf(" is the input file.\n"); } //BEGIN 0 brings us back into top level of rules

<OUTPUT>
						\".*\"   { BEGIN 0; ECHO; printf(" is the output file.\n"); } //BEGIN 0 brings us back into top level of rules

\".*\"          		{ ECHO; printf("\n"); }
.                		;
				
%%

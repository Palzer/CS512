
%{
/*
flex -o simplereject.c simplereject.lex 
gcc -o simplereject simplereject.c -lfl

test using:
echo "abcd" | ./simplereject
*/

#include <stdio.h>
#include <string.h>

%}

%%

..		{ printf("[%c %c]\n", yytext[0], yytext[1]); REJECT; }
\n		;
.		;
%%

typedef struct {
	char* word1;
	char* word2;
	int count;
}pair;

int  look_for_pair();
void add_pair(int *numwords, pair** pairs, char* one, char* two);
void display(int numwords, pair* pairs);
void inc_pair();

int main () {
	yylex();
  pair* array = 0;
  int numwords = 0;
  char* one = "hey";
  char* two = "you";
  
  
  add_pair(&numwords,&array,"one","two");
  display(numwords,array);
  add_pair(&numwords,&array,"three","four");
  display(numwords,array);
  add_pair(&numwords,&array,"five","six");
  display(numwords,array);

}

void add_pair(int *numwords, pair** pairs, char* one, char* two)
{
	int i;
	fprintf(stderr,"adding pair (%s,%s) to dictionary\n",one,two);
	
	//make pair count one more*/
	*numwords = *numwords + 1;

	//realloc memory and make a pointer to move stuff around
	*pairs = realloc(*pairs,*numwords*sizeof(pair));
	pair* newarray = *pairs;
	
	//create words and count
	newarray[*numwords-1].word1 = malloc(strlen(one) + 1);
	strcpy(newarray[*numwords-1].word1,one);
	newarray[*numwords-1].word2 = malloc(strlen(two) + 1);
	strcpy(newarray[*numwords-1].word2,two);
	newarray[*numwords-1].count = 1;
	
}

void display(int numwords, pair* pairs)
{
	int i;
	fprintf(stderr,"Dictionary has %i pair(s) and currently is:\n",numwords);
	for(i = 0; i < numwords; i++)
	{
		fprintf(stderr,"	%i	 Word 1: %s   Word 2: %s	Occurences: %i\n",i,pairs[i].word1,pairs[i].word2,pairs[i].count);
	}
}

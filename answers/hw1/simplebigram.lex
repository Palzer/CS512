
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
  
  //display(numwords,array);
  add_pair(&numwords,&array,"one","two");
  //display(numwords,array);
  add_pair(&numwords,&array,"three","four");
  //add_pair(&numwords,array,one,two);
  add_pair(&numwords,&array,"five","six");
 // add_pair(&numwords,array,one,two);
}

void add_pair(int *numwords, pair** pairs, char* one, char* two)
{
	int i;
	fprintf(stderr,"adding pair (%s,%s) to dictionary\n",one,two);
	
	//make pair count one more*/
	
	*numwords = *numwords + 1;
	fprintf(stderr,"allocing\n");
	pair* newarray = malloc(*numwords*sizeof(pair));
	fprintf(stderr,"memcpy\n");
	newarray = memcpy(newarray,*pairs,(*numwords-1)*sizeof(pair));
	
	newarray[*numwords-1].word1 = malloc(strlen(one) + 1);
	strcpy(newarray[*numwords-1].word1,one);
	fprintf(stderr,"	Dictionary[%i].word1 = %s\n",*numwords-1,newarray[*numwords-1].word1);
	newarray[*numwords-1].word2 = malloc(strlen(two) + 1);
	strcpy(newarray[*numwords-1].word2,two);
	fprintf(stderr,"	Dictionary[%i].word2 = %s\n",*numwords-1,newarray[*numwords-1].word2);
	newarray[*numwords-1].count = 1;
	fprintf(stderr,"	Dictionary[%i].count = %i\n",*numwords-1,newarray[*numwords-1].count);
	
	
	
	
	
	fprintf(stderr,"Dictionary after is %i pairs and currently is:\n",*numwords);
	
	for(i = 0; i < *numwords; i++)
	{
		fprintf(stderr,"	%i	Word 1: %s	Word 2: %s	Occurences: %i\n",i,newarray[i].word1,newarray[i].word2,newarray[i].count);
	}
	free(*pairs);
	*pairs = newarray;
}

void display(int numwords, pair* pairs)
{
	int i;
	fprintf(stderr,"Dictionary has %i pairs and currently is:\n",numwords);
	for(i = 0; i < numwords; i++)
	{
		fprintf(stderr,"	Word 1: %s\nWord 2: %s\nOccurences: %i\n\n",pairs[i].word1,pairs[i].word2,pairs[i].count);
	}
}

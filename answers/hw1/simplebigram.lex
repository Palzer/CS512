
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
void display(int numwords, pair** pairs);
void inc_pair();

int main () {
	yylex();
  pair** array = 0;
  int numwords = 0;
  char* one = "hey";
  char* two = "you";
  
  //display(numwords,array);
  add_pair(&numwords,array,one,two);
  add_pair(&numwords,array,one,two);
  display(numwords,array);
}

void add_pair(int *numwords, pair** pairs, char* one, char* two)
{
	fprintf(stderr,"adding pair (%s,%s) to dictionary\n",one,two);
	//make new pair of words
	pair newwords;
	newwords.word1 = malloc(strlen(one));
	strcpy(newwords.word1,one);
	newwords.word2 = malloc(strlen(two));
	strcpy(newwords.word2,two);
	newwords.count = 1;
	fprintf(stderr,"	Pair (word1: %s,word2: %s, count: %i) created\n",newwords.word1,newwords.word2,newwords.count);
	
	//make pair count one more
	fprintf(stderr,"	Dictionary held %i pairs\n",*numwords);
	fprintf(stderr,"	Size of dictionary had room for %i pairs, %i\n",sizeof(pairs)/sizeof(pair*));
	*numwords = *numwords + 1;
	fprintf(stderr,"	Dictionary will hold %i pairs\n",*numwords);
	
	fprintf(stderr,"	reallocing dictionary to hold %i pairs\n",*numwords);
	pairs = realloc(pairs,3*sizeof(pair*)); //make spot in dictionary for new pair
	fprintf(stderr,"	Size of dictionary now has room for %i pairs\n",sizeof(pairs)/sizeof(pair*));
	//pairs[*numwords-1] = malloc(sizeof(newwords)); //make correct space in spot for new pair
	//memcpy(pairs[*numwords-1],&newwords,sizeof(newwords)); //copy pair into the spot
}

void display(int numwords, pair** pairs)
{
	int i;
	fprintf(stderr,"Dictionary has %i pairs and currently is:\n",numwords);
	for(i = 0; i < numwords; i++)
	{
		fprintf(stderr,"Word 1: %s\nWord 2: %s\nOccurences: %i\n\n",pairs[i]->word1,pairs[i]->word2,pairs[i]->count);
	}
}

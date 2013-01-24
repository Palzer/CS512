
%{
/*
flex -o simplereject.c simplereject.lex 
gcc -o simplereject simplereject.c -lfl

test using:
echo "abcd" | ./simplereject
*/

#include <stdio.h>
#include <string.h>

typedef struct {
	char* word1;
	char* word2;
	int count;
}pair;

  pair* array = 0;
  int numwords = 0;
  char* lastword = 0;
  
 void look_for_pair(pair** currpair, char** one, char* two);
void add_pair(pair** pairs, char* one, char* two);
void display(pair* pairs);

%}

%%
[a-zA-Z]+		look_for_pair(&array,&lastword,yytext);
\n		;
.		;
%%

int main () {
	yylex();
  
  display(array);

}

void look_for_pair(pair** currpair, char** one, char* two){

	int i;
	int found = 0;
	pair* thispair = *currpair;
	//fprintf(stderr,"looking for pair (%s,%s)\n",*one,two);
	for (i = 0; i < numwords; i++){
		if (strcmp(thispair[i].word1,*one) == 0){
			if (strcmp(thispair[i].word2,two) == 0){
				//fprintf(stderr,"Found pair, incrementing\n");
				thispair[i].count++;
				found = 1;
			}
		}
	}
	if ((found == 0) && (*one != 0)){
		//fprintf(stderr,"didnt find. adding to dictionary\n");
		add_pair(currpair,*one,two);
	}
	
	//fprintf(stderr,"moving strings along\n");
	free(*one);
	*one = malloc(strlen(two)+1);
	strcpy(*one,two);

}

void add_pair(pair** pairs, char* one, char* two)
{
	int i;
	//fprintf(stderr,"adding pair (%s,%s) to dictionary\n",one,two);
	
	//make pair count one more*/
	numwords = numwords + 1;

	//realloc memory and make a pointer to move stuff around
	*pairs = realloc(*pairs,numwords*sizeof(pair));
	pair* newarray = *pairs;
	
	//create words and count
	newarray[numwords-1].word1 = malloc(strlen(one) + 1);
	strcpy(newarray[numwords-1].word1,one);
	newarray[numwords-1].word2 = malloc(strlen(two) + 1);
	strcpy(newarray[numwords-1].word2,two);
	newarray[numwords-1].count = 1;
	
}

void display(pair* pairs)
{
	int i;
	fprintf(stderr,"Dictionary has %i pair(s) and is:\n",numwords);
	for(i = 0; i < numwords; i++)
	{
		fprintf(stderr,"	Pair: %-5i	 Word 1: %-15s	 Word 2: %-15s	 Occurences: %-5i\n",i,pairs[i].word1,pairs[i].word2,pairs[i].count);
	}
}

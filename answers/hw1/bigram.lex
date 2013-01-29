
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
	struct pair* next;
}pair;

  pair* list = 0;
  char* lastword = 0;
  
void look_for_pair(char** one, char* two);
void add_pair(char* one, char* two);
void display();

%}

%%
[a-zA-Z]+		look_for_pair(&lastword,yytext);
\n		;
.		;
%%

int main () {
	yylex();
  
  display(list);

}

void look_for_pair(char** one, char* two){

	int found = 0;
	pair* pair = list;
	//fprintf(stderr,"looking for pair (%s,%s)\n",*one,two);
	while (pair != 0){
		if (strcmp(pair->word1,*one) == 0){
			if (strcmp(pair->word2,two) == 0){
				//fprintf(stderr,"Found pair, incrementing\n");
				pair->count++;
				found = 1;
			}
		}
		pair = pair->next;
	}
	if ((found == 0) && (*one != 0)){
		//fprintf(stderr,"didnt find. adding to dictionary\n");
		add_pair(*one,two);
	}
	
	//fprintf(stderr,"moving strings along\n");
	free(*one);
	*one = malloc(strlen(two)+1);
	strcpy(*one,two);

}

void add_pair(char* one, char* two)
{
	//fprintf(stderr,"adding pair (%s,%s) to dictionary\n",one,two);
	
	pair* newpair = malloc(sizeof(pair));
	
	//create words and count
	newpair->word1 = malloc(strlen(one) + 1);
	strcpy(newpair->word1,one);
	newpair->word2 = malloc(strlen(two) + 1);
	strcpy(newpair->word2,two);
	newpair->count = 1;
	
	//INSERT IN ALPHABETIC ORDER HERE
	int inserted = 0;
	pair* curr = list;
	pair* prev;
	if (curr == 0){	//list is empty and must insert at front
		//fprintf(stderr,"list is empty\n");
		newpair->next = list;
		list = newpair;
		//fprintf(stderr,"list is %i and newpair is %i and newpair->next is %i\n",list,newpair,newpair->next);
	}
	else
	{
		while(curr->next != 0 && inserted == 0)	//while not at the last item in the list
		{
			if (strcmp(newpair->word1,curr->word1) > 0){ //needs to go after current word
				//fprintf(stderr,"%s goes after %s\n",newpair->word1,curr->word1);
				prev = curr;
				curr = curr->next;
			}
			else if(strcmp(newpair->word1,curr->word1) == 0){ //need to look at second word to break tie
				if (strcmp(newpair->word2,curr->word2) > 0){ //second word goes after current second word
					prev = curr;
					curr = curr->next;
				}
				else{
					newpair->next = curr;
					prev->next = curr;
					inserted = 1;
				}
			}			
			else{
				newpair->next = curr;
				prev->next = newpair;
				inserted = 1;
			}
		}
		if (inserted == 0){
			curr->next = newpair;
		}			
	}
}

void display()
{
	pair* pair = list;
	int i = 1;
	fprintf(stderr,"Dictionary currently is:\n");
	while (pair != 0)
	{
		fprintf(stderr,"	Pair: %-5i	 Word 1: %-15s	 Word 2: %-15s	 Occurences: %-5i\n",i,pair->word1,pair->word2,pair->count);
		pair = pair->next;
		i++;
	}
}

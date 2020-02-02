%{ 
#include <stdio.h>
#include "lex.h"
#include <string.h>

int opoc = -1;
%} 

%%

[aA][nN][dD]					return KW_AND;
[oO][rR]						return KW_OR;
[nN][oO][tT]					return KW_NOT;
[eE][qQ][uU][aA][lL] 			return KW_EQUAL;
[lL][eE][sS][sS]				return KW_LESS;
[nN][iI][lL]					return KW_NIL;
[lL][iI][sS][tT]				return KW_LIST;
[aA][pP][pP][eE][nN][dD]		return KW_APPEND;
[cC][oO][nN][cC][aA][tT]		return KW_CONCAT;
[sS][eE][tT]					return KW_SET;
[dD][eE][fF][fF][uU][nN]		return KW_DEFFUN;
[fF][oO][rR]					return KW_FOR;
[iI][fF]						return KW_IF;
[eE][xX][iI][tT]				return KW_EXIT;
[lL][oO][aA][dD]				return KW_LOAD;
[dD][iI][sS][pP]				return KW_DISP;
[tT][rR][uU][eE]				return KW_TRUE;
[fF][aA][lL][sS][eE]			return KW_FALSE;

[+] 							return OP_PLUS;
[-] 							return OP_MINUS;
[/] 							return OP_DIV;
[*][*] 							return OP_DBLMULT;
[*] 							return OP_MULT;
[(] 							return OP_OP;
[)] 							return OP_CP;
["] 							{
									opoc += 1;
									return (OP_OC + opoc % 2);
								}

[,]								return OP_COMMA;

[;][;] 							{
									int code = 0;
									while(code != NEWLINE)
									{code = yylex();}
									return COMMENT;
								}

[a-zA-Z_][a-zA-Z0-9_]*			return IDENTIFIER;

[0]|[1-9][0-9]*					return VALUE;		   



[\n]							return NEWLINE;
[ \t]+							return WHITESPACE;
.								return UNKNOWN;

%% 
int yywrap(){}
int runformat(char start[256], char filename[256]);
int determine(int res[10], int i);
int main(){ 
	const char token[][15] = { "", "KW_AND", "KW_OR", "KW_NOT", "KW_EQUAL", "KW_LESS", "KW_NIL", "KW_LIST", "KW_APPEND", "KW_CONCAT", "KW_SET", "KW_DEFFUN", "KW_FOR",
    						  "KW_IF", "KW_EXIT", "KW_LOAD", "KW_DISP", "KW_TRUE", "KW_FALSE", "OP_PLUS", "OP_MINUS", "OP_DIV", "OP_DBLMULT", "OP_MULT", "OP_OP", "OP_CP",
    						  "OP_OC", "OP_CC", "OP_COMMA", "COMMENT", "IDENTIFIER", "VALUE", "", ""};

    char start[256];
    char filename[256];
    FILE *fp;
    int check = KW_EXIT;
    printf("$ ");
    scanf("%[^\n]s", start);
    int formatv = runformat(start, filename);

    switch (formatv){
    	case -1:
    		printf("G++ Starting method is incorrect.\n");
    		break;
    	case 1:
    		check = 0;
    		break;
    	case 2:
    		fp = fopen(filename, "r");
    		if(fp == NULL) printf("File can not found!\n");
    		else{
    			yyin = fp;
    			check = 0;
    		}
    		break;
    }

    int res[10] = {-1};
    int i = 0;
    int temp = 0;
    char tempres[150];

	int lex_code = 1;
	while(check != KW_EXIT && lex_code != UNKNOWN && lex_code != 0)
	{	
		if(lex_code == NEWLINE && formatv == 1) printf("> ");
		lex_code = yylex();
		if(lex_code > 0 && lex_code < NEWLINE)
		{
			res[i] = lex_code;
			check = determine(res, i);
			i += 1;
			i %= 10;
			
			if((lex_code >= KW_AND && lex_code <= KW_FALSE) || (lex_code == VALUE || lex_code == IDENTIFIER || lex_code == OP_CC))
			{
				strcpy(tempres, yytext);
				temp = yylex();
				if(temp != OP_OP && temp != OP_CP && temp != NEWLINE && temp != WHITESPACE)
				{
					printf("ERROR %s%s can not be tokenized.\n", tempres, yytext);
					check = KW_EXIT;
				}
				else
				{
					printf("%s\n",token[lex_code]);
					lex_code = temp;
					if(temp == OP_OP || temp == OP_CP)
					{
						res[i] = temp;
						printf("%s\n",token[temp]);
						i += 1;
						i %= 10;
					}
				}
			}
			else if(lex_code >= OP_PLUS && lex_code <= OP_MULT)
			{
				strcpy(tempres, yytext);
				temp = yylex();

				if(temp != OP_OP && temp != OP_CP && temp != NEWLINE && temp != WHITESPACE)
				{
					printf("ERROR %s%s can not be tokenized.\n", tempres, yytext);
					check = KW_EXIT;
				}
				else
				{
					printf("%s\n",token[lex_code]);
					lex_code = temp;
					if(temp == OP_OP || temp == OP_CP)
					{
						res[i] = temp;
						printf("%s\n",token[temp]);
						i += 1;
						i %= 10;
					}
				}
			}
			else {printf("%s\n",token[lex_code]);}
		}
	}
	if(lex_code == UNKNOWN)
	{
		printf("ERROR %s can not be tokenized.\n", yytext);
	}
	return 0; 
}

int runformat(char start[256], char filename[256])
{
	int i = 0;
	int j = 0;
	int temp;
	while(start[i] == ' ' && start[i] != '\0') i += 1;
	if(start[i] == '\0') return -1;
	if(start[i] == 'g' && start[i+1] == '+' && start[i+2] == '+')
	{
		i += 3;
		temp = i;
		while(start[i] == ' ') i += 1;
		if(start[i] == '\0') return 1;
		if(temp == i) return -1;
		while(start[i] != '\"' && start[i] != '\0') i += 1;
		if(start[i] == '\0') return -1;
		i += 1;
		while(start[i] != '\"' && start[i] != '\0')
		{
			filename[j] = start[i];
			i += 1;
			j += 1;
		}
		filename[j] = '\0';
		if(start[i] == '\0') return -1;
		i += 1;
		while(start[i] == ' ') i += 1;
		if(start[i] == '\0') return 2;
		else return -1;
	}
	return -1;
}

int determine(int res[10], int i)
{
	int cur = i;
	int back = cur - 1;
	if(back < 0) back += 10;

	if(res[back] == KW_EXIT)
	{
		int back2 = cur - 2;
		if(back2 < 0) back2 += 10;
		if(res[cur] == OP_CP && res[back2] == OP_OP)
		{return KW_EXIT;}
	}

	return 0;
}

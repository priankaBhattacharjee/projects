%{
	#include<stdio.h>
	#include<math.h>
	#include<stdlib.h>
	#include<string.h>
	void yyerror(char *s);	
	int yylex(void);
	int table[100];
	#define NVARS 100
	#define YYSTYPE int
    char *vars[NVARS];
    int nvars=0;
	int el = 0;
	int h = 0;
	int l = 0;

%}

%token IF ELSE THEN PLUS MINUS MULTIPLY DIV HIGHERTHAN LESSERTHAN EQU NOT HIGHEROREQU LOWEROREQU NUMBER VARIABLE EQUCHECK MATCH ELEMENT SWITCHING NOW FORGET GO LOOP

%nonassoc IFX
%nonassoc ELSE
%nonassoc MATCH
%nonassoc ELEMENT
%right EQU
%left LESSERTHAN HIGHERTHAN HIGHEROREQU LOWEROREQU EQUCHECK
%left PLUS MINUS
%left MULTIPLY DIV
%left '(' ')'
%start STATEMENTS


%%

STATEMENTS:    
     | STATEMENTS Line 
	;

Line:'.'
     | VARIABLE EQU Expression'.' { 
					table[$1] = $3; 
					printf("table[%d] = %d\n", $1, $3);
				}
     | Expression '.' { printf("%d\n", $1); }
     | IF '(' Expression ')' '{' Line '}' %prec IFX {
								if($3)
								{
									printf("\nIn IF, value of expression: %d\n",$6);
								}
							}

	| IF '(' Expression ')' '{' Line '}' ELSE '{' Line '}' {
								 	if($3)
									{
										printf("In IF, value of expression: %d\n",$6);
									}
									else
									{
										printf("In ELSE, value of expression: %d\n",$10);
									}
								   }		   
	|SWITCHING '(' Expression ')'{el = $3;}
	|NOW '{' SERIES '}'
	|LOOP '(' NUMVAR')' {h = $3; l = 0;}
	|GO '{' '}' {while(h<=l)l--;}
	|BREAKING
	 ;
SERIES: MATCH NUMVAR SERIES {if(el == $2) printf("matched with %d\n", el);}
      | MATCH NUMVAR {$$ = $1;} {if(el == $2) printf("matched with %d\n", el);}

Expression:
     	NUMVAR
	| Expression PLUS Expression { $$=$1+$3; printf("E + E\n"); }
	| Expression MINUS Expression { $$=$1-$3; printf("E - E\n"); }
	| Expression MULTIPLY Expression { $$=$1*$3; printf("E * E\n"); }
	| Expression DIV Expression { if($3) 
				  		{
				     			$$ = $1 / $3;
				     			printf("E / E\n");
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\nDivision by zero\n");
				  		} 	

				  	}

	|'(' Expression ')' { $$ = $2;  printf("( E )\n"); }
	| Expression LESSERTHAN Expression	{ $$ = $1 < $3; printf("E < E\n");}
	| Expression HIGHERTHAN Expression	{ $$ = $1 > $3; printf("E > E\n"); }
	| Expression HIGHEROREQU Expression	{ $$ = $1 >= $3; printf("E >= E\n");}
	| Expression LOWEROREQU Expression	{ $$ = $1 <= $3; printf("E <= E\n"); }
	| EQUALEQUAL
	;
EQUALEQUAL:       NUMVAR EQUCHECK NUMVAR {$$ = ($1 == $3); printf("NUMVAR == NUMVAR\n");}
NUMVAR: NUMBER { $$ = $1; printf("Number %d\n", $$);}
      | VARIABLE {$$ = table[$1]; }
BREAKING: FORGET{break;}
%%

int varindex(char *varname)
{
  int i;
  for (i=0; i<nvars; i++)
    if (strcmp(varname,vars[i])==0)
      return i;
  vars[nvars] = strdup(varname);
  return nvars++;
}


void yyerror(char *s)
{
	fprintf(stderr, "%s\n",s);
}

int yywrap(void)
{
	return 1;
}



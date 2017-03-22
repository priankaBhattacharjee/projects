%{ 
	#include "p.tab.h"
	#include<stdio.h>
	#include<stdlib.h>
	void yyerror(char *);
	int varindex(char *var);
	int yyparse(void);
%}

KEYWORD natural|if|or|match|element|loop|go
IDENTIFIER [a-zA-Z]+[a-zA-Z0-9]*
PUNCTUATION [.]       
DIGIT [0-9]

%%

[/][*][^"*/"]*[*][/]
"//"[^\n]* 
[ \t\n]* ;

"if" { return IF; }
"or" { return ELSE; }
"match" {return MATCH; }
"now" {return NOW;}
"switching" {return SWITCHING;}
"natural" 
"forgetIt" {return FORGET;}
"loop" {return LOOP;}
"go" {return GO;}

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULTIPLY; }
"/" { return DIV; }
">" { return HIGHERTHAN; }
"<" { return LESSERTHAN; }
"=" { return EQU; }
">=" { return HIGHEROREQU; }
"<=" { return LOWEROREQU; }
"==" { return EQUCHECK; }

{IDENTIFIER} {
			yylval = varindex(yytext);
 			return VARIABLE;
 			}


{PUNCTUATION} { 
			return *yytext; 
			} 


[(){}] { 
			return *yytext; 
			}


"-"?{DIGIT}+ {
	yylval =atof(yytext);
	return NUMBER;
	}

%%

int main()
{
    yyin = fopen("p.txt", "r");
    freopen("o.txt", "w", stdout);
	yyparse();	
}


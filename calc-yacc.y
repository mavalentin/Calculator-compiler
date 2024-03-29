%{
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <math.h>
#include "symtab.c"
%}


%union {
       char* lexeme;			//identifier
       double value;			//value of an identifier of type NUM
       }

%token <value> NUM
%token IF
%token SQRT
%token <lexeme> ID
%token <lexeme> STR

%type <value> expr
%type <lexeme> assignment
 /*%type <value> line */

%right '='
%left '-' '+'
%left '*' '/'
%left '^'
%left '%'
%left '!'
/*%right UMINUS*/

%start start

%%
start : line start
      | line
      ;

line  : assignment '\n' {}
      | expr '\n'      {printf("Result: %f\n", $1);}
      | error
      ;
expr  : expr '+' expr  {$$ = $1 + $3;}
      | expr '-' expr  {$$ = $1 - $3;}
      | expr '*' expr  {$$ = $1 * $3;}
      | expr '/' expr  {if($3 == 0.0){
				yyerror("division by zero not allowed");
				exit(-1);}
			else
				$$ = $1 / $3;
			}
      | expr '^' expr  {$$ = pow($1,$3);}
      | expr '%' expr  {$$ = $1 / 100 * $3;}
      | expr '!'       { int c, fact=1;
				for(c=1; c<=$1; c++)
					fact = fact * c;
			$$ = fact;}
      | SQRT '(' expr ')' {if($3 < 0){
                   yyerror("square root of negative number not allowed in real numbers");
                    exit(-1);}
            else
                    $$ = sqrt($3);
            }
      | '(' expr ')'   {$$ = $2;}
      | '|' expr '|'   {$$ = abs($2);}
      | NUM            {$$ = $1;}
      | ID	       {double *val = searchVarVal($1);
			if(val != NULL){
				$$ = *val;
			} else { 
				yyerror("variable is not defined");
                $$ = 0;
				}
			}
      | '-' expr       {$$ = -$2;}
      ;
assignment	: ID '=' STR   {yyerror("can not assign strings to variables. this is a calculator");}
            | ID '=' expr	{char *name = $1;
				double *value = &$3;
				updateSymTab(name, value);}
	  	    ;


%%

#include "lex.yy.c"

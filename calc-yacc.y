%{
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <math.h>
%}


%union {
       char* lexeme;			//identifier
       double value;			//value of an identifier of type NUM
       }

%token <value> NUM
%token IF
%token SQRT
%token <lexeme> ID

%type <value> expr
 /*%type <value> line */

%left '-' '+'
%left '*' '/'
%left '^'
%left '%'
%left '!'
%right UMINUS

%start line

%%
line  : expr '\n'      {printf("Result: %f\n", $1); exit(0);}
      | ID             {printf("Result: %s\n", $1); exit(0);}
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
      | '-' expr %prec UMINUS {$$ = -$2;}
      ;

%%

#include "lex.yy.c"

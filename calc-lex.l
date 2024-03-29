%option noyywrap
%{
#include <stdlib.h>
#include <string.h>
%}

DIGIT    [0-9]
NUM      {DIGIT}+((\.|,){DIGIT}+)?

LETTER   [a-zA-Z]
STR      (\").*(\")
ID       {LETTER}({LETTER}|{DIGIT})*


%%

[ ]     { /* skip blanks */ }

[iI][fF] {return IF;}
"sqrt"   {return SQRT;}
{NUM}    {yylval.value = atof(yytext);
          return NUM;}
{STR}    {yylval.lexeme = strdup(yytext);
          return STR;}
{ID}     {yylval.lexeme = strdup(yytext);
          return ID;}


"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"("	{return '(';}
")"	{return ')';}
"%"	{return '%';}
"!"	{return '!';}
"|"	{return '|';}
"="	{return '=';}
\n      {return '\n';}



%%

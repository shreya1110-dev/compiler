%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    void yyerror(char *);
    int cnt = 0;
%}

term ([a-zA-Z_][a-zA-Z_0-9]*)
num [0-9]+
delim [ \t]+

%%
{term} {return ID;}
{delim} {return DELIM;}
[+\-] {return ADDOP;}
[*/] {return MULOP;}
{num} {return NUM;} 
"\n" {cnt++;}
"=" {return ASSIGN;}
";" {return *yytext;}
"(" {return *yytext;}
")" {return *yytext;}
%%
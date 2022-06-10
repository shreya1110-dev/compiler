%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    void yyerror(char *s);
%}

term ([a-zA-Z_][a-zA-Z_0-9]*)
num [0-9\.]+
delim [ \t]+

%%
{term} {yylval.str=strdup(yytext); return ID;}
{num} {yylval.str=strdup(yytext); return NUM;}
("=") {yylval.str=strdup(yytext); return ASSIGN;}
[+\-] {yylval.str=strdup(yytext); return ADDOP;}
[*/] {yylval.str=strdup(yytext); return MULOP;}
{delim} {}
%%
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    void yyerror(char *);
    int cnt = 0;
%}

term ([a-zA-Z_][a-zA-Z_0-9]*|[0-9]+)
num [0-9\.]+
delim [ \t]+

%%
("0"|"1") {return *yytext;}
" **2" {return POW2;}
" **" {return POW;}
{term} {yylval.str=strdup(yytext); return ID;}
[+\-] {yylval.str=strdup(yytext); return ADDOP;}
[*/] {yylval.str=strdup(yytext); return MULOP;}
"\n" {cnt++;}
"=" {return ASSIGN;}
";" {return yytext;}
"(" {return yytext;}
")" {return yytext;}
%%


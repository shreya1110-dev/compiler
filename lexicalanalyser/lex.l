%option noyywrap
%{
    #include<stdio.h>
    #include<string.h>
    #include "y.tab.h"
%}

term ([a-zA-Z\_][a-zA-Z0-9\_]*|[0-9]+)
delim [ \t]
%%
{term} {printf("%s - \t Term\n", yytext);}
[+\-*/] {printf("%s - \t Arithmetic operator\n", yytext);}
"=" {printf("%s - \t Assignment operator\n", yytext);}
"\n" {printf("%s - \t New Line\n", yytext);}
(";"|"("|")") {return yytext;}
{delim} { }
. {printf("Invalid Character");}

%{
    int main() {
        yylex();
        return 0;
    }
%}
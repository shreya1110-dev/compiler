%{
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
    #include <string.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token ID ASSIGN MULOP ADDOP POW2 POW DELIM NUM

%union {
    int intval;
    float floatval;
    char *str;
}

%type<str> ID ASSIGN MULOP ADDOP POW POW2 

%%
line: ID '=' ID ADDOP '0' {if(strcmp($1, $3)!=0)

printf("%s = %s\n",$1, $3);} line

| ID '=' '0' ADDOP ID {if(strcmp($1, $5)!=0)

printf("%s = %s\n",$1, $5);} line
| ID '=' ID ADDOP ID {printf("%s = %s %s %s\n", $1,$3,$4,$5);} line
| ID '=' ID '*' '1' {if(strcmp($1, $3)!=0)

printf("%s = %s\n",$1, $3);} line

| ID '=' '1' '*' ID {if(strcmp($1, $5)!=0)

printf("%s = %s\n",$1, $5);} line

| ID '=' ID '*' '0' {printf("%s = 0\n",$1);} line
| ID '=' '0' '*' ID {printf("%s = 0\n",$1);} line
| ID '=' ID '/' '1' {if(strcmp($1, $3)!=0)

printf("%s = %s\n",$1, $3);} line
| ID '=' ID '*' ID {printf("%s = %s * %s\n", $1,$3,$5);} line
| ID '=' ID '/' ID {printf("%s = %s / %s\n", $1,$3,$5);} line
| ID '=' ID POW '1' { if(strcmp($1, $3)!=0)

printf("%s = %s\n", $1,$3);} line

| ID '=' ID POW '0' { printf("%s = 1\n", $1);} line
| ID '=' '1' POW ID { printf("%s = 1\n", $1);} line
| ID '=' '0' POW ID { printf("%s = 0\n", $1);} line
| ID '=' ID POW2 { printf("%s = %s * %s\n", $1,$3,$3);} line
| /* empty */
%%

void yyerror(char* s) {
    fprintf(stderr,"%s",s);
}

int yywrap() {
    return 1;
}

int main() {
    yyparse();
    return 0;
}
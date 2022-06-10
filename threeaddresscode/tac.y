%{
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
    void yyerror(char *s);
    int yylex(void);
    int tc = 1;
%}

%token ID ASSIGN MULOP ADDOP NUM DELIM

%union {
    int intval;
    float floatval;
    char *str;
}

%type<str> ID ASSIGN MULOP ADDOP DELIM expr
%type<intval> NUM

%%
program: mulexp
mulexp: ID ASSIGN ID MULOP expr {printf("t%d = %s %s %s\n%s = t%d",tc,$3,$4,$5,$1,tc); tc++;} program|addexp;
addexp: ID ASSIGN ID ADDOP expr {printf("t%d = %s %s %s\n%s = t%d",tc,$3,$4,$5,$1,tc); tc++;} program;
expr: ID {sprintf($$,"%s",$1);}
|ID MULOP expr {printf("t%d = %s %s %s\n",tc,$1,$2,$3); sprintf($$,"t%d",tc); tc++;}
|ID ADDOP expr {printf("t%d = %s %s %s\n",tc,$1,$2,$3); sprintf($$,"t%d",tc); tc++;};
%%

void yyerror(char *s) {
    fprintf(stderr,"  %s",s);
    return;
}

int yywrap() {
    return 1;
}

int main() {
    yyparse();
    return 0;
}
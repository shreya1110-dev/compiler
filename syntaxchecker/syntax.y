%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    void yyerror(char *s);
    int yylex(void);
    int flag = 0;
    extern int cnt;
%}

%token ID DELIM MULOP ADDOP NUM ASSIGN

%%
program: |mulex;
mulex: ID ASSIGN ID MULOP expr program|addex;
addex: ID ASSIGN ID ADDOP expr program;
expr: ID|ID MULOP ID|ID ADDOP ID; 
%%

void yyerror(char *s) {
    fprintf(stderr, "Error at line: %d\n%s", cnt,s);
    flag = 1;
    return;
}

int yywrap() {
    return 1;
} 

int main() {
    yyparse();
    if(!flag) {
        printf("Valid!\n");
    }
    return 0;
}
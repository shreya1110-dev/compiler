%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    void yyerror(char *s);
    int yylex(void);
    int rno = 0;
%}

%token ID NUM ASSIGN ADDOP MULOP

%union {
    int intval;
    float floatval;
    char *str;
}

%type<str> ID ASSIGN ADDOP MULOP NUM line

%%
program:line program|line;
line:ID ASSIGN ID MULOP ID {printf("MOV R%d, #%s\n",rno,$5); printf("MUL R%d,#%s\n",rno,$3); printf("MOV %s,R%d\n",$1,rno++);}
|ID ASSIGN ID ADDOP ID {printf("MOV R%d, #%s\n",rno,$5); printf("ADD R%d,#%s\n",rno,$3); printf("MOV %s,R%d\n",$1,rno++);}
|ID ASSIGN ID {printf("MOV R%d,#%s\n",rno,$3); printf("MOV %s,R%d\n",$1,rno++);};
%%

void yyerror(char *s) {
    sprintf(stderr, "%s", s);
}

int yywrap() {
    return 1;
}

int main() {
    yyparse();
    return 1;
}


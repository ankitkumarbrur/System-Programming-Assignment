%{
    #include<stdio.h>
    int yylex();
    int yyerror()
    {
        printf("\nENTERED QUERY IS WRONG\n\n"); 
        return 0;
    }
%}

%token DELETE FROM WHERE IDENTIFIER identifier NUMBER OPERATOR TOP OR AND IN

%%

START: SQL {
    printf("\nQUERY ACCEPTED!!!\n\n");
    return 0;
};

SQL: DELETE IDENTIFIER
    |DELETE TOP FROM IDENTIFIER
    |DELETE FROM IDENTIFIER
    |DELETE TOP FROM IDENTIFIER WHERE CONDITION
    |DELETE FROM IDENTIFIER WHERE CONDITION
    ;

CONDITION: IDENTIFIER IN
    |IDENTIFIER '=' IDENTIFIER
    |IDENTIFIER '=' IDENTIFIER EXTRA
    |IDENTIFIER '=' NUMBER
    |IDENTIFIER '=' NUMBER EXTRA
    |IDENTIFIER OPERATOR NUMBER
    |IDENTIFIER OPERATOR NUMBER EXTRA
    ;

EXTRA: AND CONDITION
    |OR CONDITION
    ;

%%

int main()
{
    yyparse();
    return 0;
}
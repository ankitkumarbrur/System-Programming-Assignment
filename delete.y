// THIS GRAMMER WILL ACCEPT ALL QUERIES FOLLOWING THIS SYNTAX. THIS GRAMMER IS NOT MADE FOR MULTIPLE TABLES (JOINS).
// DELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM tbl_name [[AS] tbl_alias]
//     [PARTITION (partition_name [, partition_name] ...)]
//     [WHERE where_condition]
//     [ORDER BY ...]
//     [LIMIT row_count]
%{
    #include<stdio.h>
    int erflag=0;
    int yylex();
    int yyerror()
    {
        printf("\nENTERED QUERY IS WRONG\n\n"); 
        erflag=1;
        return 0;
    }
    extern FILE *yyin;
%}

%token DELETE FROM WHERE IDENTIFIER DIGIT FLOAT OPERATOR TOP OR AND IN LIMIT PERCENT LITERAL ORDER BY ASC DESC LOW_PRIORITY QUICK IGNORE AS PARTITION KEYWORD ANY

%%

START: SQL ';' {
    if(erflag!=1)
        printf("\nQUERY ACCEPTED!!!\n\n");
        return 0;
};

SQL: DELETE FROM IDENTIFIER
    |DELETE FROM IDENTIFIER END1
    |DELETE OPTIONS FROM IDENTIFIER
    |DELETE OPTIONS FROM IDENTIFIER END1
    ;

END1:END2
    |MIDDLE
    |MIDDLE END2;

END2: ORDER BY O_BY
    |WHERE CONDITION 
    |WHERE CONDITION ORDER BY O_BY
    |LIMIT DIGIT
    |ORDER BY O_BY LIMIT DIGIT
    |WHERE CONDITION LIMIT DIGIT
    |WHERE CONDITION ORDER BY O_BY LIMIT DIGIT
    ;


MIDDLE: AS IDENTIFIER
    |PARTITION '('P_NAME')'
    |AS IDENTIFIER PARTITION '('P_NAME')'
    ;
    
OPTIONS: LOW_PRIORITY
    |QUICK
    |IGNORE
    |LOW_PRIORITY OPTIONS2
    |QUICK OPTIONS3
    |IGNORE OPTIONS4
    ;

OPTIONS2: QUICK
        |IGNORE
        |QUICK IGNORE
        |IGNORE QUICK
        ;

OPTIONS3:IGNORE
        |LOW_PRIORITY
        |LOW_PRIORITY IGNORE
        |IGNORE LOW_PRIORITY
        ;

OPTIONS4: QUICK
        |LOW_PRIORITY
        |QUICK LOW_PRIORITY
        |LOW_PRIORITY QUICK
        ;

CONDITION: IDENT IN '('NUMBER')'
    |IDENT IN '('NUMBER EXTRA2')'
    |IDENT '=' IDENT
    |IDENT '=' IDENT EXTRA1
    |IDENT '=' NUMBER
    |IDENT '=' NUMBER EXTRA1
    |IDENT OPERATOR NUMBER
    |IDENT OPERATOR NUMBER EXTRA1
    |CONDITION2
    ;

CONDITION2: '('CONDITION')'
    |'('CONDITION')' EXTRA1
    ;

P_NAME:IDENTIFIER
    |IDENTIFIER ',' P_NAME
    ;

NUMBER: DIGIT
    | FLOAT
    ;

IDENT: IDENTIFIER
    | LITERAL
    ;

O_BY: IDENTIFIER
    |IDENTIFIER EXTRA3
    ;


EXTRA1: AND CONDITION
    |OR CONDITION
    ;

EXTRA2: ',' NUMBER
    | ',' NUMBER EXTRA2
    ;

EXTRA3:ASC
    |DESC
    |',' IDENTIFIER EXTRA3
    ;
%%

int main()
{
    yyparse();
    return 0;
}
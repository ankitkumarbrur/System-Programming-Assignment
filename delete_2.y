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
%}

%token DELETE FROM WHERE IDENTIFIER DIGIT FLOAT OPERATOR TOP OR AND IN LIMIT PERCENT LITERAL ORDER BY ASC DESC

%%

START: SQL {
    if(erflag!=1)
        printf("\nQUERY ACCEPTED!!!\n\n");
    return 0;
};

SQL: DELETE IDENTIFIER
    |DELETE FROM IDENTIFIER
    |DELETE FROM IDENTIFIER ORDER BY IDENTIFIER
    |DELETE FROM IDENTIFIER ORDER BY IDENTIFIER EXTRA3
    |DELETE FROM IDENTIFIER WHERE CONDITION 
    |DELETE FROM IDENTIFIER WHERE CONDITION ORDER BY IDENTIFIER
    |DELETE FROM IDENTIFIER WHERE CONDITION ORDER BY IDENTIFIER EXTRA3
    |DELETE FROM IDENTIFIER LIMIT DIGIT {                                   $5<0?yyerror():printf("");  }
    |DELETE FROM IDENTIFIER ORDER BY IDENTIFIER LIMIT DIGIT {               $8<0?yyerror():printf("");  }
    |DELETE FROM IDENTIFIER ORDER BY IDENTIFIER EXTRA3 LIMIT DIGIT {        $9<0?yyerror():printf("");  }
    |DELETE FROM IDENTIFIER WHERE CONDITION LIMIT DIGIT {                   $7<0?yyerror():printf("");  }
    |DELETE FROM IDENTIFIER WHERE CONDITION ORDER BY LIMIT DIGIT {          $9<0?yyerror():printf(""); }
    |DELETE FROM IDENTIFIER WHERE CONDITION ORDER BY EXTRA3 LIMIT DIGIT {   $10<0?yyerror():printf(""); }
    ;

CONDITION: IDENT IN '('NUMBER')'
    |IDENT IN '('NUMBER EXTRA2')'
    |IDENT '=' IDENT
    |IDENT '=' IDENT EXTRA1
    |IDENT '=' NUMBER
    |IDENT '=' NUMBER EXTRA1
    |IDENT OPERATOR NUMBER
    |IDENT OPERATOR NUMBER EXTRA1
    ;

NUMBER: DIGIT
    | FLOAT
    ;

IDENT: IDENTIFIER
    | LITERAL
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
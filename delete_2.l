%option case-insensitive
%{
	#include"y.tab.h"
	#include<string.h>
	#undef yywrap
	#define yywrap() 1
%}

LITERAL \".*\"|\'.*\'
DIGIT -?[0-9]+
FLOAT -?[0-9]+"."[0-9]*|-?"."[0-9]+|-?[0-9]+E[-+]?[0-9]+|-?[0-9]+"."[0-9]*E[-+]?[0-9]+|-?"."[0-9]*E[-+]?[0-9]+
IN_L \".*\"[ ]*([ ]*,[ ]*\".*\"[ ]*)*
IDENTIFIER [A-Z_]+[0-9A-Z_]*
%%

DELETE {										return DELETE;			                    }
FROM {											return FROM;			                    }
WHERE {											return WHERE;			                    }
OR {                            				return OR;                                  }   
AND {				   	                        return AND;                                 }
LIMIT {         								return LIMIT;			                    }
ASC {                                           return ASC;                                 }
DESC {                                          return DESC;                                }
ORDER {                                         return ORDER;                               }
BY {                                            return BY;                                  }
{DIGIT} {                                       yylval=atoi(yytext); return DIGIT;          }
{FLOAT} {                                       yylval=atof(yytext); return DIGIT;          }
TOP {     				                        return TOP;                                 }
PERCENT {                                       return PERCENT;                             }
IN {    	                                	return IN;                                  }
;|\n { 											return 0;   			                    }
{IDENTIFIER} { 					                return IDENTIFIER;		                    }
{LITERAL} {                                     return LITERAL;                             }
=|\(|\)|, {									    return *yytext;		                        }
>|<|>=|<= {                     				return OPERATOR;                            } 
%%
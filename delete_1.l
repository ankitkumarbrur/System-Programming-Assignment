%option case-insensitive
%{
	#include"y.tab.h"
	#include<string.h>
	#undef yywrap
	#define yywrap() 1
	// IN_LITERAL [ ]*\(\".*\"([ ]*,\".*\")*\)|[ ]*\(\'.*\'([ ]*,\'.*\')*\)
%}

LITERAL \".*\"|\'.*\'
NUMBER -?[0-9]+|-?[0-9]+"."[0-9]*|-?"."[0-9]+|-?[0-9]+E[-+]?[0-9]+|-?[0-9]+"."[0-9]*E[-+]?[0-9]+|-?"."[0-9]*E[-+]?[0-9]+
IN_NUM [ ]*\([ ]*[0-9]+[ ]*(,[ ]*[0-9]+[ ]*)*\)
IN_ALPHA [ ]*\([ ]*[A-Z_][0-9A-Z_]*[ ]*(,[ ]*[A-Z_][0-9A-Z_]*[ ]*)*\)
IN_LITERAL \(\".*\"\)

%%

DELETE {						return DELETE;			}
FROM {							return FROM;			}
WHERE {							return WHERE;			}
OR {                            return OR;              }
AND {                           return AND;             }
TOP([0-9]+)[ \t]+PERCENT? {     return TOP;             }
IN{IN_NUM}|IN{IN_ALPHA}|IN{IN_LITERAL} {       return IN;              }
;|\n { 							return 0;				}
{LITERAL}|[A-Z_][0-9A-Z_]* { 	return IDENTIFIER;		}
= {								return *yytext;		    }
>|<|>=|<= {                     return OPERATOR;        }
{NUMBER} { 		                return NUMBER;         	}

%%
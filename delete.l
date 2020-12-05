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
KEYWORDS  ADD|ALL|ALTER|ANALYZE|AUTO_INCREMENT|BDB|BERKELEYDB|BETWEEN|BIGINT|BINARY|BLOB|BOTH|BTREE|CASCADE|CASE|CHANGE|CHAR|CHARACTER|CHECK|COLLATE|COLUMN|COLUMNS|CONSTRAINT|CREATE|CROSS|CURRENT_DATE|CURRENT_TIME|CURRENT_TIMESTAMP|DATABASE|DATABASES|DAY_HOUR|DAY_MINUTE|DAY_SECOND|DEC|DECIMAL|DEFAULT|DELAYED|DESCRIBE|DISTINCT|DISTINCTROW|DIV|DOUBLE|DROP|ELSE|ENCLOSED|ERRORS|ESCAPED|EXISTS|EXPLAIN|FALSE|FIELDS|FLOAT|FOR|FORCE|FOREIGN|FULLTEXT|FUNCTION|GEOMETRY|GRANT|GROUP|HASH|HAVING|HELP|HIGH_PRIORITY|HOUR_MINUTE|HOUR_SECOND|IF|INDEX|INFILE|INNER|INNODB|INSERT|INT|INTEGER|INTERVAL|INTO|IS|JOIN|KEY|KEYS|KILL|LEADING|LEFT|LIKE|LINES|LOAD|LOCALTIME|LOCALTIMESTAMP|LOCK|LONG|LONGBLOB|LONGTEXT|MASTER_SERVER_ID|MATCH|MEDIUMBLOB|MEDIUMINT|MEDIUMTEXT|MIDDLEINT|MINUTE_SECOND|MOD|MRG_MYISAM|NATURAL|NOT|NULL|NUMERIC|ON|OPTIMIZE|OPTION|OPTIONALLY|OUTER|OUTFILE|PRECISION|PRIMARY|PRIVILEGES|PROCEDURE|PURGE|READ|REAL|REFERENCES|REGEXP|RENAME|REPLACE|REQUIRE|RESTRICT|RETURNS|REVOKE|RIGHT|RLIKE|RTREE|SELECT|SET|SHOW|SMALLINT|SOME|SONAME|SPATIAL|SQL_BIG_RESULT|SQL_CALC_FOUND_ROWS|SQL_SMALL_RESULT|SSL|STARTING|STRAIGHT_JOIN|STRIPED|TABLE|TABLES|TERMINATED|THEN|TINYBLOB|TINYINT|TINYTEXT|TO|TRAILING|TRUE|TYPES|UNION|UNIQUE|UNLOCK|UNSIGNED|UPDATE|USAGE|USE|USER_RESOURCES|USING|VALUES|VARBINARY|VARCHAR|VARCHARACTER|VARYING|WARNINGS|WHEN|WITH|WRITE|XOR|YEAR_MONTH|ZEROFILL 
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
LOW_PRIORITY {                                  return LOW_PRIORITY;                        }
QUICK {                                         return QUICK;                               }
IGNORE {                                        return IGNORE;                              }
AS {                                            return AS;                                  }
PARTITION {                                     return PARTITION;                           }
{KEYWORDS} {									return KEYWORD;								}
{DIGIT} {                                       yylval=atoi(yytext); return DIGIT;          }
{FLOAT} {                                       yylval=atof(yytext); return DIGIT;          }
TOP {     				                        return TOP;                                 }
PERCENT {                                       return PERCENT;                             }
IN {    	                                	return IN;                                  }
\n { 											return 0;   			                    }
{IDENTIFIER} { 					                return IDENTIFIER;		                    }
{LITERAL} {                                     return LITERAL;                             }
=|\(|\)|,|; {									    return *yytext;		                        }
>|<|>=|<= {                     				return OPERATOR;                            }
[ \t] ;
. {												return ANY;									}
%%
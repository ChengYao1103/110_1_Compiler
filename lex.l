%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"
	int line = 1;
	extern void yyset_lineno(int lineno);
	// track line number %option yylineno
%}

%option yylineno

%%

print										{ return T_PRINT; }
func										{ return T_FUNC; }
return										{ return T_RETURN; }
while										{ return T_WHILE; }
var											{ return T_VAR; }
void										{ yylval.yy_int = T_VOID;return T_VOID; }
bool										{ yylval.yy_int = T_BOOLTYPE;return T_BOOLTYPE; }
int											{ yylval.yy_int = T_INTTYPE;return T_INTTYPE; }
string										{ yylval.yy_int = T_STRINGTYPE;return T_STRINGTYPE; }
true										{ yylval.yy_int = T_TRUE;return T_TRUE; }
false										{ yylval.yy_int = T_FALSE;return T_FALSE; }
null										{ return T_NULL; }
if											{ return T_IF; }
extern										{ return T_EXTERN; }
for											{ return T_FOR; }
package										{ return T_PACKAGE; }
break										{ return T_BREAK; }
continue									{ return T_CONTINUE; }
, 											{ return T_COMMA; }
else										{ return T_ELSE; }
\<\<										{ return T_LEFTSHIFT;  }
>>											{ return T_RIGHTSHIFT; }
\+											{ yylval.yy_int = T_PLUS;return T_PLUS; }
\-											{ yylval.yy_int = T_MINUS;return T_MINUS; }
\*											{ yylval.yy_int = T_MULT;return T_MULT; }
\/											{ yylval.yy_int = T_DIV;return T_DIV; }
\%											{ yylval.yy_int = T_MOD;return T_MOD; }
==											{ yylval.yy_int = T_EQ;return T_EQ;  }
>=											{ yylval.yy_int = T_GEQ;return T_GEQ; }
>											{ yylval.yy_int = T_GT;return T_GT;  }
\<=											{ yylval.yy_int = T_LEQ;return T_LEQ; }
\[											{ yylval.yy_int = T_LSB;return T_LSB; }
\]											{ yylval.yy_int = T_RSB;return T_RSB; }
\<											{ yylval.yy_int = T_PLUS;return T_LT; }
!=											{ yylval.yy_int = T_NEQ;return T_NEQ; }
!											{ yylval.yy_int = T_NOT;return T_NOT; }
\|\|										{ yylval.yy_int = T_OR;return T_OR; }
;											{ return T_SEMICOLON; }
\"([^\n"\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))*\"	{ return T_STRINGCONSTANT; }
[0-9]+(\.[0-9]+)?							{ yylval.yy_str = strdup(yytext);return T_INTCONSTANT; }
0[xX][0-9A-Fa-f]+							{ return T_HEXCONSTANT; }
\'([^\n'\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))\'	{ yylval.yy_str = strdup(yytext);return T_CHARCONSTANT; }
\{											{ return T_LCB; }
\}											{ return T_RCB; }
\(											{ return T_LPAREN; }
\)											{ return T_RPAREN; }
[a-zA-Z\_][a-zA-Z\_0-9]*					{ yylval.yy_str = strdup(yytext);return T_ID; }
"//".*"\n"									{ line++;yyset_lineno(line); }	// if return something will occur error
\n											{ line++;yyset_lineno(line);}
[\t\r\a\v\b ]+								{  }	
&&											{ return T_AND; }
=											{ return T_ASSIGN; }
"."											{ return T_DOT; } 
.											{ printf("Error: unexpected character in input\n"); return -1; }

%%

int yywrap() {
    return 1;
}

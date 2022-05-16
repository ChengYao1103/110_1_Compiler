%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"
%}

%%

func										{ return T_FUNC; }
return										{ return T_RETURN; }
while										{ return T_WHILE; }
void										{ return T_VOID; }
var											{ return T_VAR; }
bool										{ return T_BOOLTYPE; }
int											{ return T_INTTYPE; }
string										{ return T_STRINGTYPE; }
true										{ return T_TRUE; }
null										{ return T_NULL; }
if											{ return T_IF; }
extern										{ return T_EXTERN; }
for											{ return T_FOR; }
package										{ return T_PACKAGE; }
break										{ return T_BREAK; }
continue									{ return T_CONTINUE; }
, 											{ return T_COMMA; }
else										{ return T_ELSE; }
false										{ return T_FALSE; }
==											{ return T_EQ;  }
>=											{ return T_GEQ; }
>											{ return T_GT;  }
\<\<										{ return T_LEFTSHIFT;  }
>>											{ return T_RIGHTSHIFT; }
\<=											{ return T_LEQ; }
\[											{ return T_LSB; }
\]											{ return T_RSB; }
\<											{ return T_LT; }
\-											{ return T_MINUS; }
\+											{ return T_PLUS; }
\%											{ return T_MOD; }
\*											{ return T_MULT; }
!=											{ return T_NEQ; }
!											{ return T_NOT; }
\|\|										{ return T_OR; }
;											{ return T_SEMICOLON; }
\"([^\n"\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))*\"	{ return T_STRINGCONSTANT; }
([0-9]+(\.[0-9]+)?)|(0[xX][0-9A-Fa-f]+)		{ return T_INTCONSTANT; }
\'([^\n'\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))\'	{ return T_CHARCONSTANT; }
\{											{ return T_LCB; }
\}											{ return T_RCB; }
\(											{ return T_LPAREN; }
\)											{ return T_RPAREN; }
[a-zA-Z\_][a-zA-Z\_0-9]*					{ return T_ID; }
"//".*"\n"									{  }	// if return something will occur error
\n+[\t\r\a\v\b ]*							{  }	
[\t\r\a\v\b ]+								{  }	
&&											{ return T_AND; }
=											{ return T_ASSIGN; }
\/											{ return T_DIV; }
"."											{ return T_DOT; } 
.											{ printf("Error: unexpected character in input\n"); return -1; }

%%

int yywrap() {
    return 1;
}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
enum{T_N_TOKEN,T_FUNC, T_INT, T_PACKAGE, T_LCB, T_RCB, T_LPAREN, T_RPAREN, T_ID, 
    T_WHITESPACE, T_WHITESPACE_N, T_AND, T_ASSIGN, T_BOOLTYPE, T_BREAK, 
    T_COMMA, T_CHARCONSTANT, T_COMMENT, T_CONTINUE, T_DIV, T_DOT, T_ELSE, 
    T_EQ, T_EXTERN, T_FALSE, T_FOR, T_GEQ, T_GT, T_IF, T_INTCONSTANT, 
    T_INTTYPE, T_LEFTSHIFT, T_LEQ, T_LSB, T_LT, T_MINUS, T_MOD, T_MULT,
    T_NEQ, T_NOT, T_NULL, T_OR, T_PLUS, T_RIGHTSHIFT, T_RSB, T_SEMICOLON, 
    T_STRINGCONSTANT, T_STRINGTYPE, T_TRUE, T_VAR, T_VOID, T_WHILE, T_RETURN
};
%}
%%
func                       { return T_FUNC; }
return                     { return T_RETURN; }
while                      { return T_WHILE; }
void                       { return T_VOID; }
var                        { return T_VAR; }
string                     { return T_STRINGTYPE; }
true                       { return T_TRUE; }
null                       { return T_NULL; }
int                        { return T_INTTYPE; }
if                         { return T_IF; }
extern                     { return T_EXTERN; }
int                        { return T_INT; }
for                        { return T_FOR; }
package                    { return T_PACKAGE; }
break                      { return T_BREAK; }
continue                   { return T_CONTINUE; }
,                          { return T_COMMA; }
else                       { return T_ELSE; }
false                      { return T_FALSE; }
==                         { return T_EQ;  }
>=                         { return T_GEQ; }
>                          { return T_GT;  }
\<\<                       { return T_LEFTSHIFT;  }
>>                         { return T_RIGHTSHIFT; }
\<=                        { return T_LEQ; }
\[                         { return T_LSB; }
\]                         { return T_RSB; }
\<                         { return T_LT; }
\-                         { return T_MINUS; }
\+                         { return T_PLUS; }
\%                         { return T_MOD; }
\*                         { return T_MULT; }
!=                         { return T_NEQ; }
!                          { return T_NOT; }
\|\|                       { return T_OR; }
;                          { return T_SEMICOLON; }
\"([^\n"\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))*\" { return T_STRINGCONSTANT; }
([0-9]+(\.[0-9]+)?)|(0[xX][0-9A-Fa-f]+)          { return T_INTCONSTANT; }
\'([^\n'\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))\'        { return T_CHARCONSTANT; }
"//".*"\n"                 { return T_COMMENT; }
\{                         { return T_LCB; }
\}                         { return T_RCB; }
\(                         { return T_LPAREN; }
\)                         { return T_RPAREN; }
[a-zA-Z\_][a-zA-Z\_0-9]*   { return T_ID; }
\n+[\t\r\a\v\b ]*          { return T_WHITESPACE_N; }
[\t\r\a\v\b ]+             { return T_WHITESPACE; }
&&                         { return T_AND; }
=                          { return T_ASSIGN; }
\/                         { return T_DIV; }
"."                        { return T_DOT; } 
.                          { printf("Error: unexpected character in input\n"); return -1; }
%%
int main () {
  int token;
  char* lexeme;
  while ((token = yylex())) {
    if (token > 0) {
      lexeme = yytext;
      switch(token) {
        case T_FUNC: printf("T_FUNC %s\n", lexeme); break;
        case T_INT: printf("T_INT %s\n", lexeme); break;
        case T_PACKAGE: printf("T_PACKAGE %s\n", lexeme); break;
        case T_LCB: printf("T_LCB %s\n", lexeme); break;
        case T_RCB: printf("T_RCB %s\n", lexeme); break;
        case T_LPAREN: printf("T_LPAREN %s\n", lexeme); break;
        case T_RPAREN: printf("T_RPAREN %s\n", lexeme); break;
        case T_ID: printf("T_ID %s\n", lexeme); break;
        case T_WHITESPACE: /*printf("T_WHITESPACE %s\n", lexeme);*/ break;
        case T_WHITESPACE_N:
          /*printf("T_WHITESPACE ");
           *for( size_t i = 0; i < strlen(lexeme); i++)
           *  if( lexeme[i] == '\n' ) printf("\\n"); else printf(lexeme[i]);
           *printf("\n");
           */
          break;
        case T_AND: printf("T_AND %s\n", lexeme); break;
        case T_ASSIGN: printf("T_ASSIGN %s\n", lexeme); break;
        case T_BOOLTYPE: printf("T_BOOLTYPE %s\n", lexeme); break;
        case T_BREAK: printf("T_BREAK %s\n", lexeme); break;
        case T_COMMA: printf("T_COMMA %s\n", lexeme); break;
        case T_CHARCONSTANT: printf("T_CHARCONSTANT %s\n", lexeme); break;
        case T_COMMENT: /*printf("T_COMMENT %s\n", covert_newline(lexeme));*/ break;
        case T_CONTINUE: printf("T_CONTINUE %s\n", lexeme); break;
        case T_DIV: printf("T_DIV %s\n", lexeme); break;
        case T_DOT: printf("T_DOT %s\n", lexeme); break;
        case T_ELSE: printf("T_ELSE %s\n", lexeme); break;
        case T_EQ: printf("T_EQ %s\n", lexeme); break;
        case T_EXTERN: printf("T_EXTERN %s\n", lexeme); break; 
        case T_FALSE: printf("T_FALSE %s\n", lexeme); break;
        case T_FOR: printf("T_FOR %s\n", lexeme); break;
        case T_GEQ: printf("T_GEQ %s\n", lexeme); break;
        case T_GT: printf("T_GT %s\n", lexeme); break;
        case T_IF: printf("T_IF %s\n", lexeme); break;
        case T_INTCONSTANT: printf("T_INTCONSTANT %s\n", lexeme); break;
        case T_INTTYPE: printf("T_INTTYPE %s\n", lexeme); break;
        case T_LEFTSHIFT: printf("T_LEFTSHIFT %s\n", lexeme); break;
        case T_LEQ: printf("T_LEQ %s\n", lexeme); break;
        case T_LSB: printf("T_LSB %s\n", lexeme); break;
        case T_LT: printf("T_LT %s\n", lexeme); break;
        case T_MINUS: printf("T_MINUS %s\n", lexeme); break;
        case T_MOD: printf("T_MOD %s\n", lexeme); break;
        case T_MULT: printf("T_MULT %s\n", lexeme); break;
        case T_NEQ: printf("T_NEQ %s\n", lexeme); break;
        case T_NOT: printf("T_NOT %s\n", lexeme); break;
        case T_NULL: printf("T_NULL %s\n", lexeme); break;
        case T_OR: printf("T_OR %s\n", lexeme); break;
        case T_PLUS: printf("T_PLUS %s\n", lexeme); break;
        case T_RIGHTSHIFT: printf("T_RIGHTSHIFT %s\n", lexeme); break;
        case T_RSB: printf("T_RSB %s\n", lexeme); break;
        case T_SEMICOLON: printf("T_SEMICOLON %s\n", lexeme); break;
        case T_STRINGCONSTANT: printf("T_STRINGCONSTANT %s\n", lexeme); break;
        case T_STRINGTYPE: printf("T_STRINGTYPE %s\n", lexeme); break;
        case T_TRUE: printf("T_TRUE %s\n", lexeme); break;
        case T_VAR: printf("T_VAR %s\n", lexeme); break;
        case T_VOID: printf("T_VOID %s\n", lexeme); break;
        case T_WHILE: printf("T_WHILE %s\n", lexeme); break;
        case T_RETURN: printf("T_RETURN %s\n", lexeme); break;
        default: exit(EXIT_FAILURE);
      }
    } else {
      if (token < 0) {
        exit(EXIT_FAILURE);
      }
    }
  }
  exit(EXIT_SUCCESS);
}
%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<stdbool.h>
    #include<ctype.h>
    
    void yyerror(const char *s);
    int yylex();
    int yywrap();
    extern int yyget_lineno();
    extern int yylineno;
    extern char* yytext;
    bool is_error = false;
%}

// struct
%union{
	int intVal;
	char *stringVal;
}
%type <intVal> T_INTCONSTANT;
%type <stringVal> T_CHARCONSTANT;
%type <stringVal> T_STRINGCONSTANT;
%type <intVal> T_FALSE;
%type <intVal> T_TRUE;
%type <stringVal> T_ID;


// type
%token T_VOID T_VAR T_INTTYPE T_BOOLTYPE T_STRINGTYPE T_TRUE T_FALSE T_NULL T_STRINGCONSTANT T_INTCONSTANT T_CHARCONSTANT T_HEXCONSTANT
// compare & operator
%token T_EQ T_NEQ T_GEQ T_GT T_LEQ T_LT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_NOT T_OR T_AND T_ASSIGN 
// function
%token T_FUNC T_RETURN T_WHILE T_IF T_ELSE T_FOR T_BREAK T_CONTINUE
// sign
%token T_COMMA T_LSB T_RSB T_SEMICOLON T_LCB T_RCB T_LPAREN T_RPAREN T_DOT T_LEFTSHIFT T_RIGHTSHIFT
// other
%token T_PACKAGE T_EXTERN T_COMMENT T_ID T_WHITESPACE T_WHITESPACE_N

%left T_PLUS T_MINUS T_MULT T_DIV T_MOD
%right T_ASSIGN
%left T_OR T_AND
%left T_GEQ T_GT T_LEQ T_LT
%left T_EQ T_NEQ
%right T_NOT

%%

/* --------grammar-------- */

program: externs T_PACKAGE T_ID T_LCB fieldDecls methodDecls T_RCB;

// extern
externs: externs externDef
	| externDef
	|
;
externDef: T_EXTERN T_FUNC T_ID T_LPAREN externTypes T_RPAREN methodType T_SEMICOLON;
externTypes: externTypes T_COMMA externType
	| externType
;

// field
fieldDecls: fieldDecls fieldDecl
	| fieldDecl
	|
;
fieldDecl: T_VAR ids type T_SEMICOLON
	| T_VAR ids arrayType T_SEMICOLON
	| T_VAR T_ID type T_ASSIGN constant T_SEMICOLON	{printf("id:%s value: %d\n", $2, $<intVal>5);}
;

// method
methodDecls: methodDecls methodDecl
	| methodDecl
	|
;
methodDecl: T_FUNC T_ID T_LPAREN idTypes T_RPAREN methodType block
	| T_FUNC T_ID T_LPAREN T_RPAREN methodType block
;
methodCall: T_ID T_LPAREN methodArgs T_RPAREN
	| T_ID T_LPAREN T_RPAREN
;
methodArgs: methodArgs T_COMMA methodArg
	| methodArg
;
methodArg: expr
	| T_STRINGCONSTANT
;

// var
varDecls: varDecls varDecl
	| varDecl
	|
;
varDecl: T_VAR ids type T_SEMICOLON ;

// statements & expressions
block: T_LCB varDecls stats T_RCB ;
stats: stats stat
	| stat
	|
;
stat: block 
	| assign T_SEMICOLON
	| methodCall T_SEMICOLON
	| T_IF T_LPAREN expr T_RPAREN block
	| T_IF T_LPAREN expr T_RPAREN block T_ELSE block
	| T_WHILE T_LPAREN expr T_RPAREN block
	| T_FOR T_LPAREN assigns T_SEMICOLON expr T_SEMICOLON assigns T_RPAREN block
	| T_RETURN T_SEMICOLON
	| T_RETURN T_LPAREN expr T_RPAREN T_SEMICOLON
	| T_BREAK T_SEMICOLON
	| T_CONTINUE T_SEMICOLON
;
expr: T_ID
	| methodCall
	| constant
	| expr binaryOperators expr
	| unaryOperators expr
	| T_LPAREN expr T_RPAREN
	| T_ID T_LSB expr T_RSB
;

assigns: assigns T_COMMA assign
	| assign
;
assign: lValue T_ASSIGN expr ;
lValue: T_ID
	| T_ID T_LSB expr T_RSB
;

// operators
unaryOperators: T_NOT
	| T_MINUS
;
binaryOperators: mathOperator
	| compareOperator
;
mathOperator: T_PLUS
	| T_MINUS
	| T_MULT
	| T_DIV
	| T_MOD
;
compareOperator: T_GEQ
	| T_GT
	| T_LEQ
	| T_LT
	| T_EQ
	| T_NEQ
	| T_AND
	| T_OR
;

// id & types
ids: ids T_COMMA T_ID
	| T_ID
;
idTypes: idTypes T_COMMA idTypes
	| T_ID type
;
type: T_INTTYPE
	| T_BOOLTYPE
;
externType: T_STRINGTYPE
	| type
;
methodType: T_VOID
	| type
;
arrayType: T_LSB T_INTCONSTANT T_RSB type ;
constant: T_INTCONSTANT	{$<intVal>$ = $1;}
	| T_CHARCONSTANT	{$<stringVal>$ = $1;}
	| T_STRINGCONSTANT	{$<stringVal>$ = $1;}
	| T_TRUE			{$<intVal>$ = 1;}
	| T_FALSE			{$<intVal>$ = 0;}
;


%%

int main(void) {
    yyparse();
    if(!is_error){
    	printf("syntax all correct!\n");
    }
    return 0;
}

void yyerror(const char* msg) {
	is_error = true;
    fprintf(stderr, "%s at line %d:\n", msg, yyget_lineno());
    fprintf(stderr, "%s\n", yytext);
}

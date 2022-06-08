%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<stdbool.h>
    
    #define MAXSIZE 1024
    
    void yyerror(const char *s);
    int yylex();
    int yywrap();
    extern int yyget_lineno();
    extern int yylineno;
    bool is_error = false;
    
    typedef struct symbol{
		int type;
		char name[100];
		int intValue;
		bool boolValue;
		char stringValue[MAXSIZE];
		int passing; // value or reference
	}symbol;
	int symbol_count = 0;
	symbol symbols[MAXSIZE];
	void createSymbol(char *name, int type, char* value);
	void printSymbols();

%}

// struct
%union{
	char *yy_str;
	int yy_int;
}
%type <yy_int> type;
%type <yy_str> constant;


// type
%token <yy_str> T_VAR T_TRUE T_FALSE T_NULL T_STRINGCONSTANT T_INTCONSTANT T_CHARCONSTANT T_HEXCONSTANT
%token <yy_int> T_VOID T_INTTYPE T_BOOLTYPE T_STRINGTYPE 
// compare & operator
%token T_EQ T_NEQ T_GEQ T_GT T_LEQ T_LT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_NOT T_OR T_AND T_ASSIGN 
// function
%token T_FUNC T_RETURN T_WHILE T_IF T_ELSE T_FOR T_BREAK T_CONTINUE
// sign
%token T_COMMA T_LSB T_RSB T_SEMICOLON T_LCB T_RCB T_LPAREN T_RPAREN T_DOT T_LEFTSHIFT T_RIGHTSHIFT
// other
%token <yy_str> T_ID
%token T_PACKAGE T_EXTERN T_COMMENT T_WHITESPACE T_WHITESPACE_N T_PRINT

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
	| T_VAR T_ID type T_ASSIGN constant T_SEMICOLON	{ createSymbol($2, $3, $5); }
	| T_PRINT T_SEMICOLON	{printSymbols();}	// add to print symbol table
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
constant: T_INTCONSTANT	{$$ = $1;}
	| T_CHARCONSTANT	{$$ = $1;}
	| T_STRINGCONSTANT	{$$ = $1;}
	| T_TRUE			{$$ = "1";}
	| T_FALSE			{$$ = "1";}
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
    fprintf(stderr, "%s at line %d\n", msg, yyget_lineno());
}

void createSymbol(char *name, int type, char* value){
	strcpy(symbols[symbol_count].name, name);
	switch(type){
		case T_INTTYPE:
			symbols[symbol_count].type = T_INTTYPE;
			symbols[symbol_count].intValue = atoi(value);
			break;
		case T_STRINGTYPE:
			symbols[symbol_count].type = T_STRINGTYPE;
			strcpy(symbols[symbol_count].stringValue, value);
			break;
		case T_BOOLTYPE:
			symbols[symbol_count].type = T_BOOLTYPE;
			symbols[symbol_count].boolValue = strcmp(value, "true");
			break;
		default:
			break;
	}
	symbol_count += 1;
}

void printSymbols(){
	for(int i=0;i<symbol_count;i++){
		printf("symbol name:%s\t", symbols[i].name);
		printf("symbol type:%d\t", symbols[i].type);
		switch(symbols[i].type){
			case T_INTTYPE:
				printf("symbol value:%d\n", symbols[i].intValue);
				break;
			case T_STRINGTYPE:
				printf("symbol value:%s\n", symbols[i].stringValue);
				break;
			case T_BOOLTYPE:
				printf("symbol value:%s\n", symbols[i].boolValue? "true" : "false");
				break;
			default:
				printf("unexpected type\n");
				break;
		}
	}
	printf("\n");
}


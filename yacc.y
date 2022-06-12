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
    
    // symbol table
    typedef struct symbol{
		int type;
		char name[100];
		int intValue;
		bool boolValue;
		char stringValue[MAXSIZE];
		int returnType;
		char param[100];
		int passing; // value or reference
	}symbol;
	
	int symbol_count = 0;
	symbol symbols[MAXSIZE];
	int searchSymbol(char *name);
	void createSymbol(char *name, int type, int returnType, char *value, char* param);
	void updateSymbol(char *name, char *value);
	void printSymbols();
	
	// function
	char* binaryCompute(char *a_name, int operator, char *b_name);
	char computeResult[20];
	
	char declaredSymbol[10][100];
	int declaredIndex = 0;
	char** addList(char *name);
	

%}

// struct
%union{
	char *yy_str;
	char **yy_strList;
	int yy_int;
}
%type <yy_int> type methodType externType binaryOperators mathOperator compareOperator;
%type <yy_str> constant;


// type
%token <yy_str> T_VAR T_TRUE T_FALSE T_NULL T_STRINGCONSTANT T_INTCONSTANT T_CHARCONSTANT T_HEXCONSTANT
%token <yy_int> T_VOID T_INTTYPE T_BOOLTYPE T_STRINGTYPE 
// compare & operator
%token <yy_int> T_EQ T_NEQ T_GEQ T_GT T_LEQ T_LT T_PLUS T_MINUS T_MULT T_DIV T_MOD T_NOT T_OR T_AND T_ASSIGN 
// function
%token <yy_int> T_FUNC
%token T_RETURN T_WHILE T_IF T_ELSE T_FOR T_BREAK T_CONTINUE
// sign
%token T_COMMA T_LSB T_RSB T_SEMICOLON T_LCB T_RCB T_LPAREN T_RPAREN T_DOT T_LEFTSHIFT T_RIGHTSHIFT
// other
%token <yy_str> T_ID
%token T_PACKAGE T_EXTERN T_COMMENT T_WHITESPACE T_WHITESPACE_N

%left T_PLUS T_MINUS T_MULT T_DIV T_MOD
%right T_ASSIGN
%left T_OR T_AND
%left T_GEQ T_GT T_LEQ T_LT
%left T_EQ T_NEQ
%right T_NOT

%%

/* --------grammar-------- */

program: externs T_PACKAGE T_ID T_LCB fieldDecls methodDecls T_RCB	{printSymbols();};

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
	| T_VAR T_ID type T_ASSIGN constant T_SEMICOLON	{ createSymbol($2, $3, T_VOID, $5, ""); }
;

// method
methodDecls: methodDecls methodDecl
	| methodDecl
	|
;
methodDecl: T_FUNC T_ID T_LPAREN idTypes T_RPAREN methodType block	{ createSymbol($2, $1, $6, "0", ""); }
	| T_FUNC T_ID T_LPAREN T_RPAREN methodType block	{ createSymbol($2, $1, $5, "0", ""); }
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
varDecl: T_VAR ids type T_SEMICOLON	{
	for(int i=0;i<declaredIndex;i++){
		createSymbol(declaredSymbol[i], $3, T_VOID, "0", "");
	}
	declaredIndex = 0;
}
;

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
	| constant	{$<yy_str>$ = $1;}
	| expr binaryOperators expr	{ $<yy_str>$ = binaryCompute($<yy_str>1, $2, $<yy_str>3);}
	| unaryOperators expr
	| T_LPAREN expr T_RPAREN
	| T_ID T_LSB expr T_RSB
;

assigns: assigns T_COMMA assign
	| assign
;
assign: lValue T_ASSIGN expr	{updateSymbol($<yy_str>1, $<yy_str>3);}
;
lValue: T_ID	{$<yy_str>$ = $1;}
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
ids: ids T_COMMA T_ID	{$<yy_strList>$ = addList($3);}
	| T_ID	{$<yy_strList>$ = addList($1);}
;
idTypes: idTypes T_COMMA idTypes
	| T_ID type
;
type: T_INTTYPE				{$$ = $1;}
	| T_BOOLTYPE			{$$ = $1;}
;
externType: T_STRINGTYPE	{$$ = $1;}
	| type					{$$ = $1;}
;
methodType: T_VOID			{$$ = $1;}
	| type					{$$ = $1;}
;
arrayType: T_LSB T_INTCONSTANT T_RSB type ;
constant: T_INTCONSTANT	{$$ = $1;}
	| T_CHARCONSTANT	{$$ = $1;}
	| T_STRINGCONSTANT	{$$ = $1;}
	| T_TRUE			{$$ = "1";}
	| T_FALSE			{$$ = "0";}
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

// search element in symbol table return index
int searchSymbol(char *name){
	for(int i=0;i<symbol_count;i++){
		if(strcmp(symbols[i].name, name)==0){
			return i;
		}
	}
	return -1;
}

// store variable
void createSymbol(char *name, int type, int returnType, char *value, char* param){
	int check = searchSymbol(name);
	if(check != -1){
		char error[] = "The name \"";
		strcat(error, name);
		strcat(error, "\" has duplicate declare");
		yyerror(error);
		exit(1);
	}
	
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
			symbols[symbol_count].intValue = atoi(value);
			break;
		case T_FUNC:
			symbols[symbol_count].type = T_FUNC;
			symbols[symbol_count].returnType = returnType;
			strcpy(symbols[symbol_count].param, param);
			break;
		default:
			break;
	}
	symbol_count += 1;
}

// update value of symbol

void updateSymbol(char *name, char *value){
	int index = searchSymbol(name);
	if(index == -1){
		char error[] = "The name \"";
		strcat(error, name);
		strcat(error, "\" doesn't exist");
		yyerror(error);
		exit(1);
	}
	switch(symbols[index].type){
		case T_INTTYPE:
			symbols[index].intValue = atoi(value);
			break;
		case T_STRINGTYPE:
			strcpy(symbols[index].stringValue, value);
			break;
		case T_BOOLTYPE:
			symbols[index].intValue = atoi(value);
			break;
		default:
			break;
	}
}

// print symbol table
void printSymbols(){
	for(int i=0;i<symbol_count;i++){
		printf("symbol name:%s\t", symbols[i].name);
		switch(symbols[i].type){
			case T_INTTYPE:
				printf("symbol type:int\t\t");
				printf("symbol value:%d\n", symbols[i].intValue);
				break;
			case T_STRINGTYPE:
				printf("symbol type:string\t");
				printf("symbol value:%s\n", symbols[i].stringValue);
				break;
			case T_BOOLTYPE:
				printf("symbol type:bool\t");
				printf("symbol value:%s\n", symbols[i].intValue? "true" : "false");
				break;
			case T_FUNC:
				printf("symbol type:function\t");
				printf("symbol return type:%d\t", symbols[i].returnType);
				printf("symbol param:%s\n", symbols[i].param);
				break;
			default:
				printf("unexpected type\n");
				break;
		}
	}
	printf("\n");
}

// handle multiple declare
char** addList(char *name){
	strcpy(declaredSymbol[declaredIndex], name);
	declaredIndex += 1;
	return (char**)declaredSymbol;
}

// math compute
char* binaryCompute(char *a_name, int operator, char *b_name){
	int index;
	symbol a, b;
	// handle a, if a is name then search symbol , if not then assign value
	if(atoi(a_name) == 0 && strcmp(a_name, "0") != 0){
		index = searchSymbol(a_name);
		if(index == -1){
			yyerror("The variable doesn't exist");
			exit(1);
		}
		a = symbols[index];
	}
	else{
		a.intValue = atoi(a_name);
		a.type = T_INTTYPE;
	}
	// handle b
	if(atoi(b_name) == 0 && strcmp(b_name, "0") != 0){
		index = searchSymbol(b_name);
		if(index == -1){
			yyerror("The variable doesn't exist");
			exit(1);
		}
		b = symbols[index];
	}
	else{
		b.intValue = atoi(b_name);
		b.type = T_INTTYPE;
	}
	// type error
	if((a.type != T_INTTYPE && a.type != T_BOOLTYPE) || (b.type != T_INTTYPE && b.type != T_BOOLTYPE)){
		yyerror("Wrong type to calculate.");
		exit(1);
	}
	
	int result;
	switch(operator){
		case T_PLUS:
			printf("%d + %d = %d\n", a.intValue, b.intValue, a.intValue + b.intValue);
			result = a.intValue + b.intValue;
			break;
		case T_MINUS:
			printf("%d - %d = %d\n", a.intValue, b.intValue, a.intValue - b.intValue);
			result = a.intValue - b.intValue;
			break;
		case T_MULT:
			printf("%d * %d = %d\n", a.intValue, b.intValue, a.intValue * b.intValue);
			result = a.intValue * b.intValue;
			break;
		case T_DIV:
			printf("%d / %d = %d\n", a.intValue, b.intValue, a.intValue / b.intValue);
			result = a.intValue / b.intValue;
			break;
		case T_MOD:
			printf("%d mod %d = %d\n", a.intValue, b.intValue, a.intValue % b.intValue);
			result = a.intValue % b.intValue;
			break;
		default:
			printf("unexpected operator\n");
				break;
	}
	sprintf(computeResult, "%d", result);
	return computeResult;
}

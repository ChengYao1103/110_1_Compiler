build: parser
.PHONY: clean

parser: lex.yy.c y.tab.c
	gcc -o parser lex.yy.c y.tab.c

lex.yy.c: lex.l
	lex lex.l

y.tab.c: yacc.y
	yacc -d yacc.y

clean: 
	rm y.tab.h y.tab.c parser lex.yy.c


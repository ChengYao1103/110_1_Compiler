build: a

a: lex.yy.c
	gcc -o a lex.yy.c -lfl

lex.yy.c: lex.l
	lex lex.l

clean: 
	rm lex.yy.c a *.o
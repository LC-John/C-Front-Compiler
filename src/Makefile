all:	token

token:	c11.l c11.y main.c
	bison -d -y c11.y
	flex c11.l
	gcc y.tab.h y.tab.c lex.yy.c main.c -o $@

clean:
	rm -rf token a.out *.o lex.yy.* y.tab.* *.gch
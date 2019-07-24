all:	token tree

token:	c11_t.l c11_t.y main_t.c
	bison -d -y c11_t.y
	flex c11_t.l
	gcc y.tab.c lex.yy.c main_t.c -o $@
	rm y.tab.h y.tab.c

tree:	c11_p.l c11_p.y main_p.cpp	tree.h tree.cpp c11_p.l c11_p.y
	bison -d -y c11_p.y
	flex c11_p.l
	g++ tree.cpp y.tab.c lex.yy.c main_p.cpp -o $@ 
	rm y.tab.h y.tab.c

clean:
	rm -rf token tree a.out *.o lex.yy.* y.tab.* *.gch
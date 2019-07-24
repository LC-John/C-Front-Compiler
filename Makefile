all:
	(cd src; make)
	cp src/token ./
	cp src/tree ./

clean:
	(cd src; make clean)
	rm -rf token
	rm -rf tree
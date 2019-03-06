all:
	(cd src; make)
	cp src/token ./

clean:
	(cd src; make clean)
	rm -rf token
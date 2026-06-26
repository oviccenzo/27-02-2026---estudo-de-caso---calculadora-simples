PROG=calculadora

run: compile
	./bin/$(PROG).exe

compile: clean parser scanner
	gcc ./bin/$(PROG).tab.c ./bin/$(PROG).yy.c -o ./bin/$(PROG).exe -lfl

parser:
	mkdir -p ./bin
	bison -d $(PROG).y -o ./bin/$(PROG).tab.c

scanner:
	mkdir -p ./bin
	flex --outfile=./bin/$(PROG).yy.c $(PROG).l
	
clean:
	rm -rf ./bin/*
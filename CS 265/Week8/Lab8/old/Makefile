# CS265, Lab 8 Part 2 Makefiles
# Geoffrey Xiao, gx26

cc = gcc
EXE = foo
JAVAC = javac
JRE = java
PAGER = less
TEST_OUT = test.out
EXP_OUT = expected.out

.PHONY : clean run-py run-c read run-java save-java test-java

foo.o : foo.c foo.h
	$(cc) -c foo.c

main.o : main.c foo.h
	$(cc) -c main.c

$(EXE) : foo.o main.o
	$(cc) foo.o main.o -o $(EXE)

run-c : $(EXE)
	./$(EXE)

run-py : foo.py
	python ./foo.py

read :
	if [ -e README ]; then \
		$(PAGER) README; \
	fi;

foo.class : foo.java
	$(JAVAC) foo.java

run-java : foo.class
	$(JRE) foo

save-java : foo.class
	$(JRE) foo > $(TEST_OUT)

test-java : $(TEST_OUT) $(EXP_OUT)
	-@if diff $(TEST_OUT) $(EXP_OUT) &> /dev/null ; then \
  		echo "Passed!" ;\
	else \
		echo "Not the same!" ;\
	fi

clean :
	-rm *.class
	-rm $(TEST_OUT)
	-rm $(EXE)
	-rm *.o

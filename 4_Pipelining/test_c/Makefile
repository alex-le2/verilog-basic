ref.o: ref.c
	gcc -c ref.c

test: ref.o
	gcc -o test ref.o

all: test

clean:
	rm -f ref.o test

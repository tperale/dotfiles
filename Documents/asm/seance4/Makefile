FLAG = -ggdb3 -Wpedantic -Wall -Wextra -Winit-self -Winline -Wconversion -Weffc++ -Wstrict-null-sentinel -Wold-style-cast -Wnoexcept -Wctor-dtor-privacy -Woverloaded-virtual -Wconversion -Wsign-promo -Wzero-as-null-pointer-constant
OUTPUT = exercice.o
CC = g++
OBJ = test.cpp

all:
	nasm -f elf32 trace.asm -o trace.o
	$(CC) $(OBJ) trace.o -std=c++14 $(FLAG) -m32 -o $(OUTPUT)

clean:
	rm *.o

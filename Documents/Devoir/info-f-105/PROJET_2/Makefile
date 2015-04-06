file = IO.cpp
asmFILE1 = fibo1.asm
asmFILE2 = test2.asm
asmO1 = fibo1.o
asmO2 = test2.o

all: $(file) $(asmFILE1) $(asmFILE2)
	nasm -f elf32 $(asmFILE1) -o $(asmO1)
	g++ -Wall $(file) $(asmO1) -m32 -o $(asmO1)
	nasm -f elf32 $(asmFILE2) -o $(asmO2)
	g++ -Wall $(file) $(asmO2) -m32 -o $(asmO2)

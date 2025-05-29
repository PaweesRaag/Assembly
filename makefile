#makefile for [Prog].asm
[Prog]: [Prog].o
	gcc -o [Prog] [Prog].o -no-pie
[Prog].o: [Prog].asm
	nasm -f elf64 -g -F dwarf [Prog].asm -l [Prog].lst

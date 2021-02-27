// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here. 

// Idea is to loop R1 times, and each time add R0 to the result to yield the product

	@i    // init i = 0
	M=0
	@R2 // init R2 = 0
	M=0
	
(LOOP)
	@i
	D=M // set D=i
	@R1
	D=M-D // i = R1-i
	@END
	D;JLE // loop: while 0 < R1 - i == exit loop: 0 >= R1 - i
	@R0  
	D=M   // set D = R0
 	@R2
	M=M+D // R2 = R2 + R0
	@i
	M=M+1 // i = i + 1
	@LOOP
	0;JMP // goto LOOP
(END)
	@END
	0;JMP //terminate via inf loop
	
	
	
	
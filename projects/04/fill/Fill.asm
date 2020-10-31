// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// There are 256x32 = 8192 consecutive registers. 
// Bits in each register represent 16 pixels, 1 indicates black, 0 indicates white.
// Iterate between 16384 and 24575. 24576 stores keyboard input

	@16384// store current location of register 
	D=A
	@curr
	M=D    // init curr to 16384
	
	@24576 // Check if any key is pressed (if so, >0, else 0)
	D=M
	@LOOPDEL // if 0 then move to delete
	D;JEQ
	
(LOOPINS) // loop over all 256*32=8192 registers

	@24576 // Check if any key is pressed (if so, >0, else 0)
	D=M
	@LOOPDEL // if 0 then move to delete
	D;JEQ
	
	
	@curr
	D=M
	@24575
	D=D-A // D = curr - 24575
	@LOOPINS
	D;JGT// break when curr > 24575 or curr - 24575 > 0

	@0  // move to write 1s
	D=A-1
	@curr // load location of current register
	A=M  // switch to that location
	M=D // Set the current register to -1 = 16 1s
	@curr
	M=M+1
	
	@LOOPINS
	0;JMP
	
(LOOPDEL)
	@24576 // Check if any key is pressed (if so, >0, else 0)
	D=M
	@LOOPINS // if >0 move to INS
	D;JGT
	
	@curr
	D=M 
	@16384
	D=D-A // curr = curr - 16384
	@LOOPDEL
	D;JLT// break when curr < 16384 or curr - 16384 < 0

	@curr
	A=M 
	M=0 
	@curr
	M=M-1

	@LOOPDEL
	0;JMP 
	


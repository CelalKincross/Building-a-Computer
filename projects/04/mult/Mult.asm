// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.
// PUT YOUR CODE HERE:

// Pseudocode
// Example 3*8
// Load 3 in R0
// Load 8 in R1
// total = 0
// for i in range(0,8):
// 	total = total + R0 
// R2 = total


// i = 1
    @i 
    M=1
    // result = 0
    @res
    M=0
(LOOP)
    // if (i > R1) go to STOP
    @i
    D=M
    @R1
    D=D-M
    @STOP
    D;JGT

    // res = res + R0
    @res
    D=M
    @R0
    D=D+M
    @res
    M=D

    // i = i + 1
    @i
    M=M+1

    // goto LOOP
    @LOOP
    0;JMP

(STOP)
    // R2 = res
    @res
    D=M
    @R2
    M=D
(END)
    @END
    0;JMP
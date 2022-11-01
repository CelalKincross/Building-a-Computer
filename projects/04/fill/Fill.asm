// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm


/////////  Pseudocode   ///////
// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" (-1 is 16 ones in binary) in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" (0 is white all zeros in binary) in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// initialize a variable with total pixels
    @8192
    D=M
    @pixels
    M=D //sets pixels to 8192- total number of pixels
    
    @i 
    M=0       // i = 0

    (KBDCHECK)  //Checks to see if keyboard is pressed
        @SCREEN  
        D=A 
        @addr
        M=D         //addr = 16384 which is the base address for screen

    
        @KBD   //Keyboard address
        D=M

        @KBDOFF
        D;JEQ    //if d is 0 then go to keyboard off loop
        @KBDON
        D; JNE    // if D is not zero go to keyboard on loop

    // Fill the screen
    (KBDON)
        @i
        D=M
        @pixels
        D=M-D
        @KBDCHECK 
        D; JGT    // if i is greater than pixels go to keyboard check

        @addr

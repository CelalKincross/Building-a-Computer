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

    //Continuous Loop that never ends
        @8192
        D=A 
        @pixels
        M=D //sets pixels to 8192- total number of pixels
    (KBDCHECK)      // checks to see if keyboard is pressed
    
        @i 
        M=0       // i = 0
        
        @KBD        // keyboard address
        D=M         // records keyboard output

        @KBDON
        D; JNE    // if D is not zero go to keyboard on loop

        (KBDOFF)    // check addresses for screen ranging from  RAM[16384] to RAM[24575]
            @i          // and enter 0 to make screen white
            D=M 
            @pixels     //number of pixels
            D=D-M       //i - 8192
            @KBDCHECK 
            D;JGE       // if D is greater than or equal 0 would mean i is at 8192 and screen is white (0's in all pixels)
                        // control goes to KBDCHECK

            @SCREEN     // screen pointer 16384
            D=A         
            @i 
            A=D+M        //A = 16384 + i 
            M=0          // set to 0
            @i
            M=M+1        //set i+1  
            
            @KBDOFF
            0;JMP       // continue till all 0's in screen mapping

    

        // Fill the screen
        (KBDON)
            @i
            D=M
            @pixels
            D=D-M
            @KBDCHECK 
            D; JGE    // if i is greater than pixels go to keyboard check

            @SCREEN     // change screen black (-1 is 16 1's in binary)
            D=A         // get screen address and add i to it, then make that -1
            @i
            A=D+M 
            M=-1
            @i          // i + 1
            M=M+1

            @KBDON      // loop until screen is black
            0;JMP

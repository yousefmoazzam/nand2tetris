// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(CHECKKEY)
    // Check if no key is pressed (and jump to a loop to lighten the screen if
    // so)
    @KBD
    D = M
    @LIGHTENSCREEN
    D,JEQ
    // Check if any key is pressed (and jump to a loop to darken the screen if
    // so)
    @KBD
    D = M
    @DARKENSCREEN
    D,JNE
    // Continue looping and checking if a key is pressed or not
    @CHECKKEY
    0,JMP

(DARKENSCREEN)
    // Initialise variable holding index within screen memory map area
    @SCREEN
    D = A
    @darkenidx
    M = D
(DARKENSCREENLOOP)
    // Set the 16 pixels in the current address to 1 (black)
    @darkenidx
    D = M
    A = D
    D = 0
    M = !D
    // Check if key is still pressed
    @KBD
    D = M
    // If key is not pressed anymore, then get ready to exit loop
    @DARKENSCREENLOOPEXIT
    D,JEQ
    // Else if key is still pressed, increment index
    @darkenidx
    D = M
    D = D+1
    M = D
    // Check if the end of the screen memory map area has been reached, and if
    // so, prepare to exit the loop
    @KBD
    A = A-D
    D = A
    @DARKENSCREENLOOPEXIT
    D,JEQ
    // Otherwise, jump to the start of the darken loop
    @DARKENSCREENLOOP
    0,JMP
(DARKENSCREENLOOPEXIT)
    // Reset `darkenidx` variable before jumping back
    @SCREEN
    D = A
    @darkenidx
    M = D
    // Jump back to main loop
    @CHECKKEY
    0,JMP

(LIGHTENSCREEN)
    // Initialise variable holding index within screen memory map area
    @SCREEN
    D = A
    @lightenidx
    M = D
(LIGHTENSCREENLOOP)
    // Set the 16 pixels in the current address to 0 (white)
    @lightenidx
    D = M
    A = D
    M = 0
    // Check if key is still not pressed
    @KBD
    D = M
    // If key is pressed now, then get ready to exit loop
    @LIGHTENSCREENLOOPEXIT
    D,JNE
    // Else if key is still not pressed, increment index
    @lightenidx
    D = M
    D = D+1
    M = D
    // Check if the end of the screen memory map area has been reached, and if
    // so, prepare to exit the loop
    @KBD
    A = A-D
    D = A
    @LIGHTENSCREENLOOPEXIT
    D,JEQ
    // Otherwise, jump to the start of the lighten loop
    @LIGHTENSCREENLOOP
    0,JMP
(LIGHTENSCREENLOOPEXIT)
    // Reset `lightenidx` variable before jumping back
    @SCREEN
    D = A
    @lightenidx
    M = D
    // Jump back to main loop
    @CHECKKEY
    0,JMP

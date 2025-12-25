// Compute `R0 * R1` and store the result in `R2`
//
// The strategy to accomplish this is to add the value stored in `R0` to the
// output register `R2`, the number of times that is stored in the register
// `R1`

// Zero the register in which the output will be stored
    @R2
    M = 0
// Skip loop altogether if multiplier is 0
    @R1
    D = M
    @END
    D,JEQ
// Setup loop variable
    @R1
    D = M
    @count
    M = D
(LOOP)
// Store the value to be multiplied in the D register
    @R0
    D = M
// Add one instance of the value in R0 to the output register
    @R2
    M = D+M
// Decrement the loop variable by 1
    @count
    M = M-1
// If the loop variable is greater than 0, then jump back to the start of the
// loop
    @count
    D = M
    @LOOP
    D,JGT
(END)
    @END
    0,JMP

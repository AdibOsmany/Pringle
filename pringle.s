
/*  
    Name: Adib Osmany
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

//would like to be considered for the extra credit. 

.global pringle

pringle:
    //saves callee saved registers (all X19-X30)
    SUB SP, SP, 176                              //allocate stack frame
   STR X30, [SP]                                 //Store X30
   STR X29, [SP, 8]                              //stores X29
   STR X28, [SP, 16]                             //stores X28
   STR X27, [SP, 24]                             //stores X27
   STR X26, [SP, 32]                             //stores X26
   STR X25, [SP, 40]                             //stores X25
   STR X24, [SP, 48]                             //stores X24
   STR X23, [SP, 56]                             //stores X23
   STR X22, [SP, 64]                             //stores X22
   STR X21, [SP, 72]                             //stores X21
   STR X20, [SP, 80]                             //stores X20
   STR X19, [SP, 88]                             //stores X19

    MOV X9, X0                                   //stores the string into X9
    MOV X0, X1                                   //stores the first array into X0
    MOV X1, X2                                   //stores the frist array length into X1
    MOV X2, X9                                   //stores the string into X2
    STR X3, [SP, 96]                             //stores the second array into the stack
    STR X4, [SP, 104]                            //stores the second array length into the stack
    STR X5, [SP, 112]                            //stores the third array into the stack
    STR X6, [SP, 120]                            //stores the third array length into the stack
    STR X7, [SP, 128]                            //stores the fourth array into the stack

    ADR X8, output                               //stores the address of output into X8
    MOV X13, 0                                   //stores 0 into X13, representing the offset for the string
    MOV X14, 0                                   //stores 0 into X14, representing the offset for the output
    MOV X15, 0                                   //stores 0 into X15, which will represent the number of arrays

    TO_HERE:
    MOV X9, 37                                   //stores 37 into x9 which is the ascii representation of %
    MOV X10, 97                                  //stores 97 into x10 which is the ascii representation of a

    LOOP:
    LDRB W18, [X2, X13]                          //loads an element from X2 to W18
    CMP W18, WZR                                 //checks if the element is a null-termintor
    B.EQ return                                  //goes to return if so
    STRB W18, [X8, X14]                          //stores the element into the output
    ADD X13, X13, 1                              //increases the string offset by 1
    ADD X14, X14, 1                              //increases the output offset by 1
    CMP W18, W9                                  //checks if W18 is %
    B.EQ CHECK                                   //goes to CHECK if so
    B LOOP                                       //loops to LOOP

    CHECK:
    LDRB W18, [X2, X13]                          //loads an element from X2 to W18
    CMP W18, WZR                                 //checks if the element is a null-termintor
    B.EQ return                                  //goes to return if so
    CMP W18, W10                                 //checks if W18 is 'a'
    B.EQ GET_ARRAY                               //goes to GET_ARRAY if so
    B LOOP                                       //loops to LOOP

    GET_ARRAY:
    ADD X13, X13, 1                               //increases the string offset by 1
    SUB X14, X14, 1                               //subtracts the output offset by 1
    ADD X15, X15, 1                               //increases the total '%a' by 1

    
    CMP X15, 1                                   //checks if the total is 1
    B.EQ CONCAT                                  //goes to concat if so
    CMP X15, 2                                   //checks if the total is 2
    B.EQ SECOND_ARRAY                            //goes to SECOND_ARRAY if so
    CMP X15, 3                                   //checks if the total is 3
    B.EQ THIRD_ARRAY                             //goes to THIRD_ARRAY if so
    CMP X15, 4                                   //checks if the total is 4
    B.EQ FOURTH_ARRAY                            //goes to FOURTH_ARRAY if so
    B.GT MORE_ARRAY                              //goes to MORE_ARRAY if greater than 4


    SECOND_ARRAY:
    LDR X0, [SP, 96]                             //loads the second array into X0
    LDR X1, [SP, 104]                            //loads the length of the second array into X1
    B CONCAT                                     //goes to CONCAT

    THIRD_ARRAY:
    LDR X0, [SP, 112]                            //loads the third array into X0
    LDR X1, [SP, 120]                            //loads the length of the third array into X1
    B CONCAT                                     //goes to CONCAT

    FOURTH_ARRAY:
    LDR X0, [SP, 128]                            //stores the fourth array into X0
    LDR X1, [SP, 176]                            //stores the length of the fourth array into X1
    B CONCAT                                     //goes to CONCAT

    /*The math used for MORE_ARRAY piece of code
        X: X15, N: X11, M: X12
        N=X
        M=X
        M=(M-5)*8
        N=(N*8)+144
        N+=M
        X0=N (array)
        N+=8
        X1=N (length)
    */
                                            
    MORE_ARRAY:                             
    MOV X7, 8                                   //stores 96 into X2 to be used later for multiplication
    MOV X11, X15                                //stores X15 to X11
    MOV X12, X15                                //stores X15 to X12,
    SUB X12, X12, 5                             //subtracts 5 from X12
    MUL X12, X12, X7                            //increases X12 96 times
    MUL X11, X11, X7                            //increases X11 96 times
    ADD X11, X11, 144                           //adds 64 to X11
    ADD X11, X11, X12                           //adds X12 to X11
    LDR X0, [SP, X11]                           //stores an array into X0
    ADD X11, X11, 8                             //increases X11 by 96 to go to the length in the stack frame
    LDR X1, [SP, X11]                           //stores the length of the array into X1
    B CONCAT                                    //goes to CONCAT


    CONCAT:
    //saves caller-saved registers
    STR X2,[SP,136]                              //Stores the string into the stack
    STR X8,[SP,144]                              //Stores X8
    STR X13,[SP,152]                             //Stores X13
    STR X14,[SP,160]                             //Stores X14
    STR X15,[SP,168]                             //Stores X15
    BL concat_array                              //branches and links to concat_array to get the string representation of an array
    LDR X2,[SP,136]                              //Re-Stores X2
    LDR X8,[SP,144]                              //Re-Stores X8
    LDR X13,[SP,152]                             //Re-Stores X13
    LDR X14,[SP,160]                             //Re-Stores X14
    LDR X15,[SP,168]                             //Re-Stores X15

    MOV X16, 0                                  //stores 0 into X16 which will act as a way to increment through X17
    MOV X17, X0                                 //stores the string representation of an array from concat_array into X17

    ARRAY_LOOP:
    LDRB W18, [X17,X16]                         //loads an element from X17 to W18
    CMP  W18, WZR                               //checks if W18 is a null terminator
    B.EQ TO_HERE                                //goes to TO_HERE if so, which continues on with the string
    STRB W18, [X8, X14]                         //stores W18 into the output
    ADD X14, X14, 1                             //increases the output offset by 1
    ADD X16, X16, 1                             //increases incrementor by 1
    B ARRAY_LOOP                                //loops to ARRAY_LOOPss


    return:
    STRB WZR, [X8,X14]                          //stores a null termintor at the end of output

   
    MOV X0, 1                                   //destination for printing
    MOV X1, X8                                  //stores the output into X1
    MOV X2, X14                                 //stores the length of the output into X2
    MOV X8, 64                                  //system call number
    SVC 0                                       //invoke system call

    SUB X14, X14, 1                             //subtracts 1 from the length
    MOV X0, X14                                 //stores the length into X0 to be returned


    LDR X19, [SP, 88]                   //re-store X19
    LDR X20, [SP, 80]                   //re-stores X20
    LDR X21, [SP, 72]                   //re-stores X21
    LDR X22, [SP, 64]                   //re-stores X22
    LDR X23, [SP, 56]                   //re-stores X23
    LDR X24, [SP, 48]                   //re-stores X24
    LDR X25, [SP, 40]                   //re-stores X25
    LDR X26, [SP, 32]                   //re-stores X26
    LDR X27, [SP, 24]                   //re-stores X27
    LDR X28, [SP, 16]                   //re-stores X28
    LDR X29, [SP, 8]                    //re-stores X29
    LDR X30, [SP]                       //re-stores X30
    ADD SP, SP, 176                     //de-allocates the frame
    
    RET                                         //returns

/*
    Declare .data here if you need.
*/
.data
    output: .fill 1024, 1, 0                    //output data
    

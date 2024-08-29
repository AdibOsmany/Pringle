
/*  
    Name: Adib Osmany
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global count_specs

count_specs:
    //saves callee saved registers (all X19-X30)
    SUB SP, SP, 96                      //allocate stack frame
    STR X30, [SP]                        //Store X30
    STR X29, [SP, 8]                     //stores X29
    STR X28, [SP, 16]                    //stores X28
    STR X27, [SP, 24]                    //stores X27
    STR X26, [SP, 32]                    //stores X26
    STR X25, [SP, 40]                    //stores X25
    STR X24, [SP, 48]                    //stores X24
    STR X23, [SP, 56]                    //stores X23
    STR X22, [SP, 64]                    //stores X22
    STR X21, [SP, 72]                    //stores X21
    STR X20, [SP, 80]                    //stores X20
    STR X19, [SP, 88]                    //stores X19
    MOV X8, X0                          //stores the string into X8
    MOV X9, 37                          //stores 37 into X9 which is the ascii representation of %
    MOV X10, 97                         //stores 97 into X10 which is the ascii representation of a
    MOV X11, 0                          //stores 0 into X11 which represents our total
    MOV X12, 0                          //istores 0 into X12 which will help represent our incrementor through X8

    //loop to check for an element is %
    LOOP:
    LDRB W13, [X8, X12]                 //loads an element from X8 to W13
    CMP W13, WZR                        //checks if the element is a null-termintor
    B.EQ return                         //goes to return if so
    ADD X12, X12, 1                     //increases the incrementor by 1
    CMP W13, W9                         //checks if W13 is %
    B.EQ CHECK                          //goes to check if so
    B LOOP                              //loops to LOOP

 //loop to check for an element is 'a'
    CHECK:
    LDRB W13, [X8, X12]                 //loads an element from X8 to W13
    CMP W13, WZR                        //checks if the element is a null-termintor
    B.EQ return                         //goes to return if so
    CMP W13, W10                        //checks if W13 is 'a'
    B.NE LOOP                           //goes to LOOP if not
    ADD X11, X11, 1                     //increases the total by 1
    B LOOP                              //loops to LOOP

   return:
    MOV X0, X11                         //stores the total into X0 to be returned
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
    ADD SP, SP, 96                      //de-allocates the frame
    RET                                 //returns



/*
    Declare .data here if you need.
*/

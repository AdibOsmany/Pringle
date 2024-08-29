
/*  
    Name: Adib Osmany
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global itoascii

itoascii: 
   //saves callee saved registers (all X19-X30) 
   SUB SP, SP, 96                       //allocate stack frame
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
   MOV X8, X0                       //stores X0 int X8, representing the integer
   ADR X0, buffer                   // X0 represents the address of buffer so that it gets returned
   
   MOV X9, 1                        //X9 represents the length and starts at 1
   MOV X10, 10                      //Stores 10 into X10 which will be used to find the each digit
   MOV X11, X8                      //stores X8 int X11, representing the integer again
   MOV X13, 48                      //Stores 48 into X13 to add to values later for its ascii representation
   MOV X14, 0                       //Stores 0 into X14, and will be used to increment through buffer
   MOV X15, 10                      //stores 10 into X15, which will be used to divide and multiply by 10

   //base case for if the integer is 0
   /*base case */ 
   CMP X11, 0                       //checks if the integer is 0
   B.NE LOOP                        //if not, then it goes to LOOP
   STRB W13, [X0]                   //Stores the ascii value of 0 into buffer
   B return                         //goes to return

   //Loop to find how big the integer goes up to
   LOOP:
   CMP X10, X11                     //compares X10 and X11(integer)
   B.GT LENGTH                      //If X10 is greater, it goes to LENGTH
   ADD X9, X9, 1                    //Adds 1 to X9
   MUL X10, X10, X15                //multiplies X10 by 10
   B LOOP                           //goes to loop

   LENGTH:
   UDIV X10, X10, X15               //divides X10 by 10
   MOV X12, 0                       //X12 is used to represent a digit in the integer

   LENGTH_INNER_LOOP:
   CMP X11, X10                     //compares X11(integer) with X10
   B.LT DIGIT                       //if X11 is less than X10, then it goes to DIGIT
   MOV X11, X8                      //Stores X8 into X11
   ADD X12, X12, X10                //adds X10 to X12
   SUB X11, X11, X12                //subtract X12 from X11
   B LENGTH_INNER_LOOP              //goes to length_inner_loop

//loop to help find one of the digits in the integer
   DIGIT:
   MOV X8, X11                      //Stores X11 into X8
   UDIV X16, X12, X10               //divides X12 with X10 and stores it in X16, which represents a digit
   ADD  X16, X16, X13               //add 48 to the digit to get its ascii value
   STRB W16, [X0, X14]              //stores register 18 to buffer
   ADD  X14, X14, 1                 //increases X14 by 1
   CMP X14, X9                      //compares X14 with X9 to check if we are at the end of the integer
   B.EQ return                      //if so then we go to return
   B LENGTH                         //goes to LENGTH

   return:
   STRB WZR, [X0,X9]                //Stores the null-termintor into buffer
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
   ADD SP, SP, 96                     //de-allocates the frame
   RET                              //returns
 
.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0



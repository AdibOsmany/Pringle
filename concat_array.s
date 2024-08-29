
/*  
    Name: Adib Osmany
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global concat_array

concat_array:
   //saves callee saved registers (all X19-X30)
   SUB SP, SP, 152                      //allocate stack frame
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

   MOV X8, X0                          //stores the array into X8
   MOV X9, X1                          //stores the length into X9
   ADR X10, concat_array_outstr        //stores the address of concat_array_outstr into X10
   MOV X11, 0                          //stores 0 into X11 which will be used to help increment through the array
   MOV X12, 0                          //stores 0 into X12 which will be used to help offset X10
   MOV X13, 32                         //stores 32 into X13 which is the ascii representation of a space
   MOV X14, 0                          //stores 0 into X14 which will be used to help check if we are at the end of the array

 
   //BASE CASE
   CMP X9, 0                           //checks if the length is 0
   B.EQ return                         //if so it goes to return
  

   LOOP:
   LDR X0, [X8, X11]                    //loads an element of the array into X0
   //saves caller-saved registers
   STR X8,[SP,96]                       //Store X8
   STR X9,[SP,104]                      //Store X9
   STR X10,[SP,112]                     //Store X10
   STR X11,[SP,120]                     //Store X11
   STR X12,[SP,128]                     //Store X12
   STR X13,[SP,136]                     //Store X13
   STR X14,[SP,144]                     //Store X14
   BL itoascii                          //branches and links to itoascii to get the string representation of X0
   //restores caller-saved registers
   LDR X8,[SP,96]                       //re-stores X8
   LDR X9,[SP,104]                      //re-stores X9
   LDR X10,[SP,112]                     //re-stores X10
   LDR X11,[SP,120]                     //re-stores X11
   LDR X12,[SP,128]                     //re-stores X12
   LDR X13,[SP,136]                     //re-stores X13
   LDR X14,[SP,144]                     //re-stores X14

   MOV X16, X0                         //stores the string into X16
   MOV X17, 0                          //stores 0 into X17 which will be used to help increment through X16
   

   PLACE:
   LDRB W15, [X16, X17]                //loads a byte from X16 into W15
   CMP W15, WZR                        //checks if W15 is a null terminator
   B.EQ SHIFT                          //if so, then it goes to SHIFT
   STRB W15, [X10, X12]                //stores W15 into X10
   ADD X17, X17, 1                     //increases X17 by 1
   ADD X12, X12, 1                     //increases X12 by 1
   B PLACE                             //loops to PLACE
 

   SHIFT:
   STRB W13, [X10, X12]                //stores a space into X10
   ADD X12, X12, 1                     //increases X12(offset) by 1
   ADD X11, X11, 8                     //increases X11 by 8
   ADD X14, X14, 1                     //increases X14 by 1
   CMP X14, X9                         //checks if X14 is equalls to the length
   B.EQ return                         //if so then it goes to return
   B LOOP                              //loops to LOOP


   return:
   STRB WZR, [X10,X12]                 //Stores the null-termintor into X10
   MOV X0, X10                         //stores X10 into X0 so that it can be returned
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
   ADD SP, SP, 152                     //de-allocates the frame
   RET                                 //returns


.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
    concat_array_outstr:  .fill 1013, 1, 0


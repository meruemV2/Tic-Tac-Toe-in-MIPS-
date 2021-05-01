#####################################################
#                                                   #                                                               #						    #
# Name: Jerry Laplante                              #                                                                     # Class: CDA 3100                    	            #                                              
# Assignment:  #6 Tic-Tac-Toe gaming program 	    #
# Date: 7/1/2020                                    #  			    
#                                                   #                                                            
#                                                   #                                                                      
#####################################################


	.data
HELLO:	.asciiz "Hello, welcome to Jerry's Tic-Tac-Toe program.\n\n\n"
DIVIDE: .asciiz " | "
DASH:	.asciiz "\n---------\n"
SPACE:	.asciiz	"\n\n"
ARRAY:	.byte '1','2','3','4','5','6','7','8','9'
EQL: 	.byte	'\n'
X:	.byte	'X'
O:	.byte	'O'
START:	.asciiz	"Computer has made the first move. Enter a digit 1 - 9 that\ncorresponds to your desired position... \n\nGood Luck :)\n\n"
BADTXT:	.asciiz	"error: invalid input. Try again...\n\n"
CTURN:	.asciiz	"My turn...\n\n"
WINTXT:	.asciiz	"YOU WIN!\n\n"
LTXT:	.asciiz	"YOU LOSE! TRY AGAIN..\n\n"
OVRTXT:	.asciiz	"RESTART PROGRAM TO PLAY AGAIN \n\nGOODBYE :)"
T:	.asciiz	"ITS A TIE!\n\n"
	.align 2
	.text
	.globl main

main:
	li	$v0,4		#Print out string
	la	$a0,HELLO	#Load the welcome message
	syscall 		#Execute
	
	jal	PRINT		#jump to routine to print board

	li	$v0,4		#Print out string 
	la	$a0,START	#Load start message
	syscall 		#Execute

	lb	$t3,X		#Load X value
	la	$t4,ARRAY	#Load array of board values
	sb	$t3,4($t4)	#Put X in the middle (best first move)

	jal	PRINT		#Print board routine 

	li	$s4,1		#load 1 into memory to use as counter

	jal	GAME		#jump to Game routine
	
	jr	$ra

GAME:
	li	$a0,9		#Logic to loop through game until 
				#win, lose, or tie is determined
	
	jal	INPUT		#jump to input routine

	jal	PRINT		#jump to print routine

	jal	CHECKWIN	#jump to check win routine

	addiu	$s4,$s4,1	#increment counter in memory after input

	beq	$a0,$s4,TIE	#branch to tie when count is 9 and no winner is found

	jal	COMP		#jump to computer's turn routine
		
	jal	PRINT		#jump to print routine

	jal	CHECKWIN	#jump to check winner routine 
	
	addiu	$s4,$s4,1	#increment counter in memory after computers turn

	li	$a0,9		#load counter to check 
	blt	$s4,$a0,GAME	#Loops until one of three outcomes
	beq	$a0,$s4,TIE	#branch to tie when count is 9 with no winner
	
	jr	$ra
	
CHECKWIN:			#Routine to check for winner 
	li	$t1,0		#Load zero to reinitialize check variable
	li	$t1,1		#Load 1 to initialize counter 
	lb	$t2,O		#Load O for user inputs 	
	lb	$t3,X		#Load X for Computer input
	la	$t4,ARRAY	#Load address of array for board numbers
	

	lb	$t5,0($t4)	#Load bits for 1st row win
	lb	$t6,1($t4)
	lb	$t7,2($t4)
	
	move	$s1,$t0		#move zero into memory for check 
	and	$s1,$t5,$t2	#bitwise all values in row 
	and 	$s1,$s1,$t6	
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	#if all the values equal to O then user wins

	move	$s1,$t0		#reinitialize zero into memory for check 
	and	$s1,$t5,$t3	#bitwise all values in row
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE	#if all values equal to X then computer wins
	
	lb	$t5,3($t4)	#repeat logic for all rows, columns, and diagonals 
	lb	$t6,4($t4)
	lb	$t7,5($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE
	
	lb	$t5,6($t4)
	lb	$t6,7($t4)
	lb	$t7,8($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE

	lb	$t5,0($t4)
	lb	$t6,3($t4)
	lb	$t7,6($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE	

	lb	$t5,1($t4)
	lb	$t6,4($t4)
	lb	$t7,7($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE	


	lb	$t5,2($t4)
	lb	$t6,5($t4)
	lb	$t7,8($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	
	
	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE	

	lb	$t5,0($t4)
	lb	$t6,4($t4)
	lb	$t7,8($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE

	lb	$t5,2($t4)
	lb	$t6,4($t4)
	lb	$t7,6($t4)

	move	$s1,$t0
	and	$s1,$t5,$t2
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t2,WIN	

	move	$s1,$t0
	and	$s1,$t5,$t3
	and 	$s1,$s1,$t6
	and 	$s1,$s1,$t7
	beq	$s1,$t3,LOSE	

	jr	$ra

WIN:
	li	$v0,4		#Print out win message
	la	$a0,WINTXT	#Load the message
	syscall 		#Execute

	jr	OVER		#Jump to over routine 

TIE:
	li	$v0,4		#Print out string
	la	$a0,T		#Load the message
	syscall 		#Execute

	jr	OVER		#Jump to over routine 

LOSE:
	li	$v0,4		#Print out string
	la	$a0,LTXT	#Load the message
	syscall 		#Execute

	jr	OVER		#Jump to over routine

INPUT:	
	li	$v0,5		#Read in integer
	syscall			#Execute
	move	$s1,$v0		#Save into memory
	addiu	$s1,$s1,-1	#Minus one to get index into array 
	li	$s2,0		#Load zero into memory for Check routine
	jr	CHECK		#Jump to check routine
GOOD:	
	lb	$t1,O		#Load O into register
	la	$t3,ARRAY	#Load address of array 
	move	$t2,$s1		#Load user input into register
	add	$t2,$t2,$t3	#Add index into memory to access which number to change
	lb	$t4,0($t2)	#Load address of index
	sb	$t1,0($t2)	#Save O into address of index
	
	jr	$ra

CHECK:
	
	li	$a0,0		#Load integer to check lower bounds
	li	$a1,8		#Load integer to check upper bounds
	
	lb	$t1,O		#Load O into register
	lb	$t2,X		#Load X into register
	la	$t3,ARRAY	#Load address of Array of board numbers
	move	$t4,$s2		#Pass in zero from input to increment 
	add	$t4,$t4,$t3	#Load address into register
	move	$t6,$s1		#Passing in parameter of input
	add	$t6,$t6,$t3	#Index into array using input
	lb	$t7,0($t6)	#Load byte of address of index

	blt	$s1,$a0,BAD	#Branch to bad input if index is less than 0
	bgt	$s1,$a1,BAD	#Branch to bad input if index is more than 8
	beq	$t1,$t7,BAD	#Branch to bad input if space is taken 
	beq	$t2,$t7,BAD	#Branch to bad input id space is taken
	addiu	$s2,$s2,1	#Increment counter
	beq	$s2,$a1,GOOD	#After all numbers are checked, branch to good input
	
	jr	CHECK
	
BAD:
	li	$v0,4		#Print message
	la	$a0,BADTXT	#Load bad text message 
	syscall			#Execute

	jr	INPUT		#Jump back to input to try again 
	
COMP:
	li	$s3,-1		#initialize -1 into memory for counter
	jr	WHILE		#Jump to while loop

WHILE:
	addiu	$s3,$s3,1	#Add 1 into counter
	lb	$t1,X		#Load X byte
	lb	$t2,O		#Load O byte
	la	$t3,ARRAY	#Load address of array of board characters
	move	$t0,$s3		#Move counter from memory into register
	add	$t4,$t0,$t3	#Use counter to index into array
	lb	$t5,0($t4)	#Save address of index into register
	beq	$t5,$t1,WHILE	#Loop until empty space found
	beq	$t5,$t2,WHILE	#Loop until empty space found
	
	jr	EXIT
EXIT:
	li	$v0,4		#Print out string
	la	$a0,CTURN	#Load my turn message
	syscall 		#Execute

	lb	$t3,X		#Load X into register
	move	$t5,$s3		#Load index into register
	la	$t4,ARRAY	#Load address of array 
	add	$t5,$t5,$t4	#Use index into array 
	sb	$t3,0($t5)	#Save X into indexed array 

	jr	$ra

PRINT:				#Routine to print board
	addiu	$sp,$sp,-4	#Allocate memory 	
	sw	$ra,0($sp)
	jal	BOARD		#Call up board printing routine
	lw	$ra,0($sp)	#Free up memory 
	addiu	$sp,$sp,4

	jr	$ra		 


BOARD:	
	
	la	$t0,ARRAY	#Load address of array 
	lb	$a0,0($t0)	#Save array address into register
	li	$v0,11		#Print byte in array
	syscall

	li	$v0,4		#Print string
	la	$a0,DIVIDE	#Load address of slash for board
	syscall			#Execute
	
	la	$t0,ARRAY	#Increment index into address and print
	lb	$a0,1($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DIVIDE
	syscall

	la	$t0,ARRAY
	lb	$a0,2($t0)	
	li	$v0,11
	syscall

	li	$v0,4		#Print string
	la	$a0,DASH	#Load address of dashes for next row
	syscall			#Execute

	la	$t0,ARRAY	#Print next row
	lb	$a0,3($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DIVIDE
	syscall
	
	la	$t0,ARRAY
	lb	$a0,4($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DIVIDE
	syscall

	la	$t0,ARRAY
	lb	$a0,5($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DASH
	syscall

	la	$t0,ARRAY
	lb	$a0,6($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DIVIDE
	syscall
	
	la	$t0,ARRAY
	lb	$a0,7($t0)	
	li	$v0,11
	syscall

	li	$v0,4
	la	$a0,DIVIDE
	syscall

	la	$t0,ARRAY
	lb	$a0,8($t0)	
	li	$v0,11
	syscall
	
	li	$v0,4		#Print space after board is printed
	la	$a0,SPACE
	syscall	

	jr	$ra	

OVER:	
	li	$v0,4		#Print out string
	la	$a0,OVRTXT	#Load the message
	syscall 

	li	$v0,10		#End of program 
	syscall

	jr	$ra	
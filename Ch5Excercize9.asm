#########################################################
# File: Ch5Prob9.asm     
# Author: James Ortiz
# Programming Language: MIPS32 Assembly Language
#
# Purpose: Write a function to search through an 
# array X of N words to fund the minimum and 
# maximum values. The values of the array will
# be passed to the function useing register $a0, 
# and the number of words in the array will be passed
# in register $a1. The minimum and maximum values 
# are returned in registers $v0, and $v1 respectively.
#######################################################
#
######################Pseudocode#######################
# Function MaxMin(&X, N, Min, Max)
# "X" is the address of the array passed to the function in $a0
# "N" is the length of the array passed to the function in $a1
# The function returns two values:
# 1: The minimum value of the array, returned in $v0.
# 2: The maximum value of the array, returned in $v1.
#######################################################
#Pseudocode:
# 
#
#	$v0 = 0;
#	$v1 = 0;
#	
#	while(a1 > 0)
#	{
#		$a1 = $a1 - 1; #Decrement counter
#		$t0 = Mem(a0); #Obtain value from memory
#		$a0 = $a0 + 4; #Point to next address
#		if (value < $t0)
#		{
#			$v0 = value;
#		}
#		else if(value > $t0)
#		{
#			$v1 = value;
#		}
#			
#		
#	}
#	
#	return
#}
##########################################################

		.data
array: 	.word 		10, -5, 22, 57, 59, 63, 117, -100
msg1:  	.asciiz "\n The lowest value in the array is: "
msg2:   .asciiz "\n The highest value in the array is: "

		.globl main
		.text
main:
		li $v0, 4     #System call code for print string
		la $a0, msg1  #load address into msg1. into $a0
		syscall 
		
		la $a0, array #Initialize address parameter
		li $a1, 8     #Initialize length parameter
		jal MaxMin    #Calls function MaxMin 

		move $a0, $v0 #Min value returned from $v0 moved to $a0
		li 	 $v0, 1   #Calls system code to print integer
		syscall
		
		li 	$v0, 4 	  #Calls code to print string 
		la  $a0, msg2 #load address of msg2 to $a0
		syscall
		
		li 	$v0, 1	  #System call code for printing integer
		move $a0, $v1 #Maximum value returned from $v1 moved to $a0
		syscall 
		
		li 	$v0, 10   #Terminate program and return control to system 
		syscall 

		

		#------------MaxMin Function---------------#
MaxMin: 

		li $v0, 0  #Parameter for maxumum value
		li $v1, 0  #Parameter for minimum value
		li $t1, 0  #Holds old value of $t0 
		li $t2, 0  #Holds old value of $t0 
repeatd:
		beqz $a1, Return  #If $a1 <= 0 Exit Program
		addi $a1, $a1, -1 #Decrement counter 
		lw   $t0, 0($a0)  #Obtain value from the array
		addi $a0, $a0, 4 #Increment value of array pointer for next element
		bgt  $t0, $t1, maximum #if $t0 > $t1 goto maximum
		blt  $t0, $t2, minimum #if $t0 < $t2 goto minimum
		
maximum: 
		
		move $t1, $t0  #Move value of $t0 to $t1 
		move $v1, $t0  #Move value of $t1 to $v1 
		b repeatd      #Branch back to Loop 
		
minimum:

		move $t2, $t0  #Move value of $t0 to $t2
		move $v0, $t2  #Move value of $t1 to $v0 
		b repeatd         #Branch back to Loop

Return: 
		jr $ra       #Return values 
		
		#-------------MaxMin Function---------------#		





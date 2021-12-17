#
# final1.asm
# Mason Lewis
# 
# Question #5 of Final Exam
# Program to take digits through MM I/O and display them
#
# MIPS Simulation Settings
# Bare Machine: OFF, Psuedo Instructions: ON, Mapped IO: ON,
# Delayed Branches: ON, Delayed Loads: ON
#

	.data

pr1:	.asciiz "Please enter 3 numbers to be displayed.\n"
pr2:	.asciiz "The numbers were: "

	.text
	.globl main

main:

	li	$t3, 100		# multiplier
	li	$v0, 4			# print_string sys call code
	la	$a0, pr1		# address of start prompt
	syscall

	lui	$t0,  0xFFFF		# Receiver Control memory location

rd_wait:
	# QTSpim throws a "CreateWaitable Timer failed" error that you can't
	# quit out of which gave me a panic attack. don't let it poll too long or that error occurs.
	# also end task wasn't working, CPU started to go pierce the heavens
	# polling section
	lw	$t1, 0($t0)		# load from receiver control register (ready bit)
	andi	$t1, $t1, 1 		# clear all bits except the LSB
	beq	$t1, $zero, rd_wait	# branch if ready bit not 1
	nop
	# loading input and handling
	# say they enter 123
	lw	$t2, 4($t0)		# load data from receiver data register (actual input)
					# $t2 = '1' -> '2' -> '3'
	nop
	addiu	$t2, $t2, -48		# subtract 48 to convert from ASCII characters to int 
					# $t2 = 1 -> 2 -> 3
	mul	$t2, $t2, $t3		# $t2 = 100 -> 20 -> 3
	div	$t3, $t3, 10		# adjusting place value by lowering the multiplier
					# 100 / 10 = 10 -> 10 / 10 = 1 -> 1 / 10 = 0
	addu	$t4, $t4, $t2		# add the output to a temporary register to print later
	bnez	$t3, rd_wait		# if the multplier is 0, then the number has been constructed
	nop

	la	$a0, pr2		# address of exit prompt
	syscall
	move	$a0, $t4		# move the output to the argument register to be printed
	li	$v0, 1			# print_int sys call code
	syscall

	li	$v0, 10			# exit sys call code
	syscall
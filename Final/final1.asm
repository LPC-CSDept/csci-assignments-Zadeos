#
# final1.asm
# Mason Lewis
# 
# Question #5 of Final Exam
# Program to take digits through MM I/O and display them
#

	.data
pr1:	.asciiz "please enter 3 numbers (e.g. 123): "

	.text
	.globl main
main:
	li	$v0, 4			# print_string sys call code
	la	$a0, pr1		# address of prompt
	syscall

	lui	$t0,  0xFFFF		# Receiver Control memory location
rd_wait:
	lw	$t1, 0($t0)		# load from receiver control register (ready bit)
	andi	$t1, $t1, 1 		# clear all bits except the LSB
	beq	$t1, $zero, rd_wait	# branch if ready bit not 1
	lw	$t2, 4($t0)		# load data from receiver data register (actual input)


	li	$v0, 10			# exit sys call code
	syscall
		
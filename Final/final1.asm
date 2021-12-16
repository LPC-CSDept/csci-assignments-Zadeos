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
	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt
	syscall

	li	$v0, 10		# exit sys call code
	syscall
		
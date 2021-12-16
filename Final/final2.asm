#
# final2.asm
# Mason Lewis
# 
# Question #6 of Final Exam
# Program to take characters from user and display in console
# until 'q' is typed.

	.data
pr1:	.asciiz "enter any characters, quit with 'q' "

	.text
	.globl main
main:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt
	syscall

	li	$v0, 10		# exit sys call code
	syscall
		
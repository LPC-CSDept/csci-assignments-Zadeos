#
# quiz2_part_1.asm
#
# Mason Lewis
# 11/29/2021
#
# Part 1 of Quiz 2
# Program to convert Fahrenheit to Celsius
#

	.data
pr1:	.asciiz	"This program will convert Fahrenheit to Celsius\n"
pr2:	.asciiz	"Fahrenheit: "
pr3:	.asciiz	"Celsius: "

	.text
	.globl	main
main:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt message
	syscall			# prints the prompt
	la	$a0, pr2	# address of prompt message
	syscall			# prints the prompt
	
	li	$v0, 5		# read_int sys call code
	syscall			# gets Fahrenheit from user
	
	mtc1	$v0, $f0	# copies Fahrenheit into $f0
	cvt.s.w	$f0, $f0	# convert the Fahrenheit (an int) into a float
	
				# celsius = (Fahrenheit-32.0) * 5.0 ⁄ 9.0
	li.s	$f1, 32.0
	li.s	$f2, 5.0
	li.s	$f3, 9.0
	
	sub.s	$f0, $f0, $f1	# $f0 = (Fahrenheit-32.0)
	mul.s	$f0, $f0, $f2	# $f0 = (Fahrenheit-32.0) * 5.0
	div.s	$f12, $f0, $f3	# $f12 = (Fahrenheit-32.0) * 5.0 / 9.0
	
	li	$v0, 4		# print_string sys call code
	la	$a0, pr3	# address of prompt message
	syscall			# prints the prompt
	
	li	$v0, 2		# print_float sys call code
	syscall			# prints the Celsius
	
	li	$v0, 10		# exit sys call code
	syscall
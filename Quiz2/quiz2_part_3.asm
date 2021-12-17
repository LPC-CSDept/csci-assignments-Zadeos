#
# quiz2_part_3.asm
#
# Mason Lewis
# 11/29/2021
#
# Part 3 of Quiz 2
# Program to approximate sqrt(n) using Newton's Method
#

	.data
pr1:	.asciiz	"This program approximates the sqrt(n) using Newton's Method\n"
pr2:	.asciiz "N: "
pr3:	.asciiz "sqrt(n) = "

	.text
	.globl main
main:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt message
	syscall			# prints the prompt
	la	$a0, pr2	# address of prompt message
	syscall			# prints the prompt
	
	li	$v0, 6		# read_float sys call code
	syscall			# gets N from the user
	
	li.s	$f1, 1.0	# initial guess
	li.s	$f2, 2.0	# divisor
	li.s	$f10, 1.0e-5	# accuracy limit
	
loop:
	div.s	$f3, $f0, $f1	# $f3 = (n / x)
	add.s	$f3, $f3, $f1	# $f3 = x + (n / x)
	div.s	$f3, $f3, $f2	# $f3 = (x + (n / x)) / 2 SEE IF YOU CAN JUST USE f3
	sub.s	$f1, $f3, $f1	# $f1 = x' - x
	abs.s	$f1, $f1	# $f1 = |x' - x|
	
	c.lt.s	$f1, $f10	# |x' - x| < 1.0e-5?
	bc1t	done		# true
	nop
	mov.s	$f1, $f3	# $f1 = x'
	j	loop
	nop
	
done:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr3	# address of prompt message
	syscall			# prints the prompt
	
	li	$v0, 2		# print_float sys call code
	mov.s	$f12, $f3	# copies approximate sqrt into $f12
	syscall			# prints the approximate sqrt
	
	li	$v0, 10		# exit sys call code
	syscall
	
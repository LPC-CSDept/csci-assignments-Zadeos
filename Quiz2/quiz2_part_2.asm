#
# quiz2_part_2.asm
#
# Mason Lewis
# 11/29/2021
#
# Part 2 of Quiz 2
# Program to calculate a Quadratic Equation
#
# Register use:
# $f1 --- A
# $f2 --- B
# $f3 --- C
# $f0 --- X

	.data
pr1:	.asciiz	"This program will calculate ax^2 + bx + c\n"
pr2:	.asciiz "A: "
pr3:	.asciiz "B: "
pr4:	.asciiz "C: "
pr5:	.asciiz "X: "
pr6:	.asciiz "Result: "

	.text
	.globl main
main:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt message
	syscall			# prints the prompt
	
				# A:
	la	$a0, pr2	# address of prompt message
	syscall			# prints the prompt
	li	$v0, 6		# read_float sys call code
	syscall			# gets X from the user
	mov.s	$f1, $f0	# copies A into $f1
				# B:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr3	# address of prompt message
	syscall			# prints the prompt
	li	$v0, 6		# read_float sys call code
	syscall			# gets B from the user
	mov.s	$f2, $f0	# copies B into $f2
				# C:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr4	# address of prompt message	
	syscall			# prints the prompt	
	li	$v0, 6		# read_float sys call code
	syscall			# gets X from the user
	mov.s	$f3, $f0	# copies C into $f3
				# X:
	li	$v0, 4		# print_string sys call code
	la	$a0, pr5	# address of prompt message
	syscall			# prints the prompt
	li	$v0, 6		# read_float sys call code
	syscall			# gets X from the user
	
	mul.s	$f1, $f1, $f0	# $f1 = a * x
	mul.s	$f1, $f1, $f0	# $f1 = ax * x
	mul.s	$f2, $f2, $f0	# $f2 = b * x
	add.s	$f1, $f1, $f2	# $f2 = ax^2 + bx
	add.s	$f12, $f1, $f3	# $f12 = ax^2 + bx + c
	
	li	$v0, 4		# print_string sys call code
	la	$a0, pr6	# address of prompt message
	syscall			# prints the prompt
	
	li	$v0, 2		# print_float sys call code
	syscall			# prints the resulting float
	
	li	$v0, 10		# exit sys call code
	syscall
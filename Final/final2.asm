#
# final2.asm
# Mason Lewis
# 
# Question #6 of Final Exam
# Program to take characters from user and display in console
# until 'q' is typed.

	.data

pr1:	.asciiz "enter any characters, quit with 'q'\n"

	.kdata

thing1:	.word 10	# to be used in ktext
thing2:	.word 11	# to be used in ktext

	.text
	.globl main

main:

	li	$v0, 4		# print_string sys call code
	la	$a0, pr1	# address of prompt
	syscall
	mfc0	$a0, $t4	# read from the status register
	li	$a0, 0xFF11	# enables all interrupts
	mtc0	$a0, $t4	# writes back to the status register

	lui	$t0, 0xFFFF	# Receiver Control memory location
	li	$a0, 2		# enable keyboard interrupt
	sw	$a0, 0($t0)	# write back to the receiver data register

	li	$v0, 10		# exit sys call code
	syscall

await:

	j await			# waiting for input weeeeeee

	.ktext 0x80000180

sw	$v0, thing1		# to be used in ktext
sw	$a0, thing2		# to be used in ktext

print:
	li	$v0, 11		# print_char sys call code
	syscall

done:
	lw	$v0, thing1	# restore $v0
	lw	$a0, thing2	# restore $a0
	mtc0	$zero, $t5	# clearing cause register
	mfc0	$k0, $t4	# setting status register
	li	$k0, 0x11	# enable interrupts
	eret			# return to exception program counter
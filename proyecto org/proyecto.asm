.data
ARRAY_TOTAL: .space 2000 # separo array para 500 numeros aleatorios
ARRAY_EVEN: .space 2000 # array para numeros pares
ARRAY_ODD: .space 2000 # array para numeros impares
fnf:	.ascii  "The file was not found: "
file:	.asciiz	"C:\\Users\\Kevin\\workspace\\Org\\proyecto org\\numeros.txt"
cont:	.ascii  "File contents: "
buffer: .space 3000
aux:     .space 32
DisplaySorted:	.asciiz "Contents of the sorted array: "
 Space: 		.asciiz " "
	.text
 
# Open File
open:
	li	$v0, 13		# Open File Syscall
	la	$a0, file	# Load File Name
	li	$a1, 0		# Read-only Flag
	li	$a2, 0		# (ignored)
	syscall
	move	$s6, $v0	# Save File Descriptor
	blt	$v0, 0, err	# Goto Error
 
# Read Data
read:
	li	$v0, 14		# Read File Syscall
	move	$a0, $s6	# Load File Descriptor
	la	$a1, buffer	# Load Buffer Address
	li	$a2, 3000	# Buffer Size
	syscall
 
# Print Data
print:
	li	$v0, 4		# Print String Syscall
	la	$a0, cont	# Load Contents String
	syscall
 
# Close File
close:
	li	$v0, 16		# Close File Syscall
	move	$a0, $s6	# Load File Descriptor
	syscall
	j	done		# Goto End
 
# Error
err:
	li	$v0, 4		# Print String Syscall
	la	$a0, fnf	# Load Error String
	syscall

# Done
done:
	li	$v0, 10		# Exit Syscall
	syscall
	
###############  FUNCION PARA CONCATENAR LOS DIGITOS DEL NUMERO ALEATORIO LEIDO DEL ARCHIVO  #############
UnirDigitos:	
	la $t0, aux
	add $t1, $zero, $zero
	slti $t2, $t9, 2
	bne $t2, $zero, UnDigito
	slti $t2, $t9, 3
	bne $t2, $zero, DosDigitos
	slti $t2, $t9, 4
	bne $t2, $zero, TresDigitos
	slti $t2, $t9, 5
	bne $t2, $zero, CuatroDigitos
CincoDigitos:
	#primer digito
	lw $t4, 0($t0)
	li $t2, 10000
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#segundo digito
	lw $t4, 4($t0)
	li $t2, 1000
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#tercer digito
	lw $t4, 8($t0)
	li $t2, 100
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#cuarto digito
	lw $t4, 12($t0)
	li $t2, 10
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#quitno digito
	lw $t4, 16($t0)
	add $t1, $t1, $t4
	j Finish
CuatroDigitos:
	#primer digito
	lw $t4, 0($t0)
	li $t2, 1000
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#segundo digito
	lw $t4, 4($t0)
	li $t2, 100
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#tercer digito
	lw $t4, 8($t0)
	li $t2, 10
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#cuarto digito
	lw $t4, 12($t0)
	add $t1, $t1, $t4
	j Finish
UnDigito:
	lw $t4, 0($t0)
	add $t1, $t1, $t4
	j Finish
DosDigitos:
	#primer digito
	lw $t4, 0($t0)
	li $t2, 10
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#aegundo digito
	lw $t4, 4($t0)
	add $t1, $t1, $t4
	j Finish
TresDigitos:
	#primer digito
	lw $t4, 0($t0)
	li $t2, 100
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#segundo digito
	lw $t4, 4($t0)
	li $t2, 10
	mult $t4, $t2
	mflo $t4
	mfhi $t2
	add $t1, $t1, $t4
	#tercer digito
	lw $t4, 8($t0)
	add $t1, $t1, $t4
Finish:
	add $v0, $zero, $t1
	jr $ra	
#####################  FUNCION DE BUBBLE SORT  #######################
BubbleSort:
		addi	$t0, $zero, 0		#initiate counter
		addi	$t1, $zero, 0		#initiate register
		addi	$t2, $zero, 0		#initiate register
		addi	$t4, $zero, 0		#initiate register
		addi	$t5, $zero, 0		#initiate register
		addi	$t6, $zero, 0		#initiate register
		addi	$t7, $zero, 0		#initiate register
		addi	$s2, $zero, 0		#set/reset swap flag
		sll	$t1, $t0, 2		#$t0 * 4 as offset
		add	$t1, $t1, $s0		#load the array into $t1
		addi	$t2, $t1, 4		#load it to use to compare
	SLoop:
		addi	$t0, $t0, 1		#increment counter
		beq	$t0, $s1, ExitLoop	#check if it ever branched to swap and exit
		lw	$t6, 0($t1)		#put $t1 into $t6
		lw	$t7, 0($t2)		#put $t2 into $t7
		bgt	$t6, $t7, Swap		#send the intgers to swap if $t1 < $t2
		sll	$t1, $t0, 2		#$t0 * 4 as offset
		add	$t1, $t1, $s0		#load the array into $t1
		addi	$t2, $t1, 4		#add 4 and load the array into $t2
		j	SLoop			#start loop over again
	Swap:
		lw	$t4, 0($t1)		#load $t6 into $t4
		lw	$t5, 0($t2)		#load $t7 into $t5
		sw	$t5, 0($t1)		#swap $t4 into $t7
		sw	$t4, 0($t2)		#swap $t5 into $t6
		addi	$s2, $s2, 1		#add 1 to $s2 to check if the program ever came here	
		j	SLoop			#jump back to the SLoop 
	ExitLoop:
		bgtz	$s2, BubbleSort		#start sort over again if the flag $s2 is set
		jr $ra
###########################################################################################		
	
PrintSorted:
		la	$a0, DisplaySorted	#the title to display the initial array
		li	$v0, 4			#the value to print a string
		syscall				#call the function
		addi	$t0, $zero, 0		#initiate counter
		sll	$t1, $t0, 2		#$t0 * 4 as offset
		add	$t1, $t1, $s0		#load the array into $t1
	PLoop2:
		lw	$a0, 0($t1)		#load the integer to print in $a0
		li	$v0, 1			#command to print an integer
		syscall				#call the command to print the integer
		la	$a0, Space		#print a space between numbers
		li	$v0, 4			#load 4 into $v0 to print a string
		syscall				#call the command
		addi	$t0, $t0, 1		#increment counter
		sll	$t1, $t0, 2		#$t0 * 4 to offset
		add	$t1, $t1, $s0		#load next element in the array
		bne	$t0, $s1, PLoop2	#keep looping until $t0 == $s1
		jr $ra

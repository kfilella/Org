.data
ARRAY_TOTAL: .space 2000 # separo array para 500 numeros aleatorios
ARRAY_EVEN: .space 2000 # array para numeros pares
ARRAY_ODD: .space 2000 # array para numeros impares
fnf:	.ascii  "The file was not found: "
file:	.asciiz	"C:\\Users\\Kevin\\Desktop\\proyecto org\\numeros.txt"
cont:	.ascii  "File contents: "
buffer: .space 1024
 
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
	li	$a2, 1024	# Buffer Size
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
	
########## FUNCION STRING TO INTEGER ################
#  int atoi ( const char *str );
#
#  Parse the cstring str into an integral value
#
atoi:
    or      $v0, $zero, $zero   # num = 0
    or      $t1, $zero, $zero   # isNegative = false
    lb      $t0, 0($a0)
    bne     $t0, '+', .isp      # consume a positive symbol
    addi    $a0, $a0, 1
.isp:
    lb      $t0, 0($a0)
    bne     $t0, '-', .num
    addi    $t1, $zero, 1       # isNegative = true
    addi    $a0, $a0, 1
.num:
    lb      $t0, 0($a0)
    slti    $t2, $t0, 58        # *str <= '9'
    slti    $t3, $t0, '0'       # *str < '0'
    beq     $t2, $zero, .done
    bne     $t3, $zero, .done
    sll     $t2, $v0, 1
    sll     $v0, $v0, 3
    add     $v0, $v0, $t2       # num *= 10, using: num = (num << 3) + (num << 1)
    addi    $t0, $t0, -48
    add     $v0, $v0, $t0       # num += (*str - '0')
    addi    $a0, $a0, 1         # ++num
    j   .num
.done:
    beq     $t1, $zero, .out    # if (isNegative) num = -num
    sub     $v0, $zero, $v0
.out:
    jr      $ra         # return
 
# Done
done:
	li	$v0, 10		# Exit Syscall
	syscall
	
	

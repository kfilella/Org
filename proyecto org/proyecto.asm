
.data
array_total: .word 500
aux:     .space 16
grupo1:	 .space 40
grupo2:	 .space 80
grupo3:	 .space 200
grupo4:	 .space 400
grupo5:	 .space 600
grupo6:	 .space 800
grupo7:	 .space 1000
grupo8:	 .space 1200
grupo9:	 .space 1400
grupo10: .space 1600
bufferin:.space 9160
grupos:	.word 10, 20, 50, 100, 150, 200, 250, 300, 350, 400
tiempos:.space 40
myOpcion: .word 10
file1:   .asciiz "C:\\Users\\Kevin\\workspace\\Org\\proyecto org\\numeros.txt"      # nombre del archivo de numeros aleatorios
file2:   .asciiz "bur_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por burbuja
file3:   .asciiz "ins_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por inserción
file4:   .asciiz "qui_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por quicksort
file5:   .asciiz "bur_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por burbuja
file6:   .asciiz "ins_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por inserción
file7:   .asciiz "qui_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por quicksort
espacio2: .asciiz "  "
NewLine: .asciiz "\n"
NewLineFile: .space 2
Input: 		.asciiz "Please enter a value for the array: \n"
DisplayInitial:	.asciiz "Contents of the array: "
DisplaySorted:	.asciiz "Contents of the sorted array: "
Space: 		.asciiz " "
coma:	.asciiz ","
corcheteIzq:	.asciiz "["
corcheteDer:	.asciiz "]"
pipe:	.asciiz "|"
buffer: .space 6		      #creo el buffer donde guardare el string a escribir en el archivo 
## LABEL DE LOS MENUS
Menu1: .asciiz "** Organizacion de Computadores *** \n"
Menu1.1: .asciiz "	1. ejecutar	\n"
Menu1.2: .asciiz "	2. Algoritmos de Ordamiento \n"
Menu1.3: .asciiz "	3. Salir	\n"
Menu: .asciiz "***********************************\n"
Menu2.0: .asciiz "***  Algoritmos de Ordanamiento ***\n"
Menu2.1: .asciiz " 	1. ejecutar2		    \n"
Menu2.2: .asciiz " 	2. Inserción  		    \n"
Menu2.3: .asciiz " 	3. Quicksort  		    \n"
Menu2.4: .asciiz " 	4. Atras      		    \n"
Op: .asciiz "Se Genero el archivo de numeros aleatorios \n"
OpcionBb: .asciiz "Ordenamiento por BubbleSort Completado, Se han generado los archivos bur_aleatorios.txt y bur_tiempos.txt\n"
OpcionIn: .asciiz "Ordenamiento por Inserción Completado, Se han generado los archivos ins_aleatorios.txt y ins_tiempos.txt\n"
OpcionQk: .asciiz "Ordenamiento por QuickSort Completado, Se han generado los archivos qui_aleatorios.txt y qui_tiempos.txt\n"
space: .asciiz " "
.text

 
 ################################
 ### 	MENU PRINCIPAL 
 ################################
 menuPrincipal:
 loopAtras:
 
 la $a0, NewLine
 li $v0,4
 syscall  
 
 la $a0, Menu
 li $v0,4
 syscall
 
 la $a0, Menu1
 li $v0,4
 syscall
 
 la $a0, Menu
 li $v0,4
 syscall
 
 la $a0, Menu1.1
 li $v0,4
 syscall
 
 
 loopInicio1:
  #cargado de numeros 1,2,3,4
 li $t1, 0x00000031   
 li $t2, 0x00000032
 li $t3, 0x00000033
 li $t4, 0x00000034
 ## capturamos el valor ingresado 
 la $a0, myOpcion 	#cargando opcion 1
 li $a1, 2  		#permitiendo tipiear un digito
 li $v0, 8	  	# opcion syscall para escribir
 syscall
 lw $s1, 0($a0)   	#busco el valor digitado
 ##
 
 ## bloques de control
 
  beq $s1,$t3, loopFin	#pregunto por condicion de salida
  
  slt $t6, $s1,$t3   		#condicion de ciclo
  la $a0, NewLine
  li $v0,4
  syscall
   
  beq $t6,$zero, loopInicio1	#condicion de numero equivocado 
  
  beq $s1,$t1, loopImprimir1	# pregunto por condicion = Generacion de Randoms
  beq $s1,$t2, menuInterno	# pregunto por condicion = Algoritmos 
 
 ###########################  OPCION GENERAR RANDOMS  #############################
 loopRandoms:
 ##Codigo para generar los randoms y guardarlos en archivo 
 la $a0,Op
 li $v0,4
 syscall
 j menuPrincipal
 
 ################################
 ### 	MENU SECUNDARIO
 ################################
 
 menuInterno:
 la $a0 , Menu
 li $v0 , 4
 syscall
 
 la $a0 , Menu2.0
 li $v0 , 4
 syscall
 
 la $a0 , Menu
 li $v0 , 4
 syscall
 
 la $a0 , Menu2.1
 li $v0 , 4
 syscall
 
 loopInicio2:
  #cargado de numeros 1,2,3,4
 li $t1, 0x00000031   
 li $t2, 0x00000032
 li $t3, 0x00000033
 li $t4, 0x00000034
 
 la $a0, myOpcion 	#cargando opcion 1
 li $a1, 2  		#permitiendo tipiear un digito
 li $v0, 8	 	# opcion syscall para escribir
 syscall
 lw $s1, 0($a0)   	#busco el valor digitado

## bloque de controls
 beq $s1,$t4, loopAtras		# pregunto por condicion = opcion 4
 
 slt $t5, $s1,$t4   		#condicion de ciclo
 la $a0, NewLine
 li $v0,4
 syscall
   
 beq $t5,$zero, loopInicio2	#condicion de numero equivocado 
 
 beq $s1,$t1, loopImprimir1	# pregunto por condicion = Bubblesort

###################  OPCION BUBBLE SORT  ##################			 			 						 			 			
 loopImprimir1:			#imprimo mi eleccion
 
 	jal ReadFile
	jal LlenarArreglos
	
	la $t5, tiempos
	li $s3, 0
	
 ####################
 la $a0, OpcionBb
 li $v0, 4
 syscall
 j menuInterno
 
 

 #cierra el programa
 loopFin:																																					
 li $v0, 10
 syscall
 

########  FUNCION PARA LLENAR LOS 10 ARREGLOS CORRESPONDIENTES A LOS 10 GRUPOS DE ALEATORIOS  ###########
LlenarArreglos:
	la $s7, array_total
	la $s0, bufferin	#indico la direccion base del string leido del archivo
	li $t8, -1	#inicializo el registro $t8, que controlara que caracter leido sera el que estemos usando
	li $s2, 0	#j=0
ForArreglos:				#INICIO FOR
	li $t0, 0			
	beq $s2, $t0, Grupo01
	li $t0, 1
	beq $s2, $t0, Grupo02
	li $t0, 2
	beq $s2, $t0, Grupo03
	li $t0, 3
	beq $s2, $t0, Grupo04
	li $t0, 4
	beq $s2, $t0, Grupo05
	li $t0, 5
	beq $s2, $t0, Grupo06
	li $t0, 6
	beq $s2, $t0, Grupo07
	li $t0, 7
	beq $s2, $t0, Grupo08
	li $t0, 8
	beq $s2, $t0, Grupo09
Grupo10:
	li $t6, 400			#Se guarda en $t6 el numero que controlara el while 1
	la $s5, grupo10			#Se guarda en $s5 la direccion base del arreglo correspondiente al grupo
	j ContinueArreglos
Grupo01:
	li $t6, 10
	la $s5, grupo1
	j ContinueArreglos
Grupo02:
	li $t6, 20
	la $s5, grupo2
	j ContinueArreglos
Grupo03:
	li $t6, 50
	la $s5, grupo3
	j ContinueArreglos
Grupo04:
	li $t6, 100
	la $s5, grupo4
	j ContinueArreglos
Grupo05:
	li $t6, 150
	la $s5, grupo5
	j ContinueArreglos
Grupo06:
	li $t6, 200
	la $s5, grupo6
	j ContinueArreglos
Grupo07:
	li $t6, 250
	la $s5, grupo7
	j ContinueArreglos
Grupo08:
	li $t6, 300
	la $s5, grupo8
	j ContinueArreglos
Grupo09:
	li $t6, 350
	la $s5, grupo9
ContinueArreglos:
	li $s1, 0	#i=0
While1:				#INICIO PRIMER WHILE
	slt $t1, $s1, $t6	#if($s1<$t6) $t1=1; else $t1=0;
	beq $t1, $zero, FinWhile1	#if($s1<$t6) sigue en el for; else sale del for
	#tomo el siguiente caracter del archivo
	addi $t8, $t8, 1
	add $t1, $s0, $t8	#preparo la direccion del siguiente indice del arreglo de caracteres
	lb $t3, 0($t1)		#guardo en $t3 el caracter sacado del arreglo
	
	#if($t3<58 && $t3>48)
	slti $t0, $t3, 58	#Si $t3<58 -->  $t0=1 else $t0=0
	slti $t1, $t3, 48	#Si $t3<48 -->  $t1=1 else $t1=0
	xor $t7, $t0, $t1
	
	#if $t7 == 1 ---> ES UN DIGITO
	beq $t7, $zero, While1	#Si $t7 no es 1, entonces no entra al if y vamos a la siguiente iteracion del while
	la $s3, aux
	li $t9,0 #inicia contador de digitos con 0
While2:				#INICIO SEGUNDO WHILE
	slti $t0, $t3, 58	#Si $t3<58 -->  $t0=1 else $t0=0
	slti $t1, $t3, 48	#Si $t3<48 -->  $t1=1 else $t1=0
	xor $t7, $t0, $t1
	beq $t7, $zero, FinWhile2	#Si $t7 no es 1, entonces no entra al while y continua
	sll $t7, $t9, 2
	add $t7, $t7, $s3
	add $t3, $t3, -48	#convierto el caracter en digito
	sw $t3, 0($t7)		#guardo el digito en el arreglo aux
	#tomo el siguiente caracter del archivo
	addi $t8, $t8, 1
	add $t7, $s0, $t8	#preparo la direccion del siguiente indice del arreglo de caracteres
	lb $t3, 0($t7)		#guardo en $t3 el caracter sacado del arreglo
	addi $t9, $t9, 1
	j While2	
FinWhile2:			#FIN SEGUNDO WHILE
	addi $sp, $sp, -4
	sw $ra, 0($sp) 		#guardo la direccion de retorno enla pila
	jal UnirDigitos	
	lw $ra, 0($sp)		#cargo la direciion de retorno de la pila
	addi $sp, $sp, 4
	
	add $s4, $zero, $v0	#guardo en $s4 el int ya convertido
	
	sll $t7, $s1, 2
	add $t7, $t7, $s5
	sw $s4, 0($t7)		#preparo la direccion del indice del arreglo del grupo correspondiente
	
	addi $s1, $s1, 1	#i++		
	j While1
FinWhile1:			#FIN PRIMER WHILE
	addi $s2, $s2, 1	#j++		
	slti $t7, $s2, 10	#if($s2<10) $t7=1; else $t7=0;
	bne $t7, $zero, ForArreglos	#FIN FOR
	jr $ra   		#termino la funcion llenar arreglos

###########################  FUNCION PARA LEERE EL ARCHIVO  ######################################    	
ReadFile:
	#abro el archivo
	li $v0, 13
	la $a0, file1
	li $a1, 0
	li $a2, 0
	syscall
	add $s6, $v0, $zero
	
	#leo del archivo
	li $v0, 14
	add $a0, $s6, $zero
	la $a1, bufferin
	li $a2, 9160
	syscall
	#add $t1, $v0, $zero
	
	#Cierro el archivo 
  	li   $v0, 16       #llamada al sistema para cerrar archivo
  	add $a0, $s6, $zero      #especifico el file descriptor
  	syscall            #cierro el archivo  
  	jr $ra		#termino mi funcion
  	
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
	sw $v0, 0($s7)
	
	### IMPRIMO CADA ELEMENTO GUARDADO EN EL ARREGLO ###
	lw $t0, 0($s7) 
	li $v0, 1 # load system call (print integer) into syscall register 
	move $a0, $t0 # load argument for syscall 
	syscall # print element 
	
	# print space, 32 is ASCII code for space
	li $a0, 32
	li $v0, 11  # syscall number for printing character
	syscall
	
	addi $s7,$s7,4
	jr $ra
	
##### PRINT ARREGLO ######
#####################  FUNCION DE BUBBLE SORT  #######################

########################
partition:
# $a0 contains address of array to sort
# $a1 contains low (starting index of array to sort)
# $a2 contains high (ending index of array to sort)
# $s0 contains address of array to sort
# $s1 contains low (starting index of array to sort)
# $s2 contains left
# $s3 contains right
# $s4 contains pivot

# $t0 contains temporary
# $t1 contains temporary
# $t2 contains temporary
# $t4 contains constant 4
addi	$sp, $sp, -24		# make room on stack for 6 registers
sw	$s0, 4($sp)		# save $s0 on stack
sw	$s1, 8($sp)		# save $s1 on stack
sw	$s2, 12($sp)		# save $s2 on stack
sw	$s3, 16($sp)		# save $s3 on stack
sw	$s4, 20($sp)		# save $s4 on stack
sw	$ra, 24($sp)		# save $ra on stack

move	$s0, $a0		# copy param. $a0 into $s0 (addr array)
move 	$s1, $a1		# copy param. $a1 into $s1 (low)

# initialize left, right, and pivot
move 	$s2, $s1
move 	$s3, $a2

li	$t4, 4
mul	$t0, $s1, $t4
add	$t0, $t0, $s0
lw	$s4, 0($t0)

whileQS:
	blt	$s2, $s3, whileBody
	j	endWhile
whileBody:

	while_2:
		li	$t4, 4
		mul	$t0, $s3, $t4
		add	$t0, $t0, $s0
		lw	$t1, 0($t0)
		bgt	$t1, $s4, whileBody_2
		j	endWhile_2
	whileBody_2:
		addi	$s3, $s3, -1
		
		j	while_2
	endWhile_2:


	while_3:
		blt	$s2, $s3, andTest
		j	endWhile_3
	andTest:
		li	$t4, 4
		mul	$t1, $s2, $t4
		add	$t1, $t1, $s0
		lw	$t2, 0($t1)
		ble	$t2, $s4, whileBody_3
		j	endWhile_3
	whileBody_3:
		addi	$s2, $s2, 1
		
		j	while_3
	endWhile_3:

	if_2:
		blt	$s2, $s3, then_2
		j	endIf_2
	then_2:

		move	$a0, $t1
		move 	$a1, $t0
		jal	swap
	endIf_2:

	j	whileQS
endWhile:

li	$t4, 4
mul	$t0, $s3, $t4
add	$t0, $t0, $s0
lw	$t1, 0($t0)

mul	$t2, $s1, $t4
add	$t2, $t2, $s0
sw	$t1, 0($t2)

sw	$s4, 0($t0)

move 	$v0, $s3		# return right

lw	$s0, 4($sp)		# restore $s0 from the stack
lw	$s1, 8($sp)		# restore $s1 from the stack
lw	$s2, 12($sp)		# restore $s2 from the stack
lw	$s3, 16($sp)		# restore $s3 from the stack
lw	$s4, 20($sp)		# restore $s4 from the stack
lw	$ra, 24($sp)		# restore $ra from the stack
addi	$sp, $sp, 24		# restore stack pointer

jr	$ra

##################
swap:
# $a0 contains address of operand1
# $a1 contains address of operand2
# $t0 contains temp
# $t1 contains value of operand2

# Since no subprograms are called, NO registers need to be saved and restored.

lw	$t0, 0($a0)
lw	$t1, 0($a1)

sw	$t1, 0($a0)
sw	$t0, 0($a1)

jr	$ra

######################################################################################
#                           CONVERTIR INT A STRING                                   # 
######################################################################################
# int ItoA(int, char*)
# arguments:
#    $a0 - integer to convert
#    $a1 - character buffer to write to
# return:  number of characters in converted string
#
ItoA:
  	bnez $a0, ItoA.non_zero  # first, handle the special case of a value of zero
  	nop
  	add $t0, $zero, $zero
  	li   $t0, '0'
  	sb   $t0, 0($a1)
  	sb   $zero, 1($a1)
  	li   $v0, 1
  	jr   $ra
ItoA.non_zero:
	add $t0, $zero, $zero
  	addi $t0, $zero, 10     # now check for a negative value
  	li $v0, 0    
  	bgtz $a0, ItoA.recurse
  	nop
  	add $t1, $zero, $zero
  	li   $t1, '-'
  	sb   $t1, 0($a1)
  	addi $v0, $v0, 1
  	neg  $a0, $a0
ItoA.recurse:
  	addi $sp, $sp, -24
  	sw   $fp, 8($sp)
  	addi $fp, $sp, 8
  	sw   $a0, 4($fp)
  	sw   $a1, 8($fp)
  	sw   $ra, -4($fp)
  	sw   $s0, -8($fp)
  	sw   $s1, -12($fp)
   
  	div  $a0, $t0       # $a0/10
  	mflo $s0            # $s0 = quotient
  	mfhi $s1            # s1 = remainder  
  	beqz $s0, ItoA.write
ItoA.continue:
  	move $a0, $s0  
  	jal ItoA.recurse
  	nop
ItoA.write:
	add $t1, $zero, $zero
  	add  $t1, $a1, $v0
  	addi $v0, $v0, 1    
  	add $t2, $zero, $zero
  	addi $t2, $s1, 0x30 # convert to ASCII
  	sb   $t2, 0($t1)    # store in the buffer
  	sb   $zero, 1($t1)
  
ItoA.exit:
  	lw   $a1, 8($fp)
  	lw   $a0, 4($fp)
  	lw   $ra, -4($fp)
  	lw   $s0, -8($fp)
  	lw   $s1, -12($fp)
  	lw   $fp, 8($sp)    
  	addi $sp, $sp, 24
  	jr $ra
  	nop
#############################################################################



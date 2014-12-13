.data
array_total: .word 500
aux:     .space 32
grupo1:	 .space 2000
bufferin:.space 4096
grupos:	.word 500
tiempos:.space 40
myOpcion: .word 10
file1:   .asciiz "numeros.txt"      # nombre del archivo de numeros aleatorios
file2:   .asciiz "ordenado.txt"      # nombre del archivo de numeros aleatorios ordenados por burbuja
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
	
	li $t0, 0			
	beq $s3, $t0, Ordenar1
	
	Ordenar1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	li $s1, 500
	j Continue2
		
	Continue2:	
	add $t0, $zero, $v0		
	addi $sp, $sp, -8
	sw $t5, 4($sp)
	sw $t0, 0($sp)	
	
	jal BubbleSort
	jal PrintSorted
	jal loopFin
	
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
Grupo01:
	li $t6, 500
	la $s5, grupo1
	j ContinueArreglos
ContinueArreglos:
	li $s1, 0	#i=0
While1:				#INICIO PRIMER WHILE
	slt $t1, $s1, $t6	#if($s1<$t6) $t1=1; else $t1=0;
	beq $t1, $zero, FinWhile1	#if($s1<$t6) sigue en el for; else sale del for
	#tomo el siguiente caracter del archivo
	addi $t8, $t8, 1
	add $t1, $s0, $t8	#preparo la direccion del siguiente indice del arreglo de caracteres
	lb $t3, 0($t1)		#guardo en $t3 el caracter sacado del arreglo
	beq $t3, $zero, FinWhile1
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
	#quinto digito
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

######################################################################
#####################  FUNCION DE BUBBLE SORT  #######################
######################################################################

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

#################################################################################################
###################  FUNCION PARA ESCRIBIR LOS NUMEROS ORDENADOS EN EL ARCHIVO  #################
################################################################################################# 

WriteInFileSorted:
  	#Abro el archivo ordenado.txt
  	li   $v0, 13       #llamada al sistema para abrir archivos  	
  	li $t0, 1
	beq $s3, $t0, Archivo2
	
Archivo2:
	la   $a0, file2     #especifico el nombre del archivo
	j FinArchivos
	
FinArchivos:	
  	li   $a1, 1        #especifico que abro el archivo para escritura
  	li   $a2, 0        
  	syscall            #abro el archivo y el file descriptor se guarda en $v0
  	add $s6, $v0, $zero      #guardo el file descriptor en $s6   	
  	la $s3, grupos	#guardo en $s3 la direccion base del arreglo
  	li $s2, 0	#j=0
  	
ForG3:
	li $t0, 0			
	beq $s2, $t0, Write1


Write1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	j Continue4

Continue4:

	li   $v0, 15       	#llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero     #especifico el file descriptor 
  	la $a1, corcheteIzq     #especifico la direccion del string que queremos escribir
  	li $a2, 1 
  	syscall			#escribo el corchete inicial  
  	
  	sll $t5, $s2, 2		#multiplico el indice del arreglo por cuatro para obtener el offset=$t5
  	add $t5, $t5, $s3	#sumo el offset a la direccion base del arreglo y obtengo la direccion del indice 
  				#del arreglo=$t5   	
  	lw $t6, 0($t5)		#guardo en $t6 el valor del indice del arreglo
  	   	   	
  	li $s4, 0	#i=0
  	add $t4, $t6, -1	#temporal para verificar si ya se escribio el ultimo numero 
For3:
	#Saco el numero del arreglo  	
	sll $t0, $s4, 2
	add $t0, $t0, $s0
	
	add $t2, $zero, $zero
	lw $t2, 0($t0)	 		
	
	#Convierto el numero del arreglo a String
	move $a0, $t2	#envio el numero aleatorio como parametro para convertirlo en string
	la $a1, buffer	#envio como parametro el buffer donde almacenare el entero convertido a string
	addi $sp, $sp, -4
	sw $ra, 0($sp) 	#guardo la direccion de retorno en la pila
	jal ItoA	#llamo a la funcion para convetir a string
	add $t0, $v0, $zero	#guardo en $t0 el numero de digitos del aleatorio
	lw $ra, 0($sp)	#cargo la direccion de retorno de la pila
	addi $sp, $sp, 4
  	#Escribo en el archivo bur_aleatorios.txt
  	li   $v0, 15       #llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero      #especifico el file descriptor 
  	la $a1, buffer     #especifico la direccion del string que queremos escribir
  	add $a2, $zero, $t0
  	#li $a2, 6 
  	syscall            #escribo en el archivo  
  	li   $v0, 15       #llamada al sistema para escritura en archivos
  	beq $s4, $t4, Corchete3 
	la $a1, coma     #especifico la direccion del string que queremos escribir
	j Continue3
Corchete3:
	la $a1, corcheteDer     #especifico la direccion del string que queremos escribir
Continue3:
	li $a2, 1
	syscall            #escribo en el archivo  	
	addi $s4, $s4, 1	#i++		
	slt $t1, $s4, $t6	#if($s4<$t6) $t1=1; else $t1=0;
	bne $t1, $zero, For3	#if($s4<$t6) sigue en el for; else sale del for
	
	addi $s2, $s2, 1	#j++		
	slti $t7, $s2, 10	#if($s2<10) $t1=1; else $t1=0;
	bne $t7, $zero, ForG3	#fin del for grande
		
  	#Cierro el archivo 
  	li   $v0, 16       #llamada al sistema para cerrar archivo
  	add $a0, $s6, $zero      #especifico el file descriptor
  	syscall            #cierro el archivo  
  	jr $ra		#termino mi funcion

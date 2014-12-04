# ******************************************
# Archivo: time.mips
# Elaborado por: 
#	Jose Romero
#	Victor Rodriguez
#	Fausto Mora
# ******************************************
.data
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
file1:   .asciiz "aleatorios.txt"      # nombre del archivo de numeros aleatorios
file2:   .asciiz "bur_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por burbuja
file3:   .asciiz "ins_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por inserción
file4:   .asciiz "qui_aleatorios.txt"      # nombre del archivo de numeros aleatorios ordenados por quicksort
file5:   .asciiz "bur_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por burbuja
file6:   .asciiz "ins_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por inserción
file7:   .asciiz "qui_tiempos.txt"      # nombre del archivo de los tiempos que se tomo en ordenar los grupos por quicksort
espacio2:.asciiz "  "
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
Menu1.1: .asciiz "	1. Generar Randoms	\n"
Menu1.2: .asciiz "	2. Algoritmos de Ordamiento \n"
Menu1.3: .asciiz "	3. Salir	\n"
Menu: .asciiz "***********************************\n"
Menu2.0: .asciiz "***  Algoritmos de Ordanamiento ***\n"
Menu2.1: .asciiz " 	1. BubbleSort 		    \n"
Menu2.2: .asciiz " 	2. Inserción  		    \n"
Menu2.3: .asciiz " 	3. Quicksort  		    \n"
Menu2.4: .asciiz " 	4. Atras      		    \n"
Op: .asciiz "Se Genero el archivo de numeros aleatorios \n"
OpcionBb: .asciiz "Ordenamiento por BubbleSort Completado, Se han generado los archivos bur_aleatorios.txt y bur_tiempos.txt\n"
OpcionIn: .asciiz "Ordenamiento por Inserción Completado, Se han generado los archivos ins_aleatorios.txt y ins_tiempos.txt\n"
OpcionQk: .asciiz "Ordenamiento por QuickSort Completado, Se han generado los archivos qui_aleatorios.txt y qui_tiempos.txt\n"

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
 
 la $a0, Menu1.2
 li $v0,4
 syscall
 
 la $a0, Menu1.3
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
  
  beq $s1,$t1, loopRandoms	# pregunto por condicion = Generacion de Randoms
  beq $s1,$t2, menuInterno	# pregunto por condicion = Algoritmos 
 
 ###########################  OPCION GENERAR RANDOMS  #############################
 loopRandoms:
 ##Codigo para generar los randoms y guardarlos en archivo 
 jal GenerarArchivoAleatorios		#llamo a mi funcion escribir en un archivo
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
 
 la $a0 , Menu2.2
 li $v0 , 4
 syscall
 
 la $a0 , Menu2.3
 li $v0 , 4
 syscall
 
 la $a0 , Menu2.4
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
 beq $s1,$t2, loopImprimir2	# pregunto por condicion = Insertsort 
 beq $s1,$t3, loopImprimir3     # pregunto por condicion = Quicksort 

###################  OPCION BUBBLE SORT  ##################			 			 						 			 			
 loopImprimir1:			#imprimo mi eleccion
 
 	jal ReadFile
	jal LlenarArreglos
	
	la $t5, tiempos
	li $s3, 0
For2:
	li $t0, 0			
	beq $s3, $t0, Ordenar1
	li $t0, 1
	beq $s3, $t0, Ordenar2
	li $t0, 2
	beq $s3, $t0, Ordenar3
	li $t0, 3
	beq $s3, $t0, Ordenar4
	li $t0, 4
	beq $s3, $t0, Ordenar5
	li $t0, 5
	beq $s3, $t0, Ordenar6
	li $t0, 6
	beq $s3, $t0, Ordenar7
	li $t0, 7
	beq $s3, $t0, Ordenar8
	li $t0, 8
	beq $s3, $t0, Ordenar9
Ordenar10:
	la $s0, grupo10		#cargo el arreglo correspondiente en $s0
	li $s1, 400
	j Continue2
Ordenar1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	li $s1, 10
	j Continue2
Ordenar2:
	la $s0, grupo2		#cargo el arreglo correspondiente en $s0
	li $s1, 20
	j Continue2
Ordenar3:
	la $s0, grupo3		#cargo el arreglo correspondiente en $s0
	li $s1, 50
	j Continue2
Ordenar4:
	la $s0, grupo4		#cargo el arreglo correspondiente en $s0
	li $s1, 100
	j Continue2
Ordenar5:
	la $s0, grupo5		#cargo el arreglo correspondiente en $s0
	li $s1, 150
	j Continue2
Ordenar6:
	la $s0, grupo6		#cargo el arreglo correspondiente en $s0
	li $s1, 200
	j Continue2
Ordenar7:
	la $s0, grupo7		#cargo el arreglo correspondiente en $s0
	li $s1, 250
	j Continue2
Ordenar8:
	la $s0, grupo8		#cargo el arreglo correspondiente en $s0
	li $s1, 300
	j Continue2
Ordenar9:
	la $s0, grupo9		#cargo el arreglo correspondiente en $s0
	li $s1, 350
Continue2:

	jal time		#capturo la hora en milisegundos antes del ordenamiento
	add $t0, $zero, $v0	
	
	addi $sp, $sp, -8
	sw $t5, 4($sp)
	sw $t0, 0($sp)	
	
	jal BubbleSort		#efectuo el ordenamiento
	#jal PrintSorted
	
	jal time		#capturo la hora en milisegundos despues del ordenamiento
	
	lw $t0, 0($sp)
	lw $t5, 4($sp)
	addi $sp, $sp, 8
	
	add $t1, $zero, $v0
	
	sub $t7, $t1, $t0	#resto las dos horas para obtener el tiempo que demoro el ordenamiento
	
	#guardo el tiempo en el arreglo tiempos
	sll $t0, $s3, 2
	add $t0, $t0, $t5
	sw $t7, 0($t0)
	
	#li $v0, 1				# Se establece el parametro para mostrar por pantalla
	#move $a0, $t7				# Se trapasa el tiempo de ejecucion
	#syscall					# Se muestra el tiempo de ejecucion

	li $v0, 4			# Se establece el parametro para mostrar String	
	la $a0, NewLine			# Se coloca el salto de linea en $a0	
	syscall				# Se muestra el salto de linea	
	
	addi $s3, $s3, 1	#k++		
	slti $t7, $s3, 10	#if($s2<10) $t7=1; else $t7=0;
	bne $t7, $zero, For2	#FIN FOR2
		
	li $s3, 1
	jal WriteInFileSorted
	li $s3, 1
	jal WriteTimesFile
 ####################
 la $a0, OpcionBb
 li $v0, 4
 syscall
 j menuInterno
 
 ###################  OPCION INSERTION SORT  ##################	
 loopImprimir2:			#imprimo mi eleccion
  	jal ReadFile
	jal LlenarArreglos
	
	la $t5, tiempos
	li $s3, 0
ForIS:
	li $t0, 0			
	beq $s3, $t0, OrdenarIS1
	li $t0, 1
	beq $s3, $t0, OrdenarIS2
	li $t0, 2
	beq $s3, $t0, OrdenarIS3
	li $t0, 3
	beq $s3, $t0, OrdenarIS4
	li $t0, 4
	beq $s3, $t0, OrdenarIS5
	li $t0, 5
	beq $s3, $t0, OrdenarIS6
	li $t0, 6
	beq $s3, $t0, OrdenarIS7
	li $t0, 7
	beq $s3, $t0, OrdenarIS8
	li $t0, 8
	beq $s3, $t0, OrdenarIS9
OrdenarIS10:
	la $s0, grupo10		#cargo el arreglo correspondiente en $s0
	li $s1, 400
	j ContinueIS2
OrdenarIS1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	li $s1, 10
	j ContinueIS2
OrdenarIS2:
	la $s0, grupo2		#cargo el arreglo correspondiente en $s0
	li $s1, 20
	j ContinueIS2
OrdenarIS3:
	la $s0, grupo3		#cargo el arreglo correspondiente en $s0
	li $s1, 50
	j ContinueIS2
OrdenarIS4:
	la $s0, grupo4		#cargo el arreglo correspondiente en $s0
	li $s1, 100
	j ContinueIS2
OrdenarIS5:
	la $s0, grupo5		#cargo el arreglo correspondiente en $s0
	li $s1, 150
	j ContinueIS2
OrdenarIS6:
	la $s0, grupo6		#cargo el arreglo correspondiente en $s0
	li $s1, 200
	j ContinueIS2
OrdenarIS7:
	la $s0, grupo7		#cargo el arreglo correspondiente en $s0
	li $s1, 250
	j ContinueIS2
OrdenarIS8:
	la $s0, grupo8		#cargo el arreglo correspondiente en $s0
	li $s1, 300
	j ContinueIS2
OrdenarIS9:
	la $s0, grupo9		#cargo el arreglo correspondiente en $s0
	li $s1, 350
ContinueIS2:

	jal time		#capturo la hora en milisegundos antes del ordenamiento
	add $t0, $zero, $v0	
	
	addi $sp, $sp, -8
	sw $t5, 4($sp)
	sw $t0, 0($sp)	
	
	jal InsertionSort		#efectuo el ordenamiento
	#jal PrintSorted
	
	jal time		#capturo la hora en milisegundos despues del ordenamiento
	
	lw $t0, 0($sp)
	lw $t5, 4($sp)
	addi $sp, $sp, 8
	
	add $t1, $zero, $v0
	
	sub $t7, $t1, $t0	#resto las dos horas para obtener el tiempo que demoro el ordenamiento
	
	#guardo el tiempo en el arreglo tiempos
	sll $t0, $s3, 2
	add $t0, $t0, $t5
	sw $t7, 0($t0)
	
	#li $v0, 1				# Se establece el parametro para mostrar por pantalla
	#move $a0, $t7				# Se trapasa el tiempo de ejecucion
	#syscall					# Se muestra el tiempo de ejecucion

	li $v0, 4			# Se establece el parametro para mostrar String	
	la $a0, NewLine			# Se coloca el salto de linea en $a0	
	syscall				# Se muestra el salto de linea	
	
	addi $s3, $s3, 1	#k++		
	slti $t7, $s3, 10	#if($s2<10) $t7=1; else $t7=0;
	bne $t7, $zero, ForIS	#FIN FOR2
		
	li $s3, 2
	jal WriteInFileSorted
	li $s3, 2
	jal WriteTimesFile
 ####################
 la $a0, OpcionIn
 li $v0, 4
 syscall
 j menuInterno
 
 ###################  OPCION QUICK SORT  ##################	
 loopImprimir3:				#imprimo mi eleccion
   	jal ReadFile
	jal LlenarArreglos
	
	la $t5, tiempos
	li $s3, 0
ForQS:
	li $t0, 0			
	beq $s3, $t0, OrdenarQS1
	li $t0, 1
	beq $s3, $t0, OrdenarQS2
	li $t0, 2
	beq $s3, $t0, OrdenarQS3
	li $t0, 3
	beq $s3, $t0, OrdenarQS4
	li $t0, 4
	beq $s3, $t0, OrdenarQS5
	li $t0, 5
	beq $s3, $t0, OrdenarQS6
	li $t0, 6
	beq $s3, $t0, OrdenarQS7
	li $t0, 7
	beq $s3, $t0, OrdenarQS8
	li $t0, 8
	beq $s3, $t0, OrdenarQS9
OrdenarQS10:
	la $s0, grupo10		#cargo el arreglo correspondiente en $s0
	li $s1, 400
	j ContinueQS2
OrdenarQS1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	li $s1, 10
	j ContinueQS2
OrdenarQS2:
	la $s0, grupo2		#cargo el arreglo correspondiente en $s0
	li $s1, 20
	j ContinueQS2
OrdenarQS3:
	la $s0, grupo3		#cargo el arreglo correspondiente en $s0
	li $s1, 50
	j ContinueQS2
OrdenarQS4:
	la $s0, grupo4		#cargo el arreglo correspondiente en $s0
	li $s1, 100
	j ContinueQS2
OrdenarQS5:
	la $s0, grupo5		#cargo el arreglo correspondiente en $s0
	li $s1, 150
	j ContinueQS2
OrdenarQS6:
	la $s0, grupo6		#cargo el arreglo correspondiente en $s0
	li $s1, 200
	j ContinueQS2
OrdenarQS7:
	la $s0, grupo7		#cargo el arreglo correspondiente en $s0
	li $s1, 250
	j ContinueQS2
OrdenarQS8:
	la $s0, grupo8		#cargo el arreglo correspondiente en $s0
	li $s1, 300
	j ContinueQS2
OrdenarQS9:
	la $s0, grupo9		#cargo el arreglo correspondiente en $s0
	li $s1, 350
ContinueQS2:

	jal time		#capturo la hora en milisegundos antes del ordenamiento
	add $t6, $zero, $v0	
	
	
	move $t0, $s1		# $t0 contains n
	move $a0, $s0		# $a0 contains address of array
	li $a1, 0		# $a1 contains starting index to sort (low)
	addi $a2,$t0,-1 	# $a2 contains ending index to sort (high)
	jal QuickSort		#efectuo el ordenamiento
	#jal PrintSorted
	
	jal time		#capturo la hora en milisegundos despues del ordenamiento
	add $t1, $zero, $v0
	
	sub $t7, $t1, $t6	#resto las dos horas para obtener el tiempo que demoro el ordenamiento
	
	#guardo el tiempo en el arreglo tiempos
	sll $t0, $s3, 2
	add $t0, $t0, $t5
	sw $t7, 0($t0)
	
	#li $v0, 1				# Se establece el parametro para mostrar por pantalla
	#move $a0, $t7				# Se trapasa el tiempo de ejecucion
	#syscall					# Se muestra el tiempo de ejecucion

	li $v0, 4			# Se establece el parametro para mostrar String	
	la $a0, NewLine			# Se coloca el salto de linea en $a0	
	syscall				# Se muestra el salto de linea	
	
	addi $s3, $s3, 1	#k++		
	slti $t7, $s3, 10	#if($s2<10) $t7=1; else $t7=0;
	bne $t7, $zero, ForQS	#FIN FOR2
		
	li $s3, 3
	jal WriteInFileSorted
	li $s3, 3
	jal WriteTimesFile
 ####################
 la $a0, OpcionQk
 li $v0, 4
 syscall				
 j menuInterno
 

 #cierra el programa
 loopFin:																																					
 li $v0, 10
 syscall
 
###################### FUNCION PARA ESCRIBIR EN EL ARCHIVO LOS NUMERO ALEATORIOS  ################################
GenerarArchivoAleatorios:
  	#Abro el archivo aleatorios.txt
  	li   $v0, 13       #llamada al sistema para abrir archivos
  	la   $a0, file1     #especifico el nombre del archivo
  	li   $a1, 1        #especifico que abro el archivo para escritura
  	li   $a2, 0        
  	syscall            #abro el archivo y el file descriptor se guarda en $v0
  	add $s6, $v0, $zero      #guardo el file descriptor en $s6 
  	
  	la $s3, grupos	#guardo en $s3 la direccion base del arreglo
  	li $s2, 0	#j=0
  	
ForG:
	li   $v0, 15       #llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero      #especifico el file descriptor 
  	la $a1, corcheteIzq     #especifico la direccion del string que queremos escribir
  	li $a2, 1 
  	syscall			#escribo el corchete inicial  
  	
  	sll $t5, $s2, 2		#multiplico el indice del arreglo por cuatro para obtener el offset=$t5
  	add $t5, $t5, $s3	#sumo el offset a la direccion base del arreglo y obtengo la direccion del indice 
  				#del arreglo=$t5   	
  	lw $t6, 0($t5)		#guardo en $t6 el valor del indice del arreglo
  	   	   	
  	li $s1, 0	#i=0
  	add $t4, $t6, -1	#temporal para verificar si ya se escribio el ultimo numero 
For:
	#Genero el numero aleatorio
  	addi $sp, $sp, -4
	sw $ra, 0($sp) 	#guardo la direccion de retorno enla pila
  	jal Random	#llamo a mi funcion para generar un numero aleatorio
  	lw $ra, 0($sp)	#cargo la direciion de retorno de la pila
	addi $sp, $sp, 4
	add $s0, $zero, $zero
	add $s0, $v0, $zero   #guardo el retorno de la funcion random en $s0
		#li $v0, 1	#llamada al sistema para imprimir un integer
		#add $a0, $s0, $zero	#seteo el numero a imprimir
		#syscall	
	#Convierto el numero aleatorio generado a String
	move $a0, $s0	#envio el numero aleatorio como parametro para convertirlo en string
	la $a1, buffer	#envio como parametro el buffer donde almacenare el entero convertido a string
	addi $sp, $sp, -4
	sw $ra, 0($sp) 	#guardo la direccion de retorno en la pila
	jal ItoA	#llamo a la funcion para convetir a string
	add $t0, $v0, $zero	#guardo en $t0 el numero de digitos del aleatorio
	lw $ra, 0($sp)	#cargo la direccion de retorno de la pila
	addi $sp, $sp, 4
  	#Escribo en el archivo aleatorios.txt
  	li   $v0, 15       #llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero      #especifico el file descriptor 
  	la $a1, buffer     #especifico la direccion del string que queremos escribir
  	add $a2, $zero, $t0
  	#li $a2, 6 
  	syscall            #escribo en el archivo  
  	li   $v0, 15       #llamada al sistema para escritura en archivos
  	beq $s1, $t4, Corchete 
	la $a1, coma     #especifico la direccion del string que queremos escribir
	j Continue
Corchete:
	la $a1, corcheteDer     #especifico la direccion del string que queremos escribir
Continue:
	li $a2, 1
	syscall            #escribo en el archivo  	
	addi $s1, $s1, 1	#i++		
	slt $t1, $s1, $t6	#if($s1<$t6) $t1=1; else $t1=0;
	bne $t1, $zero, For	#if($s1<$t6) sigue en el for; else sale del for
	
	addi $s2, $s2, 1	#j++		
	slti $t7, $s2, 10	#if($s2<10) $t1=1; else $t1=0;
	bne $t7, $zero, ForG	#fin del for grande
		
  	#Cierro el archivo 
  	li   $v0, 16       #llamada al sistema para cerrar archivo
  	add $a0, $s6, $zero      #especifico el file descriptor
  	syscall            #cierro el archivo  
  	jr $ra		#termino mi funcion
Random:
	li $v0, 42	#llamada al sistema para generar aleatorios
	li $a1, 1001	#seteo el limite superior del rango de aleatorios
	syscall
	add $v0, $zero, $zero
	add $v0, $a0, $zero	#guardo mi valor aleatorio en el registro $v0
	jr $ra		#retorno el aleatorio
	
########  FUNCION PARA LLENAR LOS 10 ARREGLOS CORRESPONDIENTES A LOS 10 GRUPOS DE ALEATORIOS  ###########
LlenarArreglos:
	
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
	li $t9,0
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
	li $v0, 13 # syscall cargar archivo
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
		
###################  FUNCION PARA ESCRIBIR LOS NUMEROS ORDENADOS EN EL ARCHIVO  #################
WriteInFileSorted:
  	#Abro el archivo bur_aleatorios.txt
  	li   $v0, 13       #llamada al sistema para abrir archivos
  	
  	li $t0, 1
	beq $s3, $t0, Archivo2
	li $t0, 2
	beq $s3, $t0, Archivo3
Archivo4:
	la   $a0, file4     #especifico el nombre del archivo
	j FinArchivos
Archivo2:
	la   $a0, file2     #especifico el nombre del archivo
	j FinArchivos
Archivo3:
	la   $a0, file3     #especifico el nombre del archivo
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
	li $t0, 1
	beq $s2, $t0, Write2
	li $t0, 2
	beq $s2, $t0, Write3
	li $t0, 3
	beq $s2, $t0, Write4
	li $t0, 4
	beq $s2, $t0, Write5
	li $t0, 5
	beq $s2, $t0, Write6
	li $t0, 6
	beq $s2, $t0, Write7
	li $t0, 7
	beq $s2, $t0, Write8
	li $t0, 8
	beq $s2, $t0, Write9
Write10:
	la $s0, grupo10		#cargo el arreglo correspondiente en $s0
	j Continue4
Write1:
	la $s0, grupo1		#cargo el arreglo correspondiente en $s0
	j Continue4
Write2:
	la $s0, grupo2		#cargo el arreglo correspondiente en $s0
	j Continue4
Write3:
	la $s0, grupo3		#cargo el arreglo correspondiente en $s0
	j Continue4
Write4:
	la $s0, grupo4		#cargo el arreglo correspondiente en $s0
	j Continue4
Write5:
	la $s0, grupo5		#cargo el arreglo correspondiente en $s0
	j Continue4
Write6:
	la $s0, grupo6		#cargo el arreglo correspondiente en $s0
	j Continue4
Write7:
	la $s0, grupo7		#cargo el arreglo correspondiente en $s0
	j Continue4
Write8:
	la $s0, grupo8		#cargo el arreglo correspondiente en $s0
	j Continue4
Write9:
	la $s0, grupo9		#cargo el arreglo correspondiente en $s0
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
  	

######################  FUNCION DE OBTENCION DEL TIEMPO DEL SISTEMA  ###########################
time:	
	li $v0, 30			# Se establece el parametro para obtener la hora del sistema	
	syscall				# Se obtiene la hora del sistema	
	move $t0, $a0			# Se almacena el tiempo obtenido en $t0	
	#li $v0, 1			# Se establece el parametro para mostrar por pantalla	
	#move $a0, $t0			# Se almacena la hora obtenia en $a0 para luego ser mostrada	
	#syscall				# Se muestra la hora obtenida	
	#li $v0, 4			# Se establece el parametro para mostrar String	
	#la $a0, NewLine			# Se coloca el salto de linea en $a0	
	#syscall				# Se muestra el salto de linea		
	move $v0, $t0			# Se pasa el tiempo obtenido a $v0 para ser devuelto	
	jr $ra				# Se devuelve el tiempo obtenido

###################### FUNCION PARA ESCRIBIR EL ARCHIVO DE LOS TIEMPOS  ######################
WriteTimesFile:
	addi $sp, $sp, -20
	sw $s6, 12($sp)
	sw $s1, 8($sp)
	sw $s3, 4($sp)
	sw $s2, 0($sp)
	
	#Abro el archivo bur_tiempos.txt
  	li   $v0, 13       #llamada al sistema para abrir archivos
  	
  	li $t0, 1
	beq $s3, $t0, Archivo5
	li $t0, 2
	beq $s3, $t0, Archivo6
Archivo7:
	la   $a0, file7     #especifico el nombre del archivo
	j FinArchivosT
Archivo5:
	la   $a0, file5     #especifico el nombre del archivo
	j FinArchivosT
Archivo6:
	la   $a0, file6     #especifico el nombre del archivo
FinArchivosT:
  	
  	li   $a1, 1        #especifico que abro el archivo para escritura
  	li   $a2, 0        
  	syscall            #abro el archivo y el file descriptor se guarda en $v0
  	add $s6, $v0, $zero      #guardo el file descriptor en $s6 
  	
  	la $s2, tiempos
	li $s3, 0
ForTF:
	sll $t7, $s3, 2
	add $t7, $t7, $s2
	lw $s1, 0($t7)
	
	
	#Convierto el numero aleatorio generado a String
	move $a0, $s1	#envio el numero aleatorio como parametro para convertirlo en string
	la $a1, buffer	#envio como parametro el buffer donde almacenare el entero convertido a string
	sw $ra, 16($sp) 	#guardo la direccion de retorno en la pila
	jal ItoA	#llamo a la funcion para convetir a string
	add $t7, $v0, $zero	#guardo en $t7 el numero de digitos del aleatorio
	lw $ra, 16($sp)	#cargo la direccion de retorno de la pila
  	#Escribo en el archivo bur_tiempos.txt
  	li   $v0, 15       #llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero      #especifico el file descriptor 
  	la $a1, buffer     #especifico la direccion del string que queremos escribir
  	add $a2, $zero, $t7
  	syscall            #escribo en el archivo  
  	
	li   $v0, 15       #llamada al sistema para escritura en archivos
  	add $a0, $s6, $zero      #especifico el file descriptor 
  	la $a1, pipe     #especifico la direccion del string que queremos escribir
  	addi $a2, $zero, 1
  	syscall  

	addi $s3, $s3, 1	#k++		
	slti $t7, $s3, 10	#if($s2<10) $t7=1; else $t7=0;
	bne $t7, $zero, ForTF	#FIN FOR2

	#Cierro el archivo 
  	li   $v0, 16       #llamada al sistema para cerrar archivo
  	add $a0, $s6, $zero      #especifico el file descriptor
  	syscall            #cierro el archivo  
		
	lw $s2, 0($sp)
	lw $s3, 4($sp)
	lw $s1, 8($sp)
	lw $s6, 12($sp)
	addi $sp, $sp, 20
	jr $ra
	
##################  FUNCION DE ORDENAMIENTO INSERTION SORT  #########################
InsertionSort:	
	addi $sp, $sp, -32
	sw $t0, 28($sp)
	sw $t1, 24($sp)
	sw $t2, 20($sp)
	sw $t3, 16($sp)
	sw $t4, 12($sp)
	sw $t5, 8($sp)
	sw $t6, 4($sp)
	sw $t7, 0($sp)

	move	$t5, $s0     	#carga el array
	move	$t0, $s1   	# tamaño del array 
	li	$t1, 1        	#constante
	li	$t7, 4        	#constante para offset
for_compare: 
	bge	$t1, $t0, end_for     	# condicion t1>=t0 (acum>=tam_array)
	addi	$t2, $t1, -1		#aux para index
	mul	$t4, $t1, $t7		# t4 toma un valor del sgt
	add	$t4, $t5, $t4		# t4 se iguala al sgt elemento del array
	lw	$t3, 0($t4)		# se toma el elemento de t4 en t3
while:
	blt	$t2, 0, end_while	#condicion para tomar el sgt elemento
	mul	$t4, $t2, $t7          	#reinicia t4 al anterior
	add	$t4, $t4, $t5		#t4 toma nuevamente el array
	lw	$t6, 0($t4)		#t6 toma el anterior valor de t4
	ble	$t6, $t3, end_while	#condicion t6<=t3
					#FALSA
	sw	$t6, 4($t4)		#t6 toma el anterior valor de t4
	addi	$t2, $t2, -1		#t2 disminuye

	
	j 	while
end_while:				#VERDADERA
	mul	$t4, $t2, $t7		#t4 se reinicia
	add	$t4, $t5, $t4		#t4 toma el valor del array
	sw	$t3, 4($t4)		#t3 toma el segundo valor de t4
	addi	$t1, $t1, 1		#t1 se acumula
	
	j 	for_compare
end_for:
	lw $t7, 0($sp)
	lw $t6, 4($sp)
	lw $t5, 8($sp)
	lw $t4, 12($sp)
	lw $t3, 16($sp)
	lw $t2, 20($sp)
	lw $t1, 24($sp)
	lw $t0, 28($sp)
	addi $sp, $sp, 32
	jr $ra


##################  FUNCION DE ORDENAMIENTO QUICK SORT  #########################
QuickSort:

	addi	$sp, $sp, -20		# make room on stack for 5 registers
	sw	$s0, 4($sp)		# save $s0 on stack
	sw	$s1, 8($sp)		# save $s1 on stack
	sw	$s2, 12($sp)		# save $s2 on stack
	sw	$s3, 16($sp)		# save $s3 on stack
	sw	$ra, 20($sp)		# save $ra on stack

	move	$s0, $a0		# copy param. $a0 into $s0 (addr array)
	move 	$s1, $a1		# copy param. $a1 into $s1 (low)
	move 	$s2, $a2		# copy param. $a2 into $s2 (high)

if:
	blt	$s1, $s2, then		# if low < high
	j	endIf
then:

	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	jal	partition
	move 	$s3, $v0		# save pivotPosition

	move 	$a0, $s0
	move 	$a1, $s1
	addi 	$a2, $s3, -1
	jal	QuickSort

	move 	$a0, $s0
	addi	$a1, $s3, 1
	move	$a2, $s2
	jal	QuickSort

endIf:

	lw	$s0, 4($sp)		# restore $s0 from the stack
	lw	$s1, 8($sp)		# restore $s1 from the stack
	lw	$s2, 12($sp)		# restore $s2 from the stack
	lw	$s3, 16($sp)		# restore $s3 from the stack
	lw	$ra, 20($sp)		# restore $ra from the stack
	addi	$sp, $sp, 20		# restore stack pointer

	jr	$ra			# return to calling routine
	
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



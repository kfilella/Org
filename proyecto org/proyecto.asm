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
 
 ###############  FUNCION PARA LEER UN ARCHIVO  #############
 
ReadFile:
	#abro el archivo
	li $v0, 13 # syscall cargar archivo
	la $a0, file1
	li $a1, 0
	li $a2, 0
	syscall
	move $s6, $v0
	
	#leo del archivo
	li $v0, 14
	add $a0, $s6, $zero
	la $a1, buffer
	li $a2, 9160
	syscall
	
	#Cierro el archivo 
  	li   $v0, 16       #llamada al sistema para cerrar archivo
  	move $a0, $s6     #especifico el file descriptor
  	syscall            #cierro el archivo  
  	
  	
  	#IMPRIMO EL BUFFER
  	li $v0, 4           
	la $a0, buffer          # load read data in $a0
	syscall

	jr $ra		#FIN DE LA FUNCION
	
######################## FUNCION QUE RECORRE EL ARREGLO Y LO LLENA ####################


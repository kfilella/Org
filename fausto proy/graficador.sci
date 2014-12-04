//Funcion encargada de cargar los datos del archivo 
//
//Parametros
//fileNsme: Nombre del archivo a ser leido
//GROUPS: Vector con el numero de grupos a graficar
//TIMES: Vector con los tiempos, leidos desde archivo

function [GROUPS, TIMES] = loadDatas  (fileName)
    GROUPS = [10, 20, 50, 100, 150, 200, 250, 300, 350, 400]
    TIMES = zeros(1,10)
    line = ""                   
    
    fd = mopen(fileName,'r')                                                    //Localiza el archivo y lo coloca en modo lectura
    
    if (fd == -1) then                                                          
        error("Archivo no localizado")                                          //Significa que el archivo no puede ser leido
    else
                                                                                
        for i=1:length(GROUPS)                                                  //Genero el formato de lectura en el archivo
            line = line + "%d|"                                                 //Concateno el formato de acuerdo a la cantidad de valores a almacenar
        end
        
        line = line + "\n"                                                      //Concateno el salto de linea
        
                                                                                //Realiza la lectura de la linea del archivo
        [n,TIMES(1),TIMES(2), TIMES(3), TIMES(4), TIMES(5), TIMES(6), TIMES(7), TIMES(8), TIMES(9), TIMES(10)] = mfscanf(fd, line)
    end
    
    mclose(fd)                                                                  //Cierre del archivo
    
endfunction

//******************************************************************************
//Funcion encargada de graficar segun las caracteristicas predefinidas
//Parametros:
//X: Conjunto de valores ubicados en el eje de las abcisas
//Y: Conjunto de valores ubicados en el eje de las ordenadas
//n: Indica el numero del color a ser coloreada la grafica
//******************************************************************************
function [] = plotDatas(X, Y, n)
    title("Tiempo de Ordenamiento de un conjunto de enteros VS Cantidad de datos")//Coloca el titulo de las graficas
    xlabel("Tiempos (ms)")                  //Muestra el rotulo en el eje de las abcisas
    ylabel("Grupos")                        //Muestra el rotulo en el eje de las ordenadas
    plot2d(X,Y,style=n)                     //Grafica segun el par de conjuntos dados y el color a ser dibujada
    p = get("hdl");                         
    p.children.mark_mode = "on";            //Activacion de las marcas
    p.children.mark_style = 9;              //Tipo de marca a mostrar
    p.children.thickness = 2;               //Grosor de las marcas
    p.children.mark_foreground = n;         //Color de las marcas
endfunction

//******************************************************************************
//Funcion encargada de graficar los datos de un determinado archivo y el color
//que se desea que este tenga.
//Parametros:
//fileName: Nombre del archivo a ser cargado y posteriormente graficados
//s: Color de la grafica
//******************************************************************************
function [] = plotting(fileName, s)
    clc
    [GROUPS,TIMES] = loadDatas(fileName)
    plotDatas(TIMES,GROUPS, s)
endfunction

//******************************************************************************
//Funcion que se encarga de hacer el ploteo de 1 o varias graficas dentro
//de un mismo plano cartesiano

//Parametros
//FILES: Vector de string con los nombres de los archivos a graficar.
//******************************************************************************
function [] = plottingFiles(FILES)
    len = size(FILES)                   //Obtiene la cantidad de archivos a plotear
    for i=1: len(2)                     
        plotting(FILES(i), i+1)         //Ejecuta el ploteo de cada grafica
    end
    legend(FILES,4)                     //Muestra la leyenda, el 4 es la ubicacion de la grafica
    xgrid                               //Muestra las cuadriculas en el graficador
endfunction

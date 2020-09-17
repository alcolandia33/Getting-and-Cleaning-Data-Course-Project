# Getting-and-Cleaning-Data-Course-Project

El script  run_analysis.R, lleva a cabo lo siguiente:

1.Descargua el conjunto de datos si aún no existe en el directorio de trabajo.

2. Lee los conjuntos de datos del train y del test y combína en x (measurements), y(activity) y subject,, respectivamente.

3. Carg la función de datos (x), la información de la actividad y extrar las columnas denominadas 'mean'(-mean) and 'standard'(-std).

4. Extrae los datos por columnas seleccionadas  y combine x, y (activity) y los datos del sujeto. 
Además, reemplace la columna y (activity) por su nombre haciendo referencia a la etiqueta de actividad .
Genera un Conjunto de datos ordenado que consista en el promedio (media) de cada variable para cada tema y cada actividad.
El resultado se muestra en el archivo datos_ordenados.txt.

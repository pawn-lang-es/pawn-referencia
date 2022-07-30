# Comprobación del programa
¿No debería el compilador/interpretador detectar todos los errores? Esta pregunta
retórica tiene un lado técnico y otro filosófico. No voy a mencionar todos los 
aspectos no técnicos y sólo mencionaré que, en la práctica, existe un equilibrio
entre la "expresividad" de un lenguaje informático y la "corrección forzada" (o 
"corrección demostrable') de los programas en ese lenguaje. Hacer un lenguaje muy
"estricto" no es una solución si hay que hacer un trabajo que supere el tamaño de
un programa de juguete. Un lenguaje demasiado estricto deja al programador luchando
con el lenguaje, mientras que el "problema a resolver" debería ser la verdadera 
lucha y el lenguaje debería ser un medio sencillo en el que expresar la solución.

El objetivo del lenguaje PAWN es proporcionar al desarrollador un mecanismo informal,
y cómodo de usar, para comprobar si el programa se comporta como se pretendía. Este 
mecanismo se llama "**aserciones**" y, aunque el concepto de aserciones es anterior
a la idea de "diseño por contrato", se explica más fácilmente a través de la idea 
de diseño por contrato.

El paradigma del "diseño por contrato" proporciona un enfoque alternativo para 
tratar las condiciones erróneas. La premisa es que el programador conoce la tarea, 
las condiciones en las que debe funcionar el software y el entorno. En este entorno,
cada función especifica las condiciones específicas, en forma de afirmaciones, que 
deben cumplirse antes de que un cliente pueda ejecutar la función. Además, la función
también puede especificar las condiciones que deben cumplirse después de completar 
su operación. Este es el "contrato" de la función.

El nombre "diseño por contrato" fue acuñado por Bertrand Meyer y sus principios se remontan a la lógica de las predicciones y al análisis algorítmico.

- Las precondiciones especifican los valores válidos de los parámetros de entrada y los atributos del entorno;

- Las postcondiciones especifican la salida y el entorno (posiblemente modificado);

- Las invariantes indican las condiciones que deben cumplirse en los puntos clave de una función, independientemente del camino que se tome a través de ella.

Por ejemplo, una función que calcula la raíz cuadrada de un número puede especificar que su parámetro de entrada sea no negativo. Se trata de una condición previa. También puede especificar que su salida, cuando se eleva al cuadrado, es el valor de entrada 0,01%. Esta es una postcondición; verifica que la rutina ha operado correctamente. Una forma conveniente de calcular una raíz cuadrada es mediante la "bisección". En cada iteración, este algoritmo da al menos un bit extra (dígito binario) de precisión. Esto es un invariante (aunque podría ser un invariante difícil de comprobar).

Las precondiciones, las postcondiciones y los invariantes son similares en el sentido de que todos consisten en una prueba y que una prueba fallida indica un error en
la implementación. Como resultado, puedes implementar precondiciones, postcondiciones e invariantes con una sola construcción: la "aserción". Para las precondiciones, escriba las aserciones al principio de la rutina; para las invariantes, escriba una aserción en el lugar en el que debe cumplirse la invariante; para las postcondiciones, escriba una aserción antes de cada sentencia "return" o al final de la función.

En el peón, la instrucción se llama assert; es una declaración simple que contiene una prueba. Si el resultado de la prueba es "true", no pasa nada. Si el resultado es "falso", la instrucción assert termina el programa con un mensaje que contiene los detalles de la aserción que ha fallado.

Las aserciones son comprobaciones que nunca deberían fallar. Los errores genuinos, como
errores de entrada del usuario, deben ser manejados con pruebas explícitas en el programa, y
no con aserciones. Como regla, las expresiones contenidas en las aserciones deben estar libres de efectos secundarios: una aserción nunca debe contener código que su aplicación requiera para su correcto funcionamiento.

Esto tiene el efecto, sin embargo, de que las aserciones nunca se activen en un
programa libre de errores: sólo engordan el código y lo hacen más lento, sin ningún beneficio visible para el usuario. Sin embargo, no es tan malo. Una característica adicional de las aserciones es que puedes construir el código fuente sin aserciones simplemente usando una bandera u opción al analizador de peones. La idea es que habilites las aserciones durante el desarrollo y construyas la "versión retail" del código sin aserciones. Este es un mejor enfoque que eliminar las aserciones, porque todas las aserciones están automáticamente "de vuelta" cuando se recompila el programa -por ejemplo, para el mantenimiento.

Durante el mantenimiento, o incluso durante el desarrollo inicial, si encuentra un error que no fue atrapado por una aserción, antes de arreglar el error, debería pensar en cómo una aserción podría haber atrapado este error. Entonces, añada esta aserción y pruebe si efectivamente atrapa el error antes de arreglarlo. Haciendo esto, el código se volverá gradualmente más robusto y fiable.

> [Regresar a la página anterior](10-programacion-por-estados.md) (Programación por estados)
>
> [Ir a la siguiente página](12-comentarios-para-documentacion.md) (Comentarios para documentación)
>
> <sub>[Subir al principio de esta página](#comprobación-del-programa)</sub>
# Advertencias y errores
El gran obstáculo que he superado es cómo compilar realmente los fragmentos de código presentados en este capítulo. La razón es que el procedimiento depende del sistema que estés utilizando: en algunas aplicaciones hay un botón de comando u opción de menú "Make" o "Compile script", mientras que en otros entornos tienes que escribir un comando como "sc myscript" en un símbolo del sistema. Si utiliza el conjunto de herramientas estándar del peón, encontrará instrucciones sobre cómo utilizar el compilador y el tiempo de ejecución en el folleto complementario "The pawn booklet - Implementor's Guide".

Independientemente de las diferencias en el lanzamiento de la compilación, el fenómeno que resulta del lanzamiento de la compilación es probablemente muy similar
entre todos los sistemas:

- o bien la compilación tiene éxito y produce un programa ejecutable -que puede o no ejecutarse automáticamente después de la compilación;

- o la compilación da una lista de mensajes de advertencia y error.

- Los errores ocurren y el analizador de peones trata de atrapar tantos como pueda. Cuando inspeccione el código del que se queja el analizador de peones, en ocasiones le resultará bastante difícil ver por qué el código es erróneo (o sospechoso). Los siguientes consejos pueden ayudar:

- Cada número de error o advertencia está numerado. Puede buscar el mensaje de error con este número en el apéndice A, junto con una breve descripción de lo que realmente significa el mensaje.

- Si el analizador sintáctico de peones produce una lista de errores, el primer error de esta lista es un error verdadero, pero los mensajes de diagnóstico que están debajo pueden no ser errores en absoluto. Después de que el analizador sintáctico de peones vea un error, intenta pasar por encima de él y completar la compilación. Sin embargo, el tropiezo con el error puede haber confundido al analizador sintáctico de peones, de modo que las declaraciones legítimas subsiguientes son malinterpretadas y reportadas como errores también. En caso de duda, corrija el primer error y vuelva a compilar.

- El analizador de peones sólo comprueba la sintaxis (ortografía/gramática), no la semántica (es decir, el "significado") del código. Cuando detecta un código que no se ajusta a las reglas sintácticas, puede haber diferentes maneras de cambiar el código para que sea "correcto", en el sentido sintáctico de la palabra -aunque muchas de estas "correcciones" darían lugar a un código sin sentido. El resultado es, sin embargo, que el analizador sintáctico puede tener dificultades para localizar con precisión el error: no sabe lo que usted quiso escribir. Por lo tanto, el analizador sintáctico a menudo emite dos números de línea y el error se encuentra en algún lugar del rango (entre los números de línea).

- Recuerde que un programa que no tiene errores sintácticos (el analizador sintáctico lo acepta sin mensajes de error y advertencia) puede tener errores semánticos y lógicos que el analizador sintáctico no puede detectar. La instrucción assert (página 112) está pensada para ayudarle a detectar estos errores "en tiempo de ejecución".

> [Regresar a la página anterior](12-comentarios-para-documentacion.md) (Comentarios para documentación)
>
> [Ir a la siguiente página](14-en-conclusion.md) (En conclusión)
>
> <sub>[Subir al principio de esta página](#comentarios-para-documentación)</sub>
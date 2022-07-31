# Advertencias y errores
El gran obstáculo que he superado es cómo compilar realmente los fragmentos de código presentados en este capítulo. La razón es que el procedimiento depende del sistema que estés utilizando. Si utilizas el conjunto de herramientas estándar de PAWN, encontrarás instrucciones sobre cómo utilizar el compilador y el tiempo de ejecución en el manual complementario "The Pawn booklet - Implementor's Guide" (en inglés).

Sin importar cómo compiles tu código, los resultados después de compilar son muy similares entre todos los sistemas:

- o bien la compilación tiene éxito y produce un programa ejecutable —que puede o no ejecutarse automáticamente después de la compilación;

- o la compilación da una lista de mensajes de advertencia y errores.

Los errores ocurren y el analizador de PAWN trata de atrapar tantos como pueda. Cuando inspeccioneS el código del que te alerta el analizador, en ocasiones te resultará bastante difícil ver por qué el código es erróneo (o sospechoso). Los siguientes consejos pueden ayudar:

- Cada mensaje de error o advertencia está numerado. Puedes buscar el mensaje de error con este número en el [apéndice A](), junto con una breve descripción de lo que realmente significa el mensaje.

- Si el analizador sintáctico de PAWN produce una lista de errores, el primer error de esta lista es un error verdadero, pero los mensajes de diagnóstico que están debajo pueden no ser errores en absoluto. 

Después de que el analizador sintáctico vea un error, intenta pasar por encima de él y completar la compilación. Sin embargo, el tropiezo con el error puede haber confundido al analizador, de modo que las declaraciones legítimas subsiguientes son malinterpretadas y reportadas como errores también. 

En caso de duda, corrija el primer error y vuelva a compilar.

- El analizador de PAWN sólo comprueba la sintaxis (ortografía/gramática), no la semántica (es decir, el "significado") del código. Cuando detecta un código que no se ajusta a las reglas sintácticas, puede haber diferentes maneras de cambiar el código para que sea "correcto", en el sentido sintáctico de la palabra -aunque muchas de estas "correcciones" darían lugar a un código sin sentido. El resultado es, sin embargo, que el analizador sintáctico puede tener dificultades para localizar con precisión el error: no sabe lo que usted quiso escribir. Por lo tanto, el analizador sintáctico a menudo emite dos números de línea y el error se encuentra en algún lugar del rango (entre los números de línea).

- Recuerde que un programa que no tiene errores sintácticos (el analizador sintáctico lo acepta sin mensajes de error y advertencia) puede tener errores semánticos y lógicos que el analizador sintáctico no puede detectar. La instrucción `assert` (ver capítulo [7. Sentencias](../07-Sentencias/00-sentencias.md)) está pensada para ayudarle a detectar estos errores "en tiempo de ejecución".

> [Regresar a la página anterior](12-comentarios-para-documentacion.md) (Comentarios para documentación)
>
> [Ir a la siguiente página](14-en-conclusion.md) (En conclusión)
>
> <sub>[Subir al principio de esta página](#comentarios-para-documentación)</sub>
# Programación por estados
En un programa que sigue el modelo basado en eventos, los eventos llegan individualmente, y también se responde a ellos de forma individual. En ocasiones, sin embargo, un evento forma parte de un flujo secuencial, que debe ser manejado en orden. Un ejemplo son los protocolos de transferencia de datos a través de, por ejemplo, una línea serie [^1]. [[Detallar ejemplo]()]

[^1]: Cambiar por un ejemplo más familiar.

Para que el flujo de eventos (y los paquetes de datos que llevan) tenga sentido, el programa dirigido por eventos debe seguir un protocolo preciso de intercambio.

Para adherirse a un protocolo, un programa dirigido por eventos debe responder a cada evento de acuerdo con el historial (reciente) de eventos recibidos anteriormente y las respuestas a esos eventos. En otras palabras, el manejo de un evento puede establecer una "condición" o "entorno" para el manejo de uno o más eventos posteriores.

Una abstracción simple, pero bastante eficaz, para construir sistemas reactivos que necesitan seguir protocolos (parcialmente) secuenciales, es la del "autómata" o máquina de estados. Como el número de estados suele ser finito, la teoría suele referirse a estos autómatas como Autómatas de Estado Finito o Máquinas de Estado Finito. En un autómata, el contexto (o condición) de un evento es su estado. Un suceso que llega puede tratarse de forma diferente según el estado del autómata, y en respuesta a un suceso, el autómata puede cambiar de estado, lo que se denomina transición. Una transición, en otras palabras, es una respuesta del autómata a un evento en el contexto de su estado.

Los autómatas son muy comunes tanto en el software como en los dispositivos mecánicos (puedes ver el [telar de Jacquard]() como una de las primeras máquinas de estado). Los autómatas, con un número finito de estados, son deterministas (es decir, su comportamiento es predecible) y su diseño relativamente sencillo permite una implementación directa a partir de un "diagrama de estados".

En un diagrama de estados, los estados suelen representarse como círculos o
rectángulos redondeados y las flechas representan las transiciones. Como las transiciones son la respuesta del autómata a los sucesos, una flecha también puede verse como un suceso "que hace algo".

Un evento/transición que no está definido en un estado particular se supone que no tiene efecto - se ignora silenciosamente. Un punto negro rellenado representa el estado de entrada, que su programa (o la aplicación anfitriona) debe establecer en el arranque. Es común omitir en un diagrama de estado todas las flechas de eventos que vuelven al mismo estado, pero aquí he elegido hacer explícita la respuesta a todos los eventos.

![Diagrama de estado como ejemplificacion](https://i.ibb.co/k3kWVvy/image.png)

Este diagrama de estado anterior es para "analizar" los comentarios que comienzan con /* y terminan con */. Hay estados para el texto plano y para el texto dentro de un comentario, además de dos estados para la entrada o salida tentativa de un comentario. El autómata pretende analizar los comentarios de forma interactiva, a partir de los caracteres que el usuario escribe en el teclado. Por lo tanto, los únicos eventos a los que reacciona el autómata son las pulsaciones de teclas. En realidad, sólo hay un evento ("pulsación de tecla") y
los cambios de estado están determinados por el parámetro del evento: la tecla.

PAWN soporta autómatas y estados directamente en el lenguaje. Cada función puede tener opcionalmente uno o más estados asignados. PAWN también soporta múltiples autómatas, y cada estado es parte de un autómata particular. 
El siguiente script implementa el diagrama de estados anterior (en un único autómata anónimo). Para diferenciar el texto plano de los comentarios, ambos se muestran en un color diferente.

<sub>DISPONIBLE EN: comment.p</sub>
```pawn
/* Analizador de comentarios tipo-C interactivo, utilizando eventos y una máquina de estado */

main()
    state plain

@keypressed(key) <plain>
    {
    state (key == '/') slash
    if (key != '/')
        echo key
    }

@keypressed(key) <slash>
    {
    state (key != '/') plain
    state (key == '*') comment
    echo '/'    /* Imprimir '/' retenido del estado anterior */
    if (key != '/')
        echo key
    }

@keypressed(key) <comment>
    {
    echo key
    state (key == '*') star
    }

@keypressed(key) <star>
    {
    echo key
    state (key != '*') comment
    state (key == '/') plain
    }

echo(key) <plain, slash>
    printchar key, yellow

echo(key) <comment, star>
    printchar key, green

printchar(ch, colour)
    {
    setattr .foreground = colour
    printf "%c", ch
    }
```

La función main establece el estado inicial y sale; toda la lógica es dirigida por eventos.
cuando una tecla llega en el estado plain, el programa comprueba si se trata de un slash y condicionalmente imprime la tecla recibida. La interacción entre los estados plain y slash demuestra una complejidad que es típica de los autómatas: debes decidir cómo responder a un evento cuando llega, sin poder "mirar hacia adelante" o deshacer las respuestas a eventos anteriores. Este suele ser el caso de los sistemas basados en eventos: no sabes qué evento recibirás a continuación, ni cuándo lo recibirás, y sea cual sea tu respuesta al evento actual, es muy probable que no puedas borrarla en un evento futuro y fingir que nunca ocurrió.

En nuestro caso particular, cuando llega un slash, podría ser el inicio de una secuencia de comentarios (/*), pero no es necesariamente así. Por inferencia, no podemos decidir en la recepción del carácter de la barra oblicua en qué color imprimirlo. Por lo tanto, lo retenemos. Sin embargo, no hay ninguna variable global en el script que diga que se retiene un carácter -de hecho, aparte de los parámetros de la función, no se declara ninguna variable en este script. La información sobre el carácter retenido está "oculta" en el estado del autómata.

Como se ve en el script, los cambios de estado pueden ser condicionales. La condición es opcional, y también se puede utilizar la construcción común if-else para cambiar los estados.

La dependencia del estado no está reservada a las funciones de evento. Otras funciones pueden tener declaraciones de estado también, como demuestra la función `echo`. Cuando una función tenga la misma implementación para varios estados, basta con escribir una única implementación y mencionar todos los estados aplicables. Para la función `echo` hay dos implementaciones para manejar los cuatro estados.

Dicho esto, un autómata debe estar preparado para manejar todos los eventos en cualquier estado. Normalmente, el autómata no tiene control sobre qué eventos llegan ni sobre cuándo llegan, por lo que no manejar un evento en algún estado podría llevar a decisiones erróneas. Por lo tanto, es frecuente que algunos eventos sólo tengan sentido en algunos estados específicos y que deban provocar un error o un procedimiento de "reinicio" en todos los demás casos. La función para manejar el evento en tal condición de "error" podría entonces contener un montón de nombres de estados, si los mencionara explícitamente. Hay una forma más corta: al no mencionar ningún nombre entre los paréntesis angulares, la función coincide con todos los estados que no tienen una implementación explícita en otra parte. Así, por ejemplo, se podría utilizar la forma `echo(key) <>` para cualquiera de las dos implementaciones (pero no para ambas).

Un único autómata anónimo está predefinido. Si un programa contiene más de un autómata, los demás deben mencionarse explícitamente, tanto en el clasificador de estado de la función como en la instrucción de estado. Para ello, añada el nombre del autómata delante del nombre del estado y separe los nombres del autómata y del estado con dos puntos. Es decir, `parser:slash` significa el estado slash del autómata parser. Una función sólo puede formar parte de un único autómata; puedes compartir una implementación de una función para varios estados del mismo autómata, pero no puedes compartir esa función para estados de autómatas diferentes.

## Funciones de entrada y teoría de autómatas
Las máquinas de estados, y la base de la “teoría de los autómatas”, se originan en el diseño mecánico y en los circuitos de conmutación neumáticos/eléctricos (usando relés en lugar de transistores). Los ejemplos típicos son los aceptadores de monedas, el control de semáforos y los circuitos de conmutación de comunicaciones. En estas aplicaciones, la solidez y la previsibilidad son primordiales, y se descubrió que estos objetivos se lograban mejor cuando las acciones (salida) estaban vinculadas a los estados en lugar de a los eventos (entrada).
En este diseño, entrar en un estado (opcionalmente) provoca actividad; los eventos provocan cambios de estado, pero no realizan otras operaciones.

![Semaforo](https://i.ibb.co/PYnBGS9/image.png)

En un semáforo, las luces de los vehículos y las de los peatones deben estar sincronizadas. Obviamente, la combinación de una luz verde para el tráfico y una señal de "caminar" para los peatones es una receta para el desastre. También podemos descartar inmediatamente la combinación de amarillo/caminar como demasiado
peligrosa. Así, quedan cuatro combinaciones por manejar. La siguiente figura es un
diagrama de estado para las luces de cruce de peatones. Todo el proceso se activa con un botón y funciona con un temporizador.

![Diagrama de estado para el ejemplo del semaforo](https://i.ibb.co/9wNR3ry/image.png)

Cuando el estado rojo/caminar se agota, el estado no puede volver inmediatamente a verde/esperar, porque los peatones que están ocupados cruzando la calle en
ese momento necesitan algo de tiempo para despejar la calle; el estado rojo/esperar lo permite.

A modo de demostración, este paso de peatones tiene la funcionalidad añadida de que cuando un peatón pulsa el botón mientras el semáforo ya está en rojo, se alarga el tiempo que tiene para cruzar. Si el estado es rojo/esperar y se presiona el botón, vuelve a cambiar a rojo/caminar. El cuadro envolvente alrededor de los estados rojo/caminar y rojo/esperar para manejar el evento del botón es solo una conveniencia notacional: también podría haber
dibujado dos flechas desde cualquier estado de vuelta a rojo/caminar. Sin embargo, el código fuente del script
(que sigue a continuación) refleja esta misma comodidad de notación.

En la implementación en el lenguaje PAWN, las funciones de evento ahora siempre tienen una sola declaración, que es un cambio de estado o una declaración vacía. Los eventos que no provocan un cambio de estado están ausentes en el diagrama, pero deben manejarse en el script; por tanto, las funciones de evento en caso de fallo/caída (*fallback*) que no hacen nada.

La salida, en este programa de ejemplo solo los mensajes impresos en la consola, se realiza en la entrada de funciones especiales. La entrada de la función puede verse como principal para un estado: se llama implícitamente cuando
se ingresa el estado al que está adjunta. Tenga en cuenta que la función de entrada también se llama
cuando se "cambia" al estado en el que ya se encuentra el autómata: cuando el estado es red_walk, una invocación de @keypressed establece el estado en red_walk (en el que ya se encuentra) y provoca la función de entrada. de red_walk para ejecutar —esto es un reingreso al estado.

<sub>DISPONIBLE EN: traffic.p</sub>
```pawn
/* Sincronizador de semáforo, utilizando los estados en un modelo basado en eventos */
#include <time>

main()                                state green_wait

@keypressed(key) <green_wait>         state yellow_wait
@keypressed(key) <red_walk, red_wait> state red_walk
@keypressed(key) <>                   {} /* fallback */

@timer()         <yellow_wait>        state red_walk
@timer()         <red_walk>           state red_wait
@timer()         <red_wait>           state green_wait
@timer()         <>                   {} /* fallback */


entry() <green_wait>
    print "Green / Don't walk\n"

entry() <yellow_wait>
    {
    print "Yellow / Don't walk\n"
    settimer 2000
    }

entry() <red_walk>
    {
    print "Red / Walk\n"
    settimer 5000
    }

entry() <red_wait>
    {
    print "Red / Don't walk\n"
    settimer 2000
    }
```

Este programa de ejemplo tiene una dependencia adicional en la aplicación/entorno del host: además de la función de evento "@keypressed", el host también debe proporcionar un evento "@timer" ajustable. Debido a las funciones de temporización, la secuencia de comandos incluye el archivo de sistema time.inc cerca de la parte superior de la secuencia de comandos.

Las funciones de eventos con los cambios de estado están todas en la parte superior del script. Las funciones están diseñadas para tomar una sola línea cada una, para sugerir una
estructura similar a una tabla. Todos los cambios de estado son incondicionales en este ejemplo, pero los cambios de estado condicionales también se pueden usar con funciones de entrada. La parte inferior son las funciones de eventos.

Existen dos transiciones al estado red_walk —o tres si se considera
la afección de múltiples estados a una sola función de evento como una mera
conveniencia notacional: de yellow_wait y de la combinación de red_walk y red_wait. Todas estas transiciones pasan por la misma función de entrada, lo que reduce y simplifica el código.

En la teoría de los autómatas, un autómata que asocia salida con entradas de estado, como este ejemplo de semáforo peatonal, es un "autómata de Moore"; un autómata que asocia la salida con eventos o transiciones (dependientes del estado) es un “autómata harinoso”. El analizador de comentarios interactivo en la página 40 es un típico autómata de Mealy. Los dos tipos son equivalentes: un autómata de Mealy se puede convertir en un autómata de Moore y viceversa, aunque un autómata de Moore puede necesitar más estados para implementar el mismo comportamiento. En la práctica, los modelos a menudo se mezclan, con un diseño general de "autómata de Moore" y algunos "estados harinosos" en los que eso guarda un estado.

> [Regresar a la página anterior](09-programacion-basada-en-eventos.md) (Programación basada en eventos)
>
> [Ir a la siguiente página](11-verificacion-del-programa.md) (Verificación del programa)
>
> <sub>[Subir al principio de esta página](#una-calculadora-npi-simple)</sub>
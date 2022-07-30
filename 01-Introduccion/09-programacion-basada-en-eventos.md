# Programación basada en eventos
Todos los ejemplo que se han desarrollado en este capítulo hasta ahora, han utilizado un modelo de programación "lineal": comienzan con `main` y el código determina qué hacer y cuándo solicitar la entrada. Este modelo de programación es fácil de entender y se ajusta a la mayoría de los lenguajes de programación, pero también es un modelo que no se ajusta a muchas situaciones de la "vida real". A menudo, un programa no puede limitarse a procesar datos y sugerir al usuario que proporcione la entrada sólo cuando esté preparado para ello. Por el contrario, es el usuario quien decide cuándo proporcionar la entrada, y el programa o script debe estar preparado para procesarla en un tiempo aceptable, independientemente de lo que estuviera haciendo en ese momento.

La descripción anterior sugiere que un programa debería ser capaz de interrumpir su trabajo y hacer otras cosas antes de retomar la tarea original. En las primeras implementaciones, esta era la forma en que se implementaba dicha funcionalidad: un sistema multitarea en el que una tarea (o hilo) gestionaba las tareas de fondo y una segunda tarea/hilo que permanecía en un bucle solicitando continuamente la entrada del usuario. Sin embargo, esta es una solución muy pesada. Una implementación más ligera de un sistema responsivo es lo que se llama el modelo de programación "**dirigido por eventos**" (o simplemente, basada en eventos).

En el modelo de programación dirigido por eventos, un programa o script descompone cualquier tarea larga (de fondo) en bloques cortos y manejables, y en el medio, está disponible para la entrada. Sin embargo, en lugar de hacer que el programa pregunte por la entrada, la aplicación anfitriona (o algún otro subsistema) llama a una función que se adjunta al evento, pero sólo si éste se produce.

Un evento típico es la "entrada". Hay que tener en cuenta que las entradas no sólo proceden de operadores humanos. Los paquetes de entrada pueden llegar a través de cables serie, pilas de red, subsistemas internos como temporizadores y relojes, y todo tipo de equipos que puedas tener conectados a tu sistema. Muchos de los aparatos que producen entrada, simplemente la envían. La llegada de dicha entrada es un evento, al igual que la pulsación de una tecla. Si no capta el evento, algunos de ellos pueden ser almacenados en una
cola interna del sistema, pero una vez que la cola está saturada los eventos simplemente se descartan.

PAWN soporta directamente el modelo basado en eventos, porque admite múltiples puntos de entrada. El único punto de entrada de un programa lineal es `main`; un programa dirigido por eventos tiene un punto de entrada para cada evento que captura. En comparación con el modelo lineal, los programas dirigidos por eventos suelen aparecer "de abajo arriba": en lugar de que su programa llame a la aplicación anfitriona y decida qué hacer a continuación, su programa está siendo llamado desde el exterior y se requiere responder de forma adecuada y rápida.

PAWN no especifica una librería estándar, y por lo tanto no hay garantía de que en una implementación particular, funciones como `printf` y `getvalue` estén disponibles. Aunque se sugiere que cada implementación proporcione una interfaz mínima de consola/terminal con estas funciones, su disponibilidad depende en última instancia de la implementación.
Lo mismo ocurre con las funciones públicas -los puntos de entrada de un script-. Depende de la implementación cuáles funciones públicas soporta una aplicación anfitriona. Por lo tanto, es posible que el script de esta sección no se ejecute en su plataforma (incluso si todos los scripts anteriores han funcionado bien). Las herramientas de la distribución estándar del sistema PAWN soportan todos los scripts desarrollados en este manual, siempre que
su sistema operativo o entorno soporte las funciones estándar de la terminal
como la fijación de la posición del cursor.

## Ejemplo
Un primer lenguaje de programación que se desarrolló exclusivamente para enseñar los conceptos de programación a los niños fue "Logo". Este dialecto de LISP hacía que la programación fuera visual haciendo que un pequeño robot, la "tortuga", se desplazara por el suelo bajo el control de un sencillo programa. Este concepto se copió luego para mover un cursor (normalmente triangular) de la pantalla del ordenador, de nuevo bajo el control de un programa. Una novedad era que la tortuga dejaba un rastro tras de sí, lo que permitía crear dibujos programando adecuadamente la tortuga -desde entonces se conoció como gráficos de tortuga-.

El término "gráficos de tortuga" también se utilizó para dibujar de forma intercalada con las teclas de flecha del teclado y una "tortuga" para la posición actual. Este método de dibujo en el ordenador fue brevemente popular antes de la llegada del ratón.

<sub>DISPONIBLE EN: turtle.p</sub>
```pawn
@keypressed(key)
    {
    /* Obtenga la posición actual */
    new x, y
    wherexy x, y

    /* Determine cómo actualizar la posición actual */
    switch (key)
        {
        case 'u': y--   /* arriba */
        case 'd': y++   /* abajo */
        case 'l': x--   /* izquierda */
        case 'r': x++   /* correcta */
        case '\e': exit /* Escape = Salir */
        }

    /* Ajuste la posición del cursor y dibuja algo */
    moveturtle x, y
    }

moveturtle(x, y)
    {
    gotoxy x, y
    print '*'
    gotoxy x, y
    }
```

El punto de entrada del programa anterior es `@keypressed` -se llama **al pulsar una tecla** (*On a key pressed*, en inglés). Si ejecuta el programa y no presiona ninguna tecla, la función
función `@keypressed` nunca se ejecuta; si escribe diez teclas, `@keypressed` se ejecuta diez veces. Contrasta este comportamiento con el de `main`: la función `main` se ejecuta inmediatamente después de iniciar el script y se ejecuta sólo una vez.

Todavía está permitido añadir una función `main` a un programa dirigido por eventos: la función `main` servirá entonces para una única inicialización. Una simple adición a este ejemplo es añadir una función `main`, con el fin de limpiar la consola/ventana de la terminal al entrar y quizás establecer la posición inicial de la "tortuga" en el centro.

La compatibilidad con las teclas de función y otras teclas especiales (por ejemplo, las teclas de dirección) depende en gran medida del sistema.

Para mantener el programa portátil, he utilizado letras comunes ("u" para arriba, "l" para la izquierda, etc.). Esto no significa, sin embargo, que las teclas especiales estén más allá de las capacidades de PAWN.

En el script de la "tortuga", la tecla "Escape" termina la aplicación del anfitrión a través de la instrucción `exit`. Si es un anfitrión simple, esto funcionará en efecto. Con aplicaciones donde el script es un complemento, o 
que están incrustadas en un dispositivo, el script normalmente no puede terminar la aplicación anfitriona.

## Multiples eventos
Las ventajas del modelo de programación dirigida por eventos, para construir programas reactivos, se hacen evidentes en presencia de múltiples eventos. De hecho, el modelo dirigido por eventos sólo es útil si tienes más de un punto de entrada.

Si tu script sólo maneja un único evento, también podría entrar en un bucle de sondeo para ese único evento. Cuantos más eventos haya que manejar, más difícil será el modelo de programación lineal.
El siguiente script implementa un programa de "chat" básico, utilizando sólo dos eventos: uno para enviar y otro para recibir. El script permite a los usuarios en una red (o quizás a través de otra conexión) intercambiar mensajes de una sola línea.

El script depende de la aplicación anfitriona para proporcionar las funciones nativas y públicas para enviar y recibir "[datagramas]()" y para responder a las teclas que se presionen. 
La forma en que la aplicación anfitriona envía sus mensajes la decidirá ella misma. Las herramientas de la
distribución estándar de PAWN envían los mensajes a través de la red TCP/IP, y permiten un modo de "difusión" para que más de dos personas puedan chatear entre sí.

<sub>DISPONIBLE EN: chat.p</sub>
```pawn
#include <datagram>

@receivestring(const message[], const source[])
    printf "[%s] dice: %s\n", source, message

@keypressed(key)
    {
    static string[100 char]
    static index

    if (key == '\e')
        exit                    /* salir al presionar 'Esc' */

    echo key
    if (key == '\r' || key == '\n' || index char == sizeof string)
        {
        string{index} = '\0'    /* termina la cadena con el terminador cero */
        sendstring string
        index = 0
        string[index] = '\0'
        }
    else
        string{index++} = key
    }

echo(key)
    {
    new string[2 char] = { 0 }
    string{0} = key == '\r' ? '\n' : key
    printf string
    }
```

La parte más importante de script anterior se encarga de reunir las pulsaciones de teclas en una cadena de caracteres y enviar esa cadena después de presionar la tecla "Enter". La tecla "Escape" termina el programa. La función `echo` sirve para dar una respuesta visual de lo que el usuario escribe: construye una cadena terminada en cero a partir de la tecla y la imprime.

A pesar de su simplicidad, este script tiene la interesante propiedad de que no hay un orden fijo o prescrito en el que los mensajes deban ser enviados o recibidos - no hay un esquema de pregunta-respuesta en el que cada host toma su turno para hablar y escuchar. Un nuevo mensaje puede incluso ser recibido mientras el usuario está escribiendo su propio mensaje.

> [Regresar a la página anterior](08-una-calculadora-npi-simple.md) (Una calculadora NPI simple)
>
> [Ir a la siguiente página](10-programacion-por-estados.md) (Programación por estados)
>
> <sub>[Subir al principio de esta página](#programación-basada-en-eventos)</sub>
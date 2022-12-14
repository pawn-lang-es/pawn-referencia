# Guía del lenguaje PAWN

Encontrarás la referencia del lenguaje Pawn oficial traducida al español.
Última actualización: 30 de julio de 2022.

## Índice

 - [Introducción](01-Introduccion/00-introduccion.md)
    - [Expresiones aritméticas](/01-Introduccion/01-expresiones-aritmeticas.md)
    - [Arreglos y constantes](/01-Introduccion/02-arreglos-y-constantes.md)
    - [Usando funciones](/01-Introduccion/03-usando-funciones.md)
    - [Números racionales](/01-Introduccion/04-numeros-racionales.md)
    - [Cadena de caracteres](/01-Introduccion/05-cadena-de-caracteres.md)
    - [Enumeraciones](/01-Introduccion/06-enumeraciones.md)
    - [Operaciones binarias en conjuntos](/01-Introduccion/07-operaciones-binarias-para-manipular-conjuntos.md)
    - [Una calculadora NPI simple](/01-Introduccion/08-una-calculadora-npi-simple.md)
    - [Programación basada en eventos](/01-Introduccion/09-programacion-basada-en-eventos.md)
    - [Programación por estados](/01-Introduccion/10-programacion-por-estados.md)
    - [Verificación del programa](/01-Introduccion/11-verificacion-del-programa.md)
    - [Comentarios para documentación](/01-Introduccion/12-comentarios-para-documentacion.md)
    - [Advertencias y errores](/01-Introduccion/13-advertencias-y-errores.md)
    - [En conclusión](/01-Introduccion/14-en-conclusion.md)   
 - [Datos y declaraciones](/02-Datos%20y%20declaraciones/00-datos-y-declaraciones.md)
    - [Declaración de variables de estado](/02-Datos%20y%20declaraciones/01-declaracion-de-variables-de-estado.md)
    - [Declaración de variables locales estáticas](/02-Datos%20y%20declaraciones/02-declaracion-de-variables-locales-estaticas.md)
    - [Declaración de variables globales estáticas](/02-Datos%20y%20declaraciones/03-declaracion-de-variables-globales-estaticas.md)
    - [Declaración de variables de reserva](/02-Datos%20y%20declaraciones/04-declaracion-de-variables-de-reserva.md)
    - [Declaración de variables públicas](/02-Datos%20y%20declaraciones/05-declaracion-de-variables-publicas.md)
    - [Declaración de variables constantes](/02-Datos%20y%20declaraciones/06-declaracion-de-variables-constantes.md)
    - [Arreglos de una dimensión](/02-Datos%20y%20declaraciones/07-arreglos-de-una-dimension.md)
    - [Inicialización de una variable](/02-Datos%20y%20declaraciones/08-inicializacion-de-una-variable.md)
    - [Inicialización progresiva de un arreglo](/02-Datos%20y%20declaraciones/09-inicializacion-progresiva-de-un-arreglo.md)
    - [Inicialización enumerada de un arreglo](/02-Datos%20y%20declaraciones/10-inicializacion-enumerada-de-un-arreglo.md)
    - [Arreglos de múltiples dimensiones](/02-Datos%20y%20declaraciones/11-arreglos-de-multiples-dimensiones.md)
    - [Arreglos y el operador sizeof](/02-Datos%20y%20declaraciones/12-arreglos-y-el-operador-sizeof.md)
    - [Etiquetas](/02-Datos%20y%20declaraciones/13-etiquetas.md)
 - [Funciones]()
 - [El pre-procesador]()
 - [Sintaxis general]()
 - [Operadores y expresiones]()
 - [Sentencias]()
 - [Directivas]()
 - [Librerías con funciones específicas]()
 - [Puntos débiles: Diferencias con C]()
 - [Consejos assorted]()
 - [Apéndices]()

## Prólogo

PAWN es un lenguaje de "scripting" sencillo, sin tipado y de 32 bits, con una sintaxis similar a la de C. La velocidad de ejecución, la estabilidad, la simplicidad y el tamaño reducido fueron los criterios de diseño esenciales tanto para el lenguaje como para el intérprete/máquina abstracta en la que se ejecuta un programa PAWN.

Una aplicación o herramienta no puede hacer o ser todo para todos los usuarios. Lo anterior no sólo justifica la diversidad de editores, compiladores, sistemas operativos y muchos otros sistemas de software, sino que también explica la presencia de amplias opciones de configuración y lenguajes de macros o scripts en las aplicaciones. Mis propias aplicaciones han contenido una gran variedad de pequeños lenguajes; la mayoría eran muy sencillos, algunos eran extensos. . . y la mayoría de las necesidades podrían haber sido resueltas por un lenguaje de propósito general con una librería de propósito especial. De ahí, PAWN. 

El lenguaje PAWN fue diseñado como un lenguaje flexible para manipular objetos en una aplicación anfitriona. El conjunto de herramientas (compilador, máquina abstracta) fueron escritas de manera que fueran fácilmente extensibles y pudieran funcionar en diferentes arquitecturas de software/hardware.

<details><summary>Ver más...</summary>
<p>
PAWN es un descendiente del Small C original de Ron Cain y
James Hendrix, que a su vez era un subconjunto de C. Algunas de las
modificaciones que hice a Small C, por ejemplo, la eliminación del sistema de tipos
 y la sustitución de punteros por referencias, eran tan
fundamental que difícilmente podría llamar a mi lenguaje un "subconjunto de
C" o un "dialecto de C". Por lo tanto, eliminé el "C"
del título y utilicé el nombre "SMALL" como nombre del
lenguaje en mi publicación en el Dr. Dobb's Journal y en los años
desde entonces. Durante el desarrollo y el mantenimiento del producto, recibí
recibí muchas peticiones de cambios. Uno de los cambios más solicitados fue el de utilizar un nombre diferente - la búsqueda de información sobre el lenguaje de scripting SMALL en
Internet se veía dificultada por el hecho de que "small" fuera una palabra tan común.
El cambio de nombre se produjo junto con un cambio significativo en
el lenguaje: el soporte de "estados" (y máquinas de estado).
Estoy en deuda con Ron Cain y James Hendrix (y más recientemente
Andy Yuen), por su trabajo en Small C y al Dr. Dobb's Journal
por publicarlo. Aunque debo haber tocado casi todas las líneas
del código original varias veces, los orígenes de Small C siguen siendo
claramente visibles.

En el apéndice C hay un informe detallado de los objetivos y compromisos del diseño; aquí me gustaría resumir algunos puntos clave. Como se ha escrito en los párrafos anteriores, PAWN es para personalizar aplicaciones (escribiendo scripts), no para escribir aplicaciones. PAWN
es débil en la estructuración de datos porque los programas de PAWN están pensados para
manipular objetos (texto, sprites, streams, consultas, . . .) en la aplicación
aplicación anfitriona, pero el programa PAWN es, intencionalmente, negado el acceso directo a cualquier dato fuera de su máquina abstracta. El único
medios que un programa PAWN tiene para manipular objetos en la aplicación
es llamando a subrutinas, llamadas "funciones nativas",
que la aplicación anfitriona proporciona.
PAWN es flexible en esa área clave: la llamada a funciones. PAWN soporta valores por defecto para cualquiera de los argumentos de una función, llamada por referencia así como llamada por valor, y argumentos de función "nombrados" así como
argumentos de función "posicionales". PAWN no tiene un mecanismo de "comprobación de tipo
de comprobación de tipos", por ser un lenguaje sin tipos,
pero ofrece en su lugar un mecanismo de "comprobación de clasificación", llamado "etiquetas". El sistema de etiquetas es especialmente conveniente para
argumentos de función porque cada argumento puede especificar múltiples
etiquetas aceptables.
En cualquier lenguaje, el poder (o la debilidad) no reside en las características individuales, sino en su combinación. En el caso de PAWN, creo que
la combinación de argumentos con nombre -que permite especificar
argumentos de la función en cualquier orden, y los valores por defecto -que le permiten omitir la especificación de los argumentos que no le interesan
, se combinan en una forma conveniente y "descriptiva" de llamar
funciones (nativas) para manipular objetos en la aplicación anfitriona
</p>
</details>


"CompuPhase" y "Pawn" son marcas registradas de ITB CompuPhase.
"Java" es una marca registrada de Sun Microsystems, Inc.
"Microsoft" y "Microsoft Windows" es una marca registrada de Microsoft Corporation.
"Linux" es una marca registrada de Linus Torvalds.
"Unicode" es una marca registrada de Unico, Inc.

Copyright (C) 1997-2016, ITB CompuPhase.

Puedes hacer contribuciones por medio de issues o haz directamente una pull request.

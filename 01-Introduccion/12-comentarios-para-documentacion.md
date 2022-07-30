# Comentarios para documentación
Cuando los programas se hacen más grandes, documentar el programa y las funciones se vuelve vital para su mantenimiento, especialmente cuando se trabaja en equipo. Las herramientas del lenguaje de peones tienen algunas características para ayudarle a documentar
el código en los comentarios. Documentar un programa o librería en sus comentarios tiene algunas ventajas -por ejemplo: la documentación se mantiene más fácilmente al día con el programa, es eficiente en el sentido de que los comentarios de programación ahora se duplican como documentación, y el analizador sintáctico ayuda a sus esfuerzos de documentación en la generación de descripciones de sintaxis y referencias cruzadas.

Cada comentario que comienza con tres barras ("/// ") seguidas de un espacio en blanco, o que comienza con una barra y dos estrellas ("/// ") seguidas de un espacio en blanco es un comentario de documentación especial. El compilador de peones extrae los comentarios de documentación y, opcionalmente, los escribe en un archivo "informe". Consulte la documentación de la aplicación, o el apéndice B, para saber cómo activar la generación de informes.

Como nota, los comentarios que comienzan con "/" deben cerrarse con "/". Los comentarios de documentación de una línea ("///") se cierran al final de la línea.

El archivo de informe es un archivo XML que puede transformarse posteriormente en documentación HTML mediante una hoja de estilo XSL/XSLT, o ejecutarse mediante otras herramientas para crear documentación impresa. La sintaxis del archivo de informe es compatible con la de los productos para desarrolladores ".Net", salvo que el compilador de peones almacena en el informe más información que las cadenas de documentación extraídas. El archivo de informe contiene una referencia a la hoja de estilo "smalldoc.xsl".

El ejemplo siguiente ilustra los comentarios de documentación en un script sencillo que tiene unas pocas funciones. Puede escribir comentarios de documentación para una función por encima de su declaración o en su cuerpo. Todos los comentarios de documentación que aparecen antes del final de la función se atribuyen a la función. También puede
También puede añadir comentarios de documentación a las variables globales y a las constantes globales -estos comentarios deben aparecer encima de la declaración de la variable o de la constante. La figura 2 muestra parte de la salida de este ejemplo (bastante largo). El estilo de la salida es ajustable en la hoja de estilo en cascada (archivo CSS) asociada al archivo de transformación XSLT.

> ***Nota importante:*** *A partir de esta unidad, los fragmentos de códigos estarán
> exclusivamente en inglés. Es importante que escribas código en inglés para que
> puedas recibir ayuda de *toda* la comunidad.*

<sub>DISPONIBLE EN: weekday.p</sub>
```pawn
/**
 * This program illustrates Zeller's congruence algorithm to calculate
 * the day of the week given a date.
 */

/**
 *  <summary>
 *    The main program: asks the user to input a date and prints on
 *    what day of the week that date falls.
 *  </summary>
 */
main()
    {
    new day, month, year
    if (readdate(day, month, year))
        {
        new wkday = weekday(day, month, year)
        printf "The date %d-%d-%d falls on a ", day, month, year
        switch (wkday)
            {
            case 0:
                print "Saturday"
            case 1:
                print "Sunday"
            case 2:
                print "Monday"
            case 3:
                print "Tuesday"
            case 4:
                print "Wednesday"
            case 5:
                print "Thursday"
            case 6:
                print "Friday"
            }
        }
    else
        print "Invalid date"

    print "\n"
    }

/**
 * <summary>
 *   The core function of Zeller's congruence algorithm. The function
 *   works for the Gregorian calender.
 * </summary>
 *
 * <param name="day">
 *   The day in the month, a value between 1 and 31.
 * </param>
 * <param name="month">
 *   The month: a value between 1 and 12.
 * </param>
 * <param name="year">
 *   The year in four digits.
 * </param>
 *
 * <returns>
 *   The day of the week, where 0 is Saturday and 6 is Friday.
 * </returns>
 *
 * <remarks>
 *   This function does not check the validity of the date; when the
 *   date in the parameters is invalid, the returned "day of the week"
 *   will hold an incorrect value.
 *   <p/>
 *   This equation fails in many programming languages, notably most
 *   implementations of C, C++ and Pascal, because these languages have
 *   a loosely defined "remainder" operator. Pawn, on the other hand,
 *   provides the true modulus operator, as defined in mathematical
 *   theory and as was intended by Zeller.
 * </remarks>
 */
weekday(day, month, year)
    {
    /**
     * <remarks>
     *   For Zeller's congruence algorithm, the months January and
     *   February are the 13th and 14th month of the <em>preceding</em>
     *   year. The idea is that the "difficult month" February (which
     *   has either 28 or 29 days) is moved to the end of the year.
     * </remarks>
     */
    if (month <= 2)
        month += 12, --year

    new j = year % 100
    new e = year / 100
    return (day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7
    }

/**
 * <summary>
 *   Reads a date and stores it in three separate fields. tata
 * </summary>
 *
 * <param name="day">
 *   Will hold the day number upon return.
 * </param>
 * <param name="month">
 *   Will hold the month number upon return.
 * </param>
 * <param name="year">
 *   Will hold the year number upon return.
 * </param>
 *
 * <returns>
 *   <em>true</em> if the date is valid, <em>false</em> otherwise;
 *   if the function returns <em>false</em>, the values of
 *   <paramref name="day"/>, <paramref name="month"/> and
 *   <paramref name="year"/> cannot be relied upon.
 * </returns>
 */
bool: readdate(&day, &month, &year)
    {
    print "Give a date (dd-mm-yyyy): "
    day = getvalue(_,'-','/')
    month = getvalue(_,'-','/')
    year = getvalue()
    return 1 <= month <= 12 && 1 <= day <= daysinmonth(month,year)
    }

/**
 * <summary>
 *   Returns whether a year is a leap year.
 * </summary>
 *
 * <param name="year">
 *   The year in 4 digits.
 * </param>
 *
 * <remarks>
 *   A year is a leap year:
 *   <ul>
 *     <li> if it is divisable by 4, </li>
 *     <li> but <strong>not</strong> if it is divisable by 100, </li>
 *     <li> but it <strong>is</strong> it is divisable by 400. </li>
 *   </ul>
 * </remarks>
 */
bool: isleapyear(year)
    return year % 400 == 0 || year % 100 != 0 && year % 4 == 0

/**
 * <summary>
 *   Returns the number of days in a month (the month is an integer
 *   in the range 1 .. 12). One needs to pass in the year as well,
 *   because the function takes leap years into account.
 * </summary>
 *
 * <param name="month">
 *   The month number, a value between 1 and 12.
 * </param>
 * <param name="year">
 *   The year in 4 digits.
 * </param>
 */
daysinmonth(month, year)
    {
    static daylist[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    assert 1 <= month <= 12
    return daylist[month-1] + _:(month == 2 && isleapyear(year))
    }
```

![Renderización del archivo XML con información recogida de los comentarios para documentación.](https://i.ibb.co/VmQS0fL/image.png)

El formato del archivo XML creado por los productos de desarrollo ".Net" está
documentado en la documentación de Microsoft. El analizador de peones crea una mini descripción de cada función o variable global o constante que se utiliza
en un proyecto, independientemente de que se hayan utilizado comentarios en la documentación sobre esa función/variable/constante. El analizador sintáctico también genera algunas etiquetas propias:

| Nombre | Información |
| --- | --- |
| attribute | Atributos para una función, tales como "nativa" o "de reserva" (*stock*). |
| automaton | El autómata a la que la función pertenece (si existe). |
| dependency | El nombre de los símbolos (otras funciones, variables globales y variables constantes) que la función requiere. Si es deseado, un árbol de dependencias puede construirse de esta etiqueta. |
| param | Los parámetros de la función. Cuando añades una descripción para un parámetro en un comentario para documentación, esta descripción es combinada con el contenido autogenerado para ese parámetro. |
| paraminfo | Etiquetas y arreglos o información de referencia en un parámetro. |
| referrer | Todas las funciones que refieren a este símbolo; p. ej. todas las funciones que usan o llamada dicha variable/función. Esta información es suficiente para servir como una "referencia mutua" — el árbol "referido" es el inverso al árbol de "dependencias". |
| stacksize | El número estimado de celdas que la función asignará en la pila y el montón. Esta estimación del uso de la pila excluye los requisitos de la pila de cualquier función que sea "llamada" desde la función a la que se aplica la documentación. Por ejemplo, la función readdate está documentada como una función que ocupa 6 celdas en la pila, pero también llama a daysinmonth, que ocupa 4 celdas adicionales, y a su vez llama a isleapyear. Para calcular los requisitos totales de la pila para la función readdate, se debe considerar el árbol de llamadas. Además de las variables locales y los parámetros de la función, el compilador también utiliza la pila para almacenar resultados intermedios en expresiones complejas. El espacio de pila necesario para estos resultados intermedios también se excluye de este informe. En general, la sobrecarga necesaria para los resultados intermedios no es acumulativa (en todas las funciones), por lo que sería inexacto añadir un "margen de seguridad" a cada función. Para el programa en su conjunto, un margen de seguridad sería muy aconsejable. Vea el apéndice B (página 168. para la opción -v que puede decirle el uso máximo estimado de la pila, basado en el árbol de llamadas. |
| tagname | La etiqueta de la constante, variable, resultado de la función o parámetro(s) de la función. |
| transition | Las transiciones que la función provoca y sus condiciones —observa la sección [Programación por estados](10-programacion-por-estados.md). |

Todo el texto de los comentarios de la documentación se copia también en cada
función, variable o constante a la que se adjunta. El texto del comentario de la documentación se copia sin más procesamiento -con una excepción, véase más abajo-. Como el resto del archivo de informe está en formato XML, y la forma más adecuada de procesar XML para la documentación en línea es a través de un procesador XSLT (como un navegador moderno), puede optar por hacer cualquier formato en los comentarios de la documentación utilizando etiquetas HTML. Tenga en cuenta que a menudo tendrá que cerrar explícitamente cualquier etiqueta HTML; el estándar HTML no lo requiere, pero los procesadores XML/XSLT suelen hacerlo. El kit de herramientas de peón viene con un archivo XSLT de ejemplo
(con una hoja de estilo correspondiente) que admite las siguientes etiquetas XML/HTML:

| Nombre | Información |
| --- | --- |
| `<code> </code>` | Código fuente preformado en una fuente monoespacada;Aunque los "&", "<" y ">" deben escribirse como "&", "<" y "&rt"; respectivamente. |
| `<example> </example>` | Texto establecido en el subtitulo "Example". |
| `<param name="..."> </param>` | Una descripción del parámetro, con el nombre del parámetro que aparece dentro de la etiqueta de apertura (la opción "name =") y la descripción del parámetro que lo sigue. |
| `<paramref name="..." />` | Una referencia a un parámetro, con el nombre del parámetro que aparece dentro de la etiqueta de apertura (la opción "name ="). |
| `<remarks> </remarks>` | Texto establecido debajo del subtítulo "Remarks”. |
| `<returns> </returns>` | Texto establecido debajo del subtítulo “Returns”. |
| `<seealso> </seealso>` | Texto establecido debajo del subtítulo “See also”. |
| `<summary> </summary>` | Establece el texto inmediatamente debajo del encabezado del símbolo. |
| `<section> </section>` | Establece el texto en un encabezado.Esto solo debe usarse en la documentación que no se adjunta a una función o una variable. |
| `<subsection> </subsection>` | Establece el texto en un subtarrente.Esto solo debe usarse en la documentación que no se adjunta a una función o una variable. |

Las siguientes etiquetas HTML son soportadas con el propósito general de formatear el texto dentro de las secciones anteriores.

| Nombre | Información |
| --- | --- |
| `<c> </c>` | Text set in a monospaced font. |
| `<em> </em>` | Text set emphasized, usually in italics. |
| `<p> </p>` | Text set in a new paragraph. Instead of wrapping and around every paragraph, inserting as a separator between two paragraphs produces the same effect. |
| `<para> </para>` | An alternative for <p> </p> |
| `<ul> </ul>` | An unordered (bulleted) list. |
| `<ol> </ol>` | An ordered (numbered) list. |
| `<li> </li>` | An item in an ordered or unordered list. |

Como se ha dicho, hay una excepción en el procesamiento de los comentarios de la documentación
: si su comentario de documentación contiene una etiqueta <param ...> (y una </param> que coincida), el analizador sintáctico de peones busca el parámetro y combina su descripción del parámetro con el contenido que ha generado automáticamente.

> [Regresar a la página anterior](11-verificacion-del-programa.md) (Verificación del programa)
>
> [Ir a la siguiente página](13-advertencias-y-errores.md) (Advertencias y errores)
>
> <sub>[Subir al principio de esta página](#comentarios-para-documentación)</sub>
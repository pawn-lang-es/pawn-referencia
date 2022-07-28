/* Cola prioritaria (para cadenas de texto simples) */

enum message
    {
    text[40 char],
    priority
    }

main()
    {
    new msg[message]

    /* Inserte algunos elementos (lea la entrada de la consola) */
    printf "Inserte algunos mensajes y sus prioridades; \
            Termina con un texto vacío\n"
    for ( ;; )
        {
        printf "Mensaje:  "
        getstring .string = msg[text], .maxlength = 40, .pack = true
        if (strlen(msg[text]) == 0)
            break
        printf "Prioridad: "
        msg[priority] = getvalue()
        if (!insert(msg))
            {
            printf "La cola está llena, no se puede insertar más elementos\n"
            break
            }
        }

    /* Ahora imprima los mensajes extraídos de la cola */
    printf "\nContenido de la cola:\n"
    while (extract(msg))
        printf "[%d] %s\n", msg[priority], msg[text]
    }

const queuesize = 10
new queue[queuesize][message]
new queueitems = 0

insert(const item[message])
    {
    /* Compruebe si la cola puede contener un mensaje más */
    if (queueitems == queuesize)
        return false            /* la cola está llena */

    /* Encuentre la posición para insertarlo */
    new pos = queueitems        /* Empiece en la parte inferior */
    while (pos > 0 && item[priority] > queue[pos-1][priority])
        --pos                   /* mayor prioridad: mueve una ranura */

    /* Hacer lugar para el artículo en el lugar de inserción */
    for (new i = queueitems; i > pos; --i)
        queue[i] = queue[i-1]

    /* Agregue el mensaje a la ranura correcta */
    queue[pos] = item
    queueitems++

    return true
    }

extract(item[message])
    {
    /* Compruebe si la cola tiene un mensaje más */
    if (queueitems == 0)
        return false            /* la cola está vacía */

    /* Copie el artículo más alto */
    item = queue[0]
    --queueitems

    /* Mueva la cola una posición hacia arriba */
    for (new i = 0; i < queueitems; ++i)
        queue[i] = queue[i+1]

    return true
    }

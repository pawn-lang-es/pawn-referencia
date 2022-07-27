/* Recuento de palabras: contar palabras en una cadena de caracteres que ingreso el usuario */

main()
    {
    print "Por favor escriba una frase: "
    new string[100]
    getstring string, sizeof string

    new count = 0

    new word[20]
    new index
    for ( ;; )
        {
        word = strtok(string, index)
        if (strlen(word) == 0)
            break
        count++
        printf "Palabra %d: '%s'\n", count, word
        }

    printf "\nNúmero de palabras: %d\n", count
    }

strtok(const string[], &index)
    {
    new length = strlen(string)

    /* Saltar espacio en blanco  */
    while (index < length && string[index] <= ' ')
        index++

    /* Almacene la palabra letra por letra */
    new offset = index                /* Guardar la posición de inicio del token */
    new result[20]                    /* Cadena de caracteres para almacenar la palabra */
    while (index < length
           && string[index] > ' '
           && index - offset < sizeof result - 1)
        {
        result[index - offset] = string[index]
        index++
        }
    result[index - offset] = EOS      /* Terminar la cadena con el terminador cero  */

    return result
    }

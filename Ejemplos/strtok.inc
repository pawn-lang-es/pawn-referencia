/* extrae palabras de un texto (palabras separadas por un espacio en blanco) */
#include <string>

strtok(const string[], &index)
    {
    new length = strlen(string)

    /* saltar espacio en blanco */
    while (index < length && string[index] <= ' ')
        index++

    /* almacena la palabra letra por letra */
    new offset = index     /* guardar la posición de inicio del token */
    new result[20]         /* cadena de caracter para guardar la palabra */
    while (index < length
        && string[index] > ' '
        && index - offset < sizeof result - 1)
            {
            result[index - offset] = string[index]
            index++
            }
    result[index - offset] = EOS /* terminar la cadena con cero */

    return result
    }

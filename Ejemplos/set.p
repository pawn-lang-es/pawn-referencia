/* Establecer operaciones, usando aritmética de bit */

main()
    {
    enum (<<= 1) { A = 1, B, C, D, E, F, G }
    new nextstep[] =
        { C | E,     /* A puedo alcanzar C y E */
          D | E,     /* B  "    "   D y E */
          G,         /* C  "    "   G */
          C | F,     /* D  "    "   C y F */
          0,         /* E  "    "   none */
          0,         /* F  "    "   none */
          E | F,     /* G  "    "   E y F */
        }
    #pragma unused A, B

    print "El punto de partida:"
    new start = clamp( .value = toupper(getchar()) - 'A',
                       .min = 0,
                       .max = sizeof nextstep - 1
                     )

    print "\nEl número de pasos: "
    new steps = getvalue()

    /* make the set */
    new result = findtargets(start, steps, nextstep)
    printf "Los puntos en el rango de %C en %D pasos:", start + 'A', steps
    for (new i = 0; i < sizeof nextstep; i++)
        if (result & 1 << i)
            printf "%c ", i + 'A'
    }

findtargets(start, steps, nextstep[], numpoints = sizeof nextstep)
    {
    new result = 0
    new addedpoints = nextstep[start]
    while (steps-- > 0 && result != addedpoints)
        {
        result = addedpoints
        for (new i = 0; i < numpoints; i++)
            if (result & 1 << i)
                addedpoints |= nextstep[i]
        }
    return result
    }

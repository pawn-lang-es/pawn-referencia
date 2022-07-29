/* Analice los comentarios tipo-C interactivamente, utilizando eventos y una máquina de estado */

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

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

/*
  El máximo común divisor de dos valores,
  usando el algoritmo de Euclide
*/

main()
    {
    print "Digita dos valores\n"
    new a = getvalue()
    new b = getvalue()
    while (a != b)
        if (a > b)
            a = a - b
        else
            b = b - a
    printf "El máximo común divisor es %d\n", a
    }

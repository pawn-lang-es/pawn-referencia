/* Cálculo de números de fibonacci por iteración */

main()
    {
    print "Ingrese un valor: "
    new v = getvalue()
    if (v > 0)
        printf "El valor del número de fibonacci %d es %d\n",
               v, fibonacci(v)
    else
        printf "El número de fibonacci %d no existe\n", v
    }

fibonacci(n)
    {
    assert n > 0

    new a = 0, b = 1
    for (new i = 2; i < n; i++)
        {
        new c = a + b
        a = b
        b = c
        }
    return a + b
    }

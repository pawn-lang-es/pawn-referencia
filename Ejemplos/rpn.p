/* una calculadora NPI simple */
#include strtok
#include stack
#include rpnparse

main()
    {
    print "Escriba una expresión en notación polaca inversa: "
    new string[100]
    getstring string, sizeof string
    rpncalc string
    }

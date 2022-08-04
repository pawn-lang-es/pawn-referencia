# Funciones 

Una **declaración de función** define el nombre de la función y, entre paréntesis, sus parámetros. Una función también puede devolver un valor. Una declaración de función debe aparecer en un nivel global (es decir, fuera de cualquier otra función) y es accesible globalmente.

Si a la declaración de la función le sigue un punto y coma (en lugar de una sentencia), la declaración denota una **declaración adelantada** de la función.

La sentencia `return` establece el resultado de la función. Por ejemplo, la función suma (véase más adelante) tiene como resultado el valor de sus dos argumentos sumados. La sentencia de retorno es opcional para una función, pero no se puede utilizar el valor de una función que no devuelve un valor.

<sub>OBSERVANDO: función suma</sub>
```pawn
suma(a, b)
    return a + b
```

Los argumentos de una función son variables locales (declaradas implícitamente) para esa función. La llamada a la función determina los valores de los argumentos.

Otro ejemplo de una definición completa de una función se observa a continuación: `leapyear` (que devuelve "true" para un año bisiesto y "false" para un año no bisiesto):

<sub>OBSERVANDO: función leapyear</sub>
```pawn
leapyear(y)
return y % 4 == 0 && y % 100 != 0 || y % 400 == 0
```

Los operadores lógicos y aritméticos utilizados en el ejemplo del año bisiesto se tratan en el capítulo [6.2](../06-Operadores%20y%20expresiones/02-aritmetica.md) y [6.5](../06-Operadores%20y%20expresiones/05-relacion.md) Operadores.

Normalmente, una función contiene declaraciones de variables locales y consiste en una sentencia com- pleja. En el siguiente ejemplo, observe la sentencia `assert` para evitar valores negativos para el exponente.

<sub>OBSERVANDO: función exponente (elevar a la potencia)</sub>
```pawn
potencia(base, exponente)
{
    /* retorna la base elevada al exponente */
    assert y >= 0
    new r = 1
    for (new i = 0; i < y; ++i)
        r *= x
    return r
}
```


> [Regresar a la página anterior]() ()
>
> [Ir a la página siguiente]() ()
>
> <sub>[Subir al principio de esta página]()</sub>
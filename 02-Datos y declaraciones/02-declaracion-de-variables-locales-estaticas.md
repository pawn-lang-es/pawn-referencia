# Declaración de variables locales estáticas
Una variable local se destruye cuando la [ejecución]() abandona la sentencia compuesta en la que se creó la variable. Las variables locales de una función
sólo existen durante el tiempo de ejecución de esa función. Cada nueva ejecución de la función crea e inicializa nuevas variables locales. Cuando una variable local es
declarada con la palabra clave `static` en lugar de `new`, la variable sigue existiendo después de la finalización de una función. Esto significa que las variables locales estáticas proporcionan un almacenamiento privado y permanente al que sólo se puede acceder desde una única función (o bloque compuesto). Al igual que las variables globales, las variables locales estáticas sólo pueden inicializarse con expresiones constantes.

> [Regresar a la página anterior]() ()
>
> [Ir a la página siguiente]() ()
>
> <sub>[Subir al principio de esta página]()</sub>
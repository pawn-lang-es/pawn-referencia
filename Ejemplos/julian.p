/* Calcule el número de día juliano desde una fecha, y viceversa */

main()
    {
    new d, m, y, jdn

    print "Dar una cita (dd-mm-yyyy): "
    d = getvalue(_, '-', '/')
    m = getvalue(_, '-', '/')
    y = getvalue()

    jdn = DateToJulian(d, m, y)
    printf("Fecha %d/%d/%d = %d JD\n", d, m, y, jdn)

    print "Dar un número de día juliano: "
    jdn = getvalue()
    JulianToDate jdn, d, m, y
    printf "%d JD = %d/%d/%d\n", jdn, d, m, y
    }

DateToJulian(day, month, year)
    {
    /* El primer año es 1. El año 0 no existe: es 1 aC (o -1) */
    assert year != 0
    if (year < 0)
        year++

    /* Mover enero y febrero hasta el final del año anterior */
    if (month <= 2)
        year--, month += 12
    new jdn = 365*year + year/4 - year/100 + year/400
              + (153*month - 457) / 5
              + day + 1721119
    return jdn
    }

JulianToDate(jdn, &day, &month, &year)
    {
    jdn -= 1721119

    /* año aproximado, luego ajuste en un bucle */
    year = (400 * jdn) / 146097
    while (365*year + year/4 - year/100 + year/400 < jdn)
        year++
    year--

    /* determinar el mes */
    jdn -= 365*year + year/4 - year/100 + year/400
    month = (5*jdn + 457) / 153

    /* determinar el día */
    day = jdn - (153*month - 457) / 5

    /* mover enero y febrero al comienzo del año */
    if (month > 12)
        month -= 12, year++

    /* Ajuste los años negativos (el año 0 debe convertirse en 1 aC, o -1) */
    if (year <= 0)
        year--
    }

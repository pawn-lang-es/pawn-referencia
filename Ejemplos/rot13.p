/* Cifrado simple, usando ROT13 */

main()
    {
    printf "Por favor escriba el texto para cifrar: "

    new str[100]
    getstring str, sizeof str
    rot13 str

    printf "Después de cifrado, el texto es: \"%s\"\n", str
    }

rot13(string[])
    {
    for (new index = 0; string[index]; index++)
        if ('a' <= string[index] <= 'z')
            string[index] = (string[index] - 'a' + 13) % 26 + 'a'
        else if ('A' <= string[index] <= 'Z')
            string[index] = (string[index] - 'A' + 13) % 26 + 'A'
    }

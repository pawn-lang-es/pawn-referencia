/* Parser RPN principal y análisis léxico, parte de la calculadora RPN */
#include <rational>
#include <string>

enum token
    {
              t_type,           /* tipo de operador o token */
    Rational: t_value,          /* valor, si t_type es "número" */
              t_word[20],       /* texto simplemente */
    }

const Number    = '0'
const EndOfExpr = '#'

rpncalc(const string[])
    {
    new index
    new field[token]
    for ( ;; )
        {
        field = gettoken(string, index)
        switch (field[t_type])
            {
            case Number:
                push field[t_value]
            case '+':
                push pop() + pop()
            case '-':
                push - pop() + pop()
            case '*':
                push pop() * pop()
            case '/', ':':
                push 1.0 / pop() * pop()
            case EndOfExpr:
                break   /* exit "for" loop */
            default:
                printf "Unknown operator '%s'\n", field[t_word]
            }
        }
    printf "Result = %r\n", pop()
    if (clearstack())
        print "Stack not empty\n", red
    }

gettoken(const string[], &index)
    {
    /* Primero obtenga la próxima "palabra" de la cadena */
    new word[20]
    word = strtok(string, index)

    /* luego analizarlo */
    new field[token]
    field[t_word] = word
    if (strlen(word) == 0)
        {
        field[t_type] = EndOfExpr /* símbolo especial de "parada" */
        field[t_value] = 0
        }
    else if ('0' <= word[0] <= '9')
        {
        field[t_type] = Number
        field[t_value] = rationalstr(word)
        }
    else
        {
        field[t_type] = word[0]
        field[t_value] = 0
        }

    return field
    }

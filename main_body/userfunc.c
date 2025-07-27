#include "userfunc.h"

#define STR(x) #x

int userfunc(int argc, char *argv[])
{
    // for(int i = 0; i < argc; i++)
    // {
    //     printf("Argument %d: %s\n", i, argv[i]);
    // }
    printf("Hello from userfunc! Called with %d arguments.\n", argc);

    printf("%s\n", STR(0xAA)); // → "hello"

    int aaa = 1;
    if (aaa)
    {
        printf("hello,%d,%d,%d", 123, 123, 123);
    }
    char *str = "hello";

    return EXIT_SUCCESS;  





    
}

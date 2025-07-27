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
    printf("hello");

    return EXIT_SUCCESS;  
    
}

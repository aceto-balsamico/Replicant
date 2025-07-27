#include "userfunc.h"

#define STR(x) #x



int global_var = 42; // Example global variable

int userfunc(int argc, char *argv[])
{
    // for(int i = 0; i < argc; i++)
    // {
    //     printf("Argument %d: %s\n", i, argv[i]);
    // }
    printf("Hello from userfunc! Called with %d arguments.\n", argc);

    printf("%s\n", STR(0xAA));
    printf("hello");
    
    // int* ptr = NULL;
    // printf("%d\n", *ptr); // This will cause a segmentation fault
    return EXIT_SUCCESS;
    
}

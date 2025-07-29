#include "userfunc.h"

#define STR(x) #x



int global_var = 42; // Example global variable



void trigger_start_called() 
{
    printf("Start called triggered.\n");    
}

void printf_hello() 
{
    printf("Hello from printf_hello!\n");
}

int userfunc(int argc, char *argv[])
{
    printf_hello();
    printf_hello();
    trigger_start_called();
    printf_hello();
    printf_hello();
    
    // int* ptr = NULL;
    // printf("%d\n", *ptr); // This will cause a segmentation fault
    return EXIT_SUCCESS;
    
}

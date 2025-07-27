#include "libhead.h"

#ifdef FOOK1
int userfunc(int argc, char *argv[])
{
    printf("Fook1 User Function Called with %d arguments:\n", argc);
    
    CALL_ORIG_FUNC(userfunc, int, -1, int, char**);
    return orig_userfunc(argc, argv);
}
#endif

#ifdef FOOK2
int userfunc(int argc, char *argv[])
{   
    printf("Fook2 User Function Called with %d arguments:\n", argc);
    printf("Global variable value: %d\n", global_var);

    CALL_ORIG_FUNC(userfunc, int, -1, int, char**);
    return orig_userfunc(argc, argv);
}
#endif
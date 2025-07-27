#include "libhead.h"

#ifdef FOOK1
int userfunc(int argc, char *argv[])
{
    printf("Fook1 User Function Called with %d arguments:\n", argc);

    CALL_ORIGINAL_FUNC(userfunc, int, -1, int, char**);
    return ptr_userfunc(argc, argv);
}
#endif

#ifdef FOOK2
int userfunc(int argc, char *argv[])
{
    printf("Fook2 User Function Called with %d arguments:\n", argc);
    LOAD_EXTERN_VAR(global_var, int);
    printf("Global variable value: %d\n", *ptr_global_var);

    CALL_ORIGINAL_FUNC(userfunc, int, -1, int, char**);
    return ptr_userfunc(argc, argv);
}
#endif
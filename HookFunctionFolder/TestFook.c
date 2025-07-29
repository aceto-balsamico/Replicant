#include "libhead.h"


static int start_called = 0; // グローバル変数の初期化

#ifdef HOOK1
int userfunc(int argc, char *argv[])
{
    printf("Hook1 User Function Called with %d arguments:\n", argc);

    CALL_ORIGINAL_FUNC(userfunc, int, -1, int, char**);
    return ptr_userfunc(argc, argv);
}
#endif

#ifdef HOOK2

void trigger_start_called() 
{
    start_called = 1; // グローバル変数を更新
}

void printf_hello() 
{
    DEFINE_SKIP_IF_NOT_STARTED(printf_hello, void, , (void), );
    printf("Hello from printf_hello in Hook2!\n");
}

// int userfunc(int argc, char *argv[])
// {
//     printf("Hook2 User Function Called with %d arguments:\n", argc);
//     LOAD_EXTERN_VAR(global_var, int);
//     printf("Global variable value: %d\n", *ptr_global_var);

//     // CALL_ORIGINAL_FUNC(userfunc, int, -1, int, char**);
//     // return ptr_userfunc(argc, argv);
//     DEFINE_SKIP_IF_NOT_STARTED(userfunc, int, -1, (int, char**), argc, argv);

//     return 0;
// }
#endif
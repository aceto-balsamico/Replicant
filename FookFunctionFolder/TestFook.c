

#include <stdio.h>
#include <dlfcn.h>
#define _GNU_SOURCE


// 戻り値型、関数名、引数型リスト、エラー時リターン値を指定
#define CALL_ORIG_FUNC(funcname, rettype, errval, ...)                  \
    static rettype (*orig_##funcname)(__VA_ARGS__) = NULL;              \
    if (!orig_##funcname)                                               \
    {                                                                   \
        orig_##funcname = (rettype (*)(__VA_ARGS__))dlsym(RTLD_NEXT, #funcname); \
        if (!orig_##funcname)                                           \
        {                                                               \
            fprintf(stderr, "original %s not found!\n", #funcname);     \
            return errval;                                              \
        }                                                               \
    }


int userfunc(int argc, char *argv[])
{
    printf("Fook User Function Called with %d arguments:\n", argc);
    
    CALL_ORIG_FUNC(userfunc, int, -1, int, char**);
    return orig_userfunc(argc, argv);
}
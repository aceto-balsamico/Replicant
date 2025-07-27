#ifndef LIBHEAD_H
#define LIBHEAD_H

#include <stdio.h>
#include <dlfcn.h>
#define _GNU_SOURCE


// 関数名、戻り値型、エラー時リターン値を指定、引数型リスト
#define CALL_ORIG_FUNC(funcname, rettype, errval, ...)                            \
    static rettype (*orig_##funcname)(__VA_ARGS__) = NULL;                        \
    if (!orig_##funcname)                                                         \
    {                                                                             \
        orig_##funcname = (rettype (*)(__VA_ARGS__))dlsym(RTLD_NEXT, #funcname);  \
        if (!orig_##funcname)                                                     \
        {                                                                         \
            fprintf(stderr, "original %s not found!\n", #funcname);               \
            return errval;                                                        \
        }                                                                         \
    }


#endif // LIBHEAD_H
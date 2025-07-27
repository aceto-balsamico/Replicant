#ifndef LIBHEAD_H
#define LIBHEAD_H

#include "userfunc.h"
#include <dlfcn.h>
#define _GNU_SOURCE

/**
 * @brief 関数をFookしたあと、元の関数を呼び出すマクロ。
 *        以降、元関数は `ptr_` プレフィックスが付けて記述する。
 * @param funcname 関数名
 * @param rettype 戻り値型
 * @param errval エラー時リターン値
 * @param ... 引数型リスト
 */
// 
#define CALL_ORIGINAL_FUNC(funcname, rettype, errval, ...)                          \
    static rettype (*ptr_##funcname)(__VA_ARGS__) = NULL;                        \
    if (!ptr_##funcname)                                                         \
    {                                                                               \
        ptr_##funcname = (rettype (*)(__VA_ARGS__))dlsym(RTLD_NEXT, #funcname);  \
        if (!ptr_##funcname)                                                     \
        {                                                                           \
            fprintf(stderr, "original function %s not found!\n", #funcname);        \
            return errval;                                                          \
        }                                                                           \
    }

/**
 * @brief グローバル変数をロードするマクロ。
 *        以降、変数は `ptr_` プレフィックスが付けてポインタとして使用する。
 * @param varname 変数名
 * @param vartype 変数の型
 */
#define LOAD_EXTERN_VAR(varname, vartype)                                          \
    static vartype *ptr_##varname = NULL;                                          \
    if (!ptr_##varname)                                                            \
    {                                                                              \
        ptr_##varname = (vartype *)dlsym(RTLD_DEFAULT, #varname);                  \
        if (!ptr_##varname)                                                        \
        {                                                                          \
            fprintf(stderr, "original variable %s not found\n", #varname);         \
        }                                                                          \
    }


#endif // LIBHEAD_H
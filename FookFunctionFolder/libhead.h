#ifndef LIBHEAD_H
#define LIBHEAD_H

#include "userfunc.h"
#include <dlfcn.h>
#define _GNU_SOURCE

/**
 * @brief 関数をFookしたあと、元の関数を呼び出すマクロ。
 *        元の関数の戻り値には `origin_` プレフィックスが付けて記述する。
 * @param funcname 関数名
 * @param rettype 戻り値型
 * @param errval エラー時リターン値
 * @param ... 引数型リスト
 */
// 
#define CALL_ORIGIN_FUNC(funcname, rettype, errval, ...)                            \
    static rettype (*origin_##funcname)(__VA_ARGS__) = NULL;                        \
    if (!origin_##funcname)                                                         \
    {                                                                               \
        origin_##funcname = (rettype (*)(__VA_ARGS__))dlsym(RTLD_NEXT, #funcname);  \
        if (!origin_##funcname)                                                     \
        {                                                                           \
            fprintf(stderr, "original %s not found!\n", #funcname);                 \
            return errval;                                                          \
        }                                                                           \
    }


#endif // LIBHEAD_H
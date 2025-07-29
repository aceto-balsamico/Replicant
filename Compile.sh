#!/bin/bash

arguments=()
flag_f=false
flag_success=false
HOOK_OBJ_FILE="obj/HookFunctionFolder/*"

# エラーメッセージを表示する関数
fail_finish()
{
    if [ $? -ne 0 ]; then
        flag_success=false
    else
        flag_success=true
    fi

    if [ "$flag_success" = false ]; then
        echo -e "\033[31m"
        echo "Make Failed."
        echo -e "\033[0m"
        exit 1
    else
        echo -e "\033[32mMake Succeeded."
        echo -e "\033[0m"
    fi
}

# 引数に-fが含まれているかチェック
for arg in "$@"; do
    if [ "$arg" = "-f" ]; then
        flag_f=true
    else
        arguments+=("$arg")
    fi
done

# 引数が空ではなかったら、引数を表示
if [ "${arguments[*]}" != "" ]; then
    echo "Compiling with arguments: ${arguments[*]}"
fi

# 実行ファイルか動的ライブラリをビルド
if [ "$flag_f" = true ]; then
    echo -e "\033[33mBuilding Dynamic Library\033[0m"
    if [[ "${arguments[*]}" != *-D* ]]; then
        echo "MACRO is not found"
    fi
    rm $HOOK_OBJ_FILE
    make lib SHELL_ARGS="${arguments[*]}"
    fail_finish
else
    echo -e "\033[33mBuilding Executable File\033[0m"
    make SHELL_ARGS="${arguments[*]}"
    fail_finish
fi

echo -e "\033[34mAll Compilation Succeeded."
echo -e "\033[0m"


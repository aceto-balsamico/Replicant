#!/bin/bash

TARGET_EXE="MainExe"
HOOK_LIB="libuserlib.so"
DIR="bin"
flag_fook=false
arguments=()

# 引数に-fが含まれているかチェック
for arg in "$@"; do
    if [ "$arg" == "-f" ]; then
        flag_fook=true
    else
        arguments+=("$arg")
    fi
done

# プログラムの実行
if [ "$flag_fook" == true ]; then
    if [ ! -f "$DIR/$HOOK_LIB" ]; then
        echo "Hook library not found: $DIR/$HOOK_LIB"
        exit 1
    fi
    LD_PRELOAD="$DIR/$HOOK_LIB" "$DIR/$TARGET_EXE" "${arguments[@]}"
    # echo "$PASS" | sudo -S env LD_PRELOAD="$DIR/$HOOK_LIB" "$DIR/$TARGET_EXE" "${arguments[@]}"
else
    "$DIR/$TARGET_EXE" "${arguments[@]}"
fi
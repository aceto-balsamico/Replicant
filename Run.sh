#!/bin/bash

TARGET_EXE="MainExe"
FOOK_LIB="libuserlib.so"
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
    if [ ! -f "$DIR/$FOOK_LIB" ]; then
        echo "Fook library not found: $DIR/$FOOK_LIB"
        exit 1
    fi
    LD_PRELOAD="$DIR/$FOOK_LIB" "$DIR/$TARGET_EXE" "${arguments[@]}"
else
    "$DIR/$TARGET_EXE" "${arguments[@]}"
fi
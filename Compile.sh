#!/bin/bash

# シェルの引数を格納
arguments=()
for arg in "$@"; do
    arguments+=("$arg")
done

if [ ${#arguments[@]} -eq 0 ]; then
    make
    make lib
else
    echo "Compiling with arguments: ${arguments[@]}"
    make SHELL_ARGS="${arguments[@]}"
    make lib
fi


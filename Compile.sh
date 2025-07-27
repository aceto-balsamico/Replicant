#!/bin/bash

# シェルの引数を格納
arguments=()
for arg in "$@"; do
    arguments+=("$arg")
done

flag_success=false

fail_finish()
{
    if [ $? -ne 0 ]; then
        flag_success=false
    else
        flag_success=true
    fi

    if [ "$flag_success" = false ]; then
        echo -e "\033[31m"
        echo "make failed."
        echo -e "\033[0m"
        exit 1
    else
        echo -e "\033[32mmake succeeded."
        echo -e "\033[0m"
    fi
}

if [ ${#arguments[@]} -eq 0 ]; then
    make
    fail_finish

    make lib
    fail_finish
else
    echo "Compiling with arguments: ${arguments[@]}"
    make SHELL_ARGS="${arguments[@]}"
    fail_finish

    make lib
    fail_finish
fi

echo -e "\033[34mAll Compilation succeeded."
echo -e "\033[0m"


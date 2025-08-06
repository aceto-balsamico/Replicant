#include "userfunc.h"

#define STR(x) #x

int global_var = 42; // Example global variable

void trigger_start_called() { printf("Start called triggered.\n"); }

void printf_hello() { printf("Hello from printf_hello!\n"); }

int userfunc(int argc, char* argv[])
{
    printf_hello();
    printf_hello();
    trigger_start_called();
    printf_hello();
    printf_hello();

    HashTable* ht = MakeHashTable();

    AppendElement(ht, "apple", TAG0);
    AppendElement(ht, "banana", TAG1);
    AppendElement(ht, "apple", TAG2);
    AppendElement(ht, "apple", TAG0);
    AppendElement(ht, "cherry", TAG3);
    AppendElement(ht, "banana", TAG1);
    AppendElement(ht, "apple", TAG2);

    PrintHashTable(ht);
    FreeHashTable(ht);

    return EXIT_SUCCESS;
}

#pragma once
#include "common.h"

// #define N_TAG 4
#define TABLE_SIZE 101

// 列挙子と文字列を一括管理するXマクロテクニック

#define TAG_LIST \
    X(TAG0)      \
    X(TAG1)      \
    X(TAG2)      \
    X(TAG3)

// enum定義
typedef enum e_tag
{
#define X(name) name,
    TAG_LIST
#undef X
	N_TAG
} e_Tag;

// 文字列配列定義
const char* TagNames[] = {
#define X(name) #name,
    TAG_LIST
#undef X
};

// エントリ構造体（Chain要素）
typedef struct Entry
{
    char*	  key;		 // 文字列（動的確保）
    int		  counts[N_TAG]; // タグごとのカウント
    struct Entry* next;		 // チェイン
} Entry;

// HashTable本体
typedef struct
{
    Entry* buckets[TABLE_SIZE];
} HashTable;
// ---------- 出力用ソートのための一時構造体 ----------
typedef struct
{
    const char* key;
    int		counts[N_TAG];
} SortedEntry;

extern int  global_var;
extern void trigger_start_called();
extern void printf_hello();

extern unsigned int hash(const char* str);
extern HashTable*   MakeHashTable(void);
extern void	    QuickSort(SortedEntry* arr, int left, int right);
extern void	    AppendElement(HashTable* ht, const char* key, int tag);
extern void	    PrintHashTable(HashTable* ht);
extern void	    FreeHashTable(HashTable* ht);
#include "userfunc.h"



// ---------- ハッシュ関数 ----------
unsigned int hash(const char *str) {
    unsigned int h = 5381;
    while (*str)
        h = ((h << 5) + h) + (unsigned char)(*str++);
    return h % TABLE_SIZE;
}

// ---------- ハッシュテーブル生成 ----------
HashTable *MakeHashTable(void) {
    HashTable *ht = malloc(sizeof(HashTable));
    if (!ht) return NULL;
    for (int i = 0; i < TABLE_SIZE; i++)
        ht->buckets[i] = NULL;
    return ht;
}

// ---------- 要素追加（文字列 + タグ） ----------
void AppendElement(HashTable *ht, const char *key, int tag) {
    if (tag < 0 || tag >= N_TAG) return;

    unsigned int h = hash(key);
    Entry *curr = ht->buckets[h];

    while (curr) {
        if (strcmp(curr->key, key) == 0) {
            curr->counts[tag]++;
            return;
        }
        curr = curr->next;
    }

    // 新規エントリを追加
    Entry *new_entry = malloc(sizeof(Entry));
    new_entry->key = strdup(key);
    for (int i = 0; i < N_TAG; i++)
        new_entry->counts[i] = 0;
    new_entry->counts[tag] = 1;
    new_entry->next = ht->buckets[h];
    ht->buckets[h] = new_entry;
}

void QuickSort(SortedEntry *arr, int left, int right) {
    if (left >= right) return;

    // ピボットは中央
    SortedEntry pivot = arr[(left + right) / 2];
    int i = left;
    int j = right;

    while (i <= j) {
        while (strcmp(arr[i].key, pivot.key) < 0) i++;
        while (strcmp(arr[j].key, pivot.key) > 0) j--;
        if (i <= j) {
            // swap arr[i] <-> arr[j]
            SortedEntry temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i++;
            j--;
        }
    }

    QuickSort(arr, left, j);
    QuickSort(arr, i, right);
}

void PrintHashTable(HashTable *ht) {
    int count = 0;
    for (int i = 0; i < TABLE_SIZE; i++) {
        Entry *curr = ht->buckets[i];
        while (curr) {
            count++;
            curr = curr->next;
        }
    }

    SortedEntry *entries = malloc(sizeof(SortedEntry) * count);
    int idx = 0;
    for (int i = 0; i < TABLE_SIZE; i++) {
        Entry *curr = ht->buckets[i];
        while (curr) {
            entries[idx].key = curr->key;
            for (int j = 0; j < N_TAG; j++)
                entries[idx].counts[j] = curr->counts[j];
            idx++;
            curr = curr->next;
        }
    }

    // 自前QuickSortでソート
    QuickSort(entries, 0, count - 1);
    
    const char *tag_names[N_TAG] = { "TAG0", "TAG1", "TAG2", "TAG3" };
    // 出力
    printf("%-20s", "Key");
    for (int i = 0; i < N_TAG; i++)
        printf("%8s", tag_names[i]);
    printf("\n");

    for (int i = 0; i < count; i++) {
        printf("%-20s", entries[i].key);
        for (int j = 0; j < N_TAG; j++)
            printf("%8d", entries[i].counts[j]);
        printf("\n");
    }

    free(entries);
}

// ---------- 後始末 ----------
void FreeHashTable(HashTable *ht) {
    for (int i = 0; i < TABLE_SIZE; i++) {
        Entry *curr = ht->buckets[i];
        while (curr) {
            Entry *tmp = curr;
            curr = curr->next;
            free(tmp->key);
            free(tmp);
        }
    }
    free(ht);
}

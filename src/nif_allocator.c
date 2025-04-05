#include "nif_allocator.h"
#include "erl_nif.h"
#include <string.h>

void* nif_alloc(size_t size) {
    return enif_alloc(size);
}

void* nif_calloc(size_t num, size_t size) {
    size_t total_size = num * size;
    void* ptr = enif_alloc(total_size);
    if (ptr) {
        memset(ptr, 0, total_size);
    }
    return ptr;
}

void* nif_realloc(void* ptr, size_t new_size) {
    return enif_realloc(ptr, new_size);
}

void nif_free(void* ptr) {
    enif_free(ptr);
}

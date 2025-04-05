#ifndef NIF_ALLOCATOR_H
#define NIF_ALLOCATOR_H

#include <stddef.h>

void* nif_alloc(size_t size);
void* nif_calloc(size_t num, size_t size);
void* nif_realloc(void* ptr, size_t new_size);
void nif_free(void* ptr);

#endif // NIF_ALLOCATOR_H

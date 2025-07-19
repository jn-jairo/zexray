#ifndef NIF_ALLOCATOR_H
#define NIF_ALLOCATOR_H

#include <stddef.h>

extern void* nif_alloc(size_t size);
extern void* nif_calloc(size_t num, size_t size);
extern void* nif_realloc(void* ptr, size_t new_size);
extern void nif_free(void* ptr);

#endif // NIF_ALLOCATOR_H

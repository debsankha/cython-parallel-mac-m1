from cython.parallel import prange, threadid
from libc.stdio cimport printf

cdef bint isprime(unsigned long x):
    cdef bint res
    cdef unsigned long y
    cdef int tid
    for y in prange(2, x, num_threads=8, nogil=True):
        if x % y == 0:
            res = False
            break
    else:
        res = True
    return res


def py_isprime(unsigned long x):
    return isprime(x)


def func(double[:] x, double alpha):
    cdef Py_ssize_t i
    with nogil:
        for i in prange(x.shape[0]):
            x[i] = alpha * x[i]
    return x

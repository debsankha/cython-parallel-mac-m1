from cython.parallel import prange

def isprime_parallel(unsigned long x):
    cdef bint res
    cdef unsigned long y
    cdef int tid
    for y in prange(2, x, nogil=True):
        if x % y == 0:
            res = False
            break
    else:
        res = True
    return res


def isprime_serial(unsigned long x):
    cdef bint res
    cdef unsigned long y
    cdef int tid
    for y in range(2, x):
        if x % y == 0:
            res = False
            break
    else:
        res = True
    return res



def func(double[:] x, double alpha):
    cdef Py_ssize_t i
    with nogil:
        for i in prange(x.shape[0]):
            x[i] = alpha * x[i]
    return x

cpdef foo(double x):
    return bar(x) + 1

cdef bar(double x):
    return 2*x

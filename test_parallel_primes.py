from time import time
import test_prange


x = 63018038201

tick = time()
test_prange.isprime_parallel(x)
dt_parallel = time() - tick


tick = time()
test_prange.isprime_serial(x)
dt_serial = time() - tick


print(f"time for parallel: {dt_parallel:.3f} s, time for serial: {dt_serial:.3f}s")

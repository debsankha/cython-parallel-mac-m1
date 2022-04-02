# cython-parallel-mac-m1
MWE of parallel cython code running on m1 macs

## Steps to reproduce

1. Install llvm through homebrew. The bundled llvm does not support openmpi
    ```bash
    brew install llvm open-mpi libomp
    ```
    Brew will tell you which env vars you need to set in order to use the new llvm.
2. Figure out which include paths and library paths we need by running
    ```bash
    mpicc -showme
    ```
3. Set environment variables following the console outputs from step 1 and 2. Here's what works for me:
    ```bash
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib $LDFLAGS"
    export LDFLAGS="-L/opt/homebrew/Cellar/open-mpi/4.1.2/lib -L/opt/homebrew/opt/libevent/lib -L/opt/homebrew/opt/llvm/lib -L /opt/homebrew/Cellar/libomp/14.0.0/lib $LDFLAGS"
    export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/Cellar/open-mpi/4.1.2/include $CPPFLAGS"
    export CFLAGS="$CPPFLAGS"
    export LIBRARY_PATH=/opt/homebrew/Cellar/open-mpi/4.1.2/lib:/opt/homebrew/opt/libevent/lib
    export CPATH=/opt/homebrew/Cellar/open-mpi/4.1.2/include
    ```
4. Install the package
    ```bash
    python setup.py build_ext --inplace
    ```
5. Run parallelized sample code: `python test_parallel_primes.py`

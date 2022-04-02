from distutils.core import setup
from Cython.Build import cythonize
from setuptools import Extension
import glob

ext_modules = []

for pyxfile in glob.glob("./*.pyx"):
    pyxfile_basename = pyxfile[2:-4]
    ext_modules.append(
        Extension(
            pyxfile_basename,
            [pyxfile],
#            extra_compile_args=['-v', '-lmpi'],
            extra_compile_args=['-fopenmp'],
            extra_link_args=['-lmpi', '-lomp'],
        )
    )


setup(
    #ext_modules = [cythonize(f) for f in glob.glob("./*.pyx")]
    ext_modules = cythonize(ext_modules),
)

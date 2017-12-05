#!/bin/bash

# build the original fortran source to modules
# this is a pretty ugly way of doing it, but it works
# we've hardcoded the source files in an order that satisfies dependencies
# ideally we'd use a proper build system (ninja, make)
# but hopefully we don't touch the actual remapping core
files="MOM_error_handler.F90 MOM6/src/ALE/polynomial_functions.F90 MOM6/src/ALE/regrid_solvers.F90  MOM6/src/ALE/regrid_edge_values.F90 MOM6/src/ALE/PPM_functions.F90 MOM6/src/ALE/PLM_functions.F90 MOM6/src/ALE/PCM_functions.F90"
fflags="-fdefault-real-8 -ffree-line-length-none -O3"
fflags=""
fflags="-fcray-pointer -fdefault-double-8 -fdefault-real-8 -Waliasing -ffree-line-length-none -O3 -fPIC"
gfortran ${fflags} -I. -c ${files}

# build the interface
f2py --f90flags="${fflags}" -c -m ppm_mom6 ppm_driver.F90 *.o

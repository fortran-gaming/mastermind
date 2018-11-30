if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  list(APPEND FFLAGS -march=native -Wall -Wextra -Wpedantic  #-Warray-temporaries
  -Werror=array-bounds -fimplicit-none)
  
  list(APPEND FFLAGS -fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow
  -finit-real=nan -Wconversion)
  
  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8)
    list(APPEND FFLAGS -std=f2018)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  list(APPEND FFLAGS -warn -fpe0 -traceback -debug extended -check all)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)

elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang)
  list(APPEND FFLAGS -Mallocatable=03)
  list(APPEND FLIBS -static-flang-libs)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL NAG)
  list(APPEND FFLAGS -f2008 -C -colour -gline -nan -info -u)
endif()


include(CheckFortranSourceCompiles)

check_fortran_source_compiles("
module b
interface
module subroutine d
end subroutine d
end interface
end

submodule (b) c
contains
module procedure d
end
end

program a
end"
  f08submod SRC_EXT f90)
  
if(NOT f08submod)
  message(FATAL_ERROR "Fortran 2008 submodule support required, and " ${CMAKE_Fortran_COMPILER_ID} " " ${CMAKE_Fortran_COMPILER_VERSION} " does not ssem to support.")
endif()

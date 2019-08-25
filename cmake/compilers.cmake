if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  add_compile_options(-march=native -Wall -Wextra -Wpedantic -Werror=array-bounds -fimplicit-none)
  #-Warray-temporaries

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    add_compile_options(-fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow
    -finit-real=nan -Wconversion)
  endif()

  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8)
    add_compile_options(-std=f2018)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  if(WIN32)
    add_compile_options(/W1 /warn:declarations /stand:f18)
  else()
    add_compile_options(-W1 -warn declarations -stand f18)
  endif()

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    add_compile_options(-fpe0 -traceback -debug extended -check all)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)
  add_compile_options(-C -Mdclchk)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang)
  add_compile_options(-W)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL NAG)
  add_compile_options(-f2008 -C -colour -gline -nan -info -u)
endif()

include(CheckFortranSourceCompiles)

check_fortran_source_compiles("call random_init(.false., .false.); end"
  f18random SRC_EXT f90)

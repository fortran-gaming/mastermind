if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  list(APPEND FFLAGS -std=f2018 -march=native -Wall -Wextra -Wpedantic  #-Warray-temporaries
  -Werror=array-bounds -fimplicit-none)

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    list(APPEND FFLAGS -fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow
    -finit-real=nan -Wconversion)
  endif()

  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8)
    list(APPEND FFLAGS -std=f2018)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  if(WIN32)
    list(APPEND FFLAGS /W1 /4Yd /stand:f18)
  else()
    list(APPEND FFLAGS -W1 -implicitnone -stand f18)
  endif()

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    list(APPEND FFLAGS -fpe0 -traceback -debug extended -check all)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)

elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang)

elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL NAG)
  list(APPEND FFLAGS -f2008 -C -colour -gline -nan -info -u)
endif()

include(CheckFortranSourceCompiles)

check_fortran_source_compiles("call random_init(.false., .false.); end"
  f18random SRC_EXT f90)
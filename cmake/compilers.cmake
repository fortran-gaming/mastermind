if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native -Wall -Wextra -Werror=array-bounds -fimplicit-none)

  string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow -finit-real=nan -Wconversion")

  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8)
    add_compile_options(-std=f2018)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(WIN32)
    add_compile_options(/W1 /warn:declarations /stand:f18)
  else()
    add_compile_options(-W1 -warn declarations -stand f18)
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fpe0 -traceback -debug extended -check all")
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  add_compile_options(-C -Mdclchk)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)
  add_compile_options(-W)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  add_compile_options(-f2008 -C -colour -gline -nan -info -u)
endif()

include(CheckFortranSourceCompiles)

check_fortran_source_compiles("call random_init(.false., .false.); end"
  f18random SRC_EXT f90)

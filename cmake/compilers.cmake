include(CheckFortranCompilerFlag)

set(CMAKE_EXPORT_COMPILE_COMMANDS on)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native -Wall -Wextra -Werror=array-bounds -fimplicit-none)

  string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow -finit-real=nan -Wconversion")

  check_fortran_compiler_flag(-std=f2018 HAS_F2018)
  if(HAS_F2018)
    add_compile_options(-std=f2018)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(WIN32)
    add_compile_options(/warn /stand:f18)
  else()
    add_compile_options(-warn -stand f18)
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fpe0 -traceback -debug extended -check all")
  endif()
endif()

include(CheckFortranSourceCompiles)

check_fortran_source_compiles("call random_init(.false., .false.); end"
  HAS_F2018_RANDOM_INIT SRC_EXT f90)

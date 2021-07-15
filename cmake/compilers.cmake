set(CMAKE_EXPORT_COMPILE_COMMANDS on)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native -Wall -Wextra -Werror=array-bounds -fimplicit-none)

  string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fcheck=all -fexceptions -ffpe-trap=invalid,zero,overflow -finit-real=nan -Wconversion")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  if(WIN32)
    add_compile_options(/warn)
  else()
    add_compile_options(-warn)
    string(APPEND CMAKE_Fortran_FLAGS_DEBUG " -fpe0 -traceback -debug extended -check all")
  endif()
endif()

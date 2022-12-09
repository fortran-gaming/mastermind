if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wall -Wextra -Werror=array-bounds -fimplicit-none
  $<$<CONFIG:Release>:-fno-backtrace>
  "$<$<CONFIG:Debug>:-fcheck=all;-fexceptions;-ffpe-trap=invalid,zero,overflow;-finit-real=nan;-Wconversion>"
  )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(-warn -traceback
  "$<$<CONFIG:Debug>:-fpe0;-debug;-check>"
  )
endif()

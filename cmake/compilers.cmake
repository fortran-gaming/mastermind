if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-fimplicit-none
  $<$<CONFIG:Release>:-fno-backtrace>
  "$<$<CONFIG:Debug>:-Wall;-Wextra;-Werror=array-bounds;-fimplicit-none;-fcheck=all;-fexceptions;-ffpe-trap=invalid,zero,overflow;-finit-real=nan;-Wconversion>"
  )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(-warn
  "$<$<CONFIG:Debug>:-traceback;-fpe0;-debug;-check>"
  )
endif()

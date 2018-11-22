cmake_minimum_required(VERSION 3.7)
project(mastermind Fortran)
enable_testing()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
  endif()
endif()

include(cmake/compilers.cmake)

add_library(game SHARED mm_game.f90 random.f90 rand2003.f90)
target_compile_options(game PRIVATE ${FFLAGS})
target_link_libraries(game PRIVATE ${FLIBS})

add_executable(mastermind mastermind.f90)
target_compile_options(mastermind PRIVATE ${FFLAGS})
target_link_libraries(mastermind game ${FLIBS})

add_executable(compare_test tests/test_compare.f90)
target_compile_options(compare_test PRIVATE ${FFLAGS})
target_link_libraries(compare_test game ${FLIBS})

if(UNIX)
  add_test(NAME Mastermind 
  COMMAND bash -c "./mastermind < ../tests/cmd.log || [[ $? -eq 2 ]] && echo ")
endif()

add_test(NAME compare COMMAND compare_test)

install(TARGETS mastermind
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})

cmake_minimum_required(VERSION 3.7)
project(mastermind Fortran)
enable_testing()

add_library(random random.f90 rand2003.f90)
target_compile_options(random PRIVATE ${FFLAGS})

add_executable(mastermind mastermind.f90)
target_compile_options(mastermind PRIVATE ${FFLAGS})
target_link_libraries(mastermind random)

if(UNIX)
  add_test(NAME Mastermind 
  COMMAND bash -c "mastermind < ../tests/cmd.log || [[ $? -eq 2 ]] && echo ")
endif()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
endif()

install(TARGETS mastermind
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})

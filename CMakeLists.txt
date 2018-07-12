cmake_minimum_required(VERSION 3.7)
project(mastermind Fortran)
enable_testing()

list(APPEND FFLAGS -g -O0)

add_library(random random.f90 rand2003.f90)
target_compile_options(random PRIVATE ${FFLAGS})

add_library(game mm_game.f90)
target_compile_options(game PRIVATE ${FFLAGS})
target_link_libraries(game PRIVATE random)

add_executable(mastermind mastermind.f90)
target_compile_options(mastermind PRIVATE ${FFLAGS})
target_link_libraries(mastermind game)

add_executable(compare_test tests/test_compare.f90)
target_compile_options(compare_test PRIVATE ${FFLAGS})
target_link_libraries(compare_test game)

if(UNIX)
  add_test(NAME Mastermind 
  COMMAND bash -c "mastermind < ../tests/cmd.log || [[ $? -eq 2 ]] && echo ")
endif()

add_test(NAME compare COMMAND compare_test)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
  elseif(WIN32)
    set(CMAKE_INSTALL_PREFIX "$ENV{HOME}" CACHE PATH "..." FORCE)
  endif()
endif()

install(TARGETS mastermind
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})

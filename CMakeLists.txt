cmake_minimum_required(VERSION 3.7)
project(mastermind Fortran)
enable_testing()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
  endif()
endif()

if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_GREATER_EQUAL 8)
    list(APPEND FFLAGS -std=f2018)
  endif()
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)

elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)
  list(APPEND FFLAGS -Mallocatable=03)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang)
  list(APPEND FFLAGS -Mallocatable=03)
  list(APPEND FLIBS -static-flang-libs)
endif()

add_library(random random.f90 rand2003.f90)
target_compile_options(random PRIVATE ${FFLAGS})

add_library(game mm_game.f90)
target_compile_options(game PRIVATE ${FFLAGS})
target_link_libraries(game PRIVATE random)

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

cmake_minimum_required(VERSION 3.7)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(mastermind Fortran)
enable_testing()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
  endif()
endif()

include(cmake/compilers.cmake)

add_subdirectory(src)

add_executable(mastermind src/mastermind.f90)
target_link_libraries(mastermind game ${FLIBS})

add_executable(compare_test tests/test_compare.f90)
target_link_libraries(compare_test game ${FLIBS})
add_test(NAME compare COMMAND compare_test)

if(UNIX)
  add_test(NAME Mastermind
    COMMAND bash -c "$<TARGET_FILE:mastermind> < ${CMAKE_SOURCE_DIR}/tests/cmd.log || [[ $? -eq 2 ]] && echo ")
endif()


install(TARGETS mastermind
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})

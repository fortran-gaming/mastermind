cmake_minimum_required(VERSION 3.13)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(mastermind
LANGUAGES Fortran
VERSION 1.4.0)

include(CTest)

include(cmake/compilers.cmake)

add_executable(mastermind)

add_subdirectory(src)

install(TARGETS mastermind
        RUNTIME DESTINATION bin)

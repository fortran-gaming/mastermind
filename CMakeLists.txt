cmake_minimum_required(VERSION 3.14...3.21)

project(mastermind
LANGUAGES Fortran
VERSION 1.4.0)

include(CTest)

include(cmake/compilers.cmake)

add_executable(mastermind)

add_subdirectory(src)

install(TARGETS mastermind)

cmake_minimum_required(VERSION 3.15...3.21)

project(mastermind
LANGUAGES Fortran
VERSION 1.4.0)

include(CTest)

include(cmake/compilers.cmake)

add_subdirectory(src)

add_executable(mastermind app/mastermind.f90)
target_link_libraries(mastermind PRIVATE game)

install(TARGETS mastermind TYPE RUNTIME)

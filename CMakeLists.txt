cmake_minimum_required(VERSION 3.14...3.26)

project(mastermind
LANGUAGES Fortran
VERSION 1.4.0)

enable_testing()

include(cmake/compilers.cmake)

add_subdirectory(src)

add_executable(mastermind app/mastermind.f90)
target_link_libraries(mastermind PRIVATE game)

install(TARGETS mastermind)

# --- tests

add_executable(compare_test test/test_compare.f90)
target_link_libraries(compare_test PRIVATE game)
add_test(NAME compare COMMAND compare_test)

add_test(NAME Mastermind
COMMAND ${CMAKE_COMMAND}
  -Dexe:FILEPATH=$<TARGET_FILE:mastermind>
  -Din_file:FILEPATH=${PROJECT_SOURCE_DIR}/test/cmd.log
  -P ${PROJECT_SOURCE_DIR}/test/test_mm.cmake)

  file(GENERATE OUTPUT .gitignore CONTENT "*")

add_library(game OBJECT mm_game.f90 random.f90 utils.f90 input.f90 output.f90)
target_include_directories(game INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/include)
set_target_properties(game PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)

# --- tests

if(BUILD_TESTING)

add_executable(compare_test tests/test_compare.f90)
target_link_libraries(compare_test PRIVATE game)
add_test(NAME compare COMMAND $<TARGET_FILE:compare_test>)
set_tests_properties(compare PROPERTIES TIMEOUT 10)

add_test(NAME Mastermind COMMAND ${CMAKE_COMMAND} -Dexe:FILEPATH=$<TARGET_FILE:mastermind> -Din_file:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/tests/cmd.log -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_mm.cmake)
set_tests_properties(Mastermind PROPERTIES TIMEOUT 10)

endif(BUILD_TESTING)

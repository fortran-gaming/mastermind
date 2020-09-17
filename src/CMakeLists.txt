add_library(game OBJECT mm_game.f90 random.f90 utils.f90 input.f90 output.f90)
if(f18random)
  target_sources(game PRIVATE rand2018.f90)
else()
  target_sources(game PRIVATE rand2003.f90)
endif()
target_include_directories(game INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/include)
set_target_properties(game PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)


add_executable(mastermind mastermind.f90)
target_link_libraries(mastermind game)

# --- tests

if(BUILD_TESTING)

add_executable(compare_test tests/test_compare.f90)
target_link_libraries(compare_test PRIVATE game)
add_test(NAME compare COMMAND $<TARGET_FILE:compare_test>)

if(UNIX)
  add_test(NAME Mastermind
    COMMAND bash -c "$<TARGET_FILE:mastermind> < ${CMAKE_CURRENT_SOURCE_DIR}/tests/cmd.log || [[ $? -eq 2 ]] && echo ")
endif()

endif(BUILD_TESTING)

add_library(game OBJECT mm_game.f90 random.f90 utils.f90 input.f90 output.f90)
target_include_directories(game INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/include)
set_target_properties(game PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)

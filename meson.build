project('mastermind', 'fortran')

add_global_arguments('-g', language : 'fortran')

fc = meson.get_compiler('fortran')

if fc.get_id() == 'gcc'
  add_global_arguments('-Wall', '-Wextra', '-Wpedantic', language : 'fortran')
endif

game_lib = static_library('game', ['mm_game.f90', 'random.f90', 'rand2003.f90'])

executable('mastermind', ['mastermind.f90'], link_with : game_lib)

compare_test_exe = executable('compare_test', 'tests/test_compare.f90', link_with : game_lib)

test('compare test', compare_test_exe)


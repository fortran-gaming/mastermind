fc = meson.get_compiler('fortran')

if fc.links('call random_init(.false., .false.); end')
  rsrc = 'rand2018.f90'
else
  rsrc = 'rand2003.f90'
endif
game_lib = library('game',
sources: ['mm_game.f90', 'random.f90', 'utils.f90', 'input.f90', 'output.f90', rsrc])

compare_test_exe = executable('compare_test', 'tests/test_compare.f90', link_with : game_lib)

test('compare test', compare_test_exe)

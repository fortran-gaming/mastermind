game_lib = library('game',
sources: ['mm_game.f90', 'random.f90', 'utils.f90', 'input.f90', 'output.f90'])

compare_test_exe = executable('compare_test', 'tests/test_compare.f90', link_with : game_lib)

test('compare test', compare_test_exe)

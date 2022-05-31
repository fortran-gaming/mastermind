project('mastermind', 'fortran',
meson_version: '>=0.51',
version: '1.4.0')

subdir('src')

executable('mastermind', 'app/mastermind.f90',
link_with : game_lib,
install : true)

compare_test_exe = executable('compare_test', 'test/test_compare.f90',
link_with : game_lib)

test('compare test', compare_test_exe, timeout: 10)

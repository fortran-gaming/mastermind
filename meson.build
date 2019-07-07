project('mastermind', 'fortran',
  default_options: ['default_library=static', 'buildtype=release'],
  meson_version: '>=0.50')

fc = meson.get_compiler('fortran')
fcid = fc.get_id()
if fcid == 'gcc'
  add_global_arguments('-Wall', '-Wextra', '-Wpedantic', '-fimplicit-none', language : 'fortran')
elif fcid == 'pgi'
  add_global_arguments('-C', '-Mdclchk', language: 'fortran')
endif

subdir('src')

executable('mastermind', 'src/mastermind.f90',
  link_with : game_lib,
  install : true)

compare_test_exe = executable('compare_test', 'tests/test_compare.f90', link_with : game_lib)

test('compare test', compare_test_exe)

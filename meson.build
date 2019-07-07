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

if fc.links('call random_init(.false., .false.); end')
  rsrc = 'rand2018.f90'
else
  rsrc = 'rand2003.f90'
endif
game_lib = static_library('game', ['mm_game.f90', 'random.f90', rsrc])

executable('mastermind', 'mastermind.f90',
  link_with : game_lib,
  install : true)

compare_test_exe = executable('compare_test', 'tests/test_compare.f90', link_with : game_lib)

test('compare test', compare_test_exe)

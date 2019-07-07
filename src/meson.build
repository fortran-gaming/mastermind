if fc.links('call random_init(.false., .false.); end')
  rsrc = 'rand2018.f90'
else
  rsrc = 'rand2003.f90'
endif
game_lib = static_library('game', ['mm_game.f90', 'random.f90', rsrc])
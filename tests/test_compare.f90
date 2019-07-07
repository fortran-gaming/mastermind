use mm_game, only: compare, getguess, toupper, getN

implicit none

integer :: N
character, allocatable :: s(:), g(:)
logical, allocatable :: m(:)
integer :: i
logical :: interactive = .false.

N = getN(0)

if (N/=0) then
  interactive = .true.
else
  N = 4
endif

allocate(s(N), g(N), m(N))

if (interactive) then
  print *,'type secret (letters separated by spaces)'
  read *, s
  s = toupper(s)

  i = 0
  do 
    i = i + 1
    g = getguess(i, N)
    m = compare(s, g)  
  end do
endif


s = ['g','y','b','r']
if(.not.all(compare(s,['g','y','b','r']))) error stop 1
if(.not.all(compare(s,['y','g','b','r']) .eqv. [.false.,.false.,.true.,.true.])) error stop 2

end program


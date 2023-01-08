module mm_game

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, stdout=>output_unit, stdin=>input_unit
use utils, only : findfirst

implicit none

interface
module integer function getN(N)
integer, intent(in) :: N
end function getN

module character function getGuess(i, N) result(guess)
integer, intent(in) :: i, N
dimension :: guess(N)
end function getGuess

module subroutine reward(secret, i)
character, intent(in) :: secret(:)
integer, intent(in) :: i
end subroutine reward
end interface

character, parameter :: letters(6) = ['G','Y','B','R','V','S']  ! 6 for PGI, Flang

contains


logical function compare(secret, guess) result(match)

character, intent(in) :: secret(:), guess(:)
dimension :: match(size(secret))

integer :: i, j, n
integer :: c(size(letters))
character :: cmatch(size(secret))
logical :: W(size(secret))

if(.not.(size(secret) == size(guess))) stop 99

 cmatch(:) = '0'
 match(:) = .false.
 c(:) = 0

where (guess == secret)
  cmatch = 'B'
  match = .true.
endwhere

do i=1,size(guess)
  if (match(i)) cycle

  j = findfirst(letters, guess(i))
  if (j==0) cycle

  W = guess(i) == secret .and. .not.match

  ! print *, i,W

!> check if already found enough 'W'
  n = count(W)
  if (c(j) < n) then
    cmatch(i) = 'W'
    c(j) = c(j) + 1
  endif
enddo

print *, cmatch
!! for easy machine parsing

end function compare


impure elemental subroutine getsecret(S)
!! game combination from the game letters
use random, only: randint
character, intent(out) :: S

S = letters(randint(1,size(letters)))

end subroutine getsecret


end module mm_game

!! MasterMind in modern Fortran
!! https://en.wikipedia.org/wiki/Mastermind_%28board_game%29
!!
!! Copyright 2010 Oz Nahum, 2018 Michael Hirsch, Ph.D.
!! GNU Affero GPL v3+ license

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
use mm_game, only: getsecret, getguess, compare, reward, letters, getN
use random, only: rand_init

IMPLICIT NONE

INTEGER :: i
integer:: N, M=10

CHARACTER, allocatable :: secret(:), guess(:)
logical, allocatable :: match(:)

N = getN(4)

if (N < 1 .or. N > 99) error stop  "I need between 1 and 99 letters"

allocate(secret(N), guess(N), match(N))

PRINT *, "Welcome to MasterMind.   Rules:"
print '(A,I2,A)', "I choose a random combination of ",N," colors (letters). "
print '(A,I2,A)', "You have ",M," tries to guess what I chose. "
PRINT *, "The colors possible are: "
PRINT '(20A2)', letters

call rand_init(.false., .false.)

call getsecret(secret)

DO i=1,M
guess = getGuess(i, N)
match = compare(secret, guess)

IF (all(match)) call reward(secret,i)
END DO

print *, "You have reached the maximum allowed tries, you lose"
stop 2

end program

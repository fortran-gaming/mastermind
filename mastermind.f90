!      MasterMind.f90
!      A Small Fortran Program to imitate the game MasterMind
!      For more details see
!      http://en.wikipedia.org/wiki/Mastermind_%28board_game%29
!
!                Copyright 2010 Oz Nahum, 2018 Michael Hirsch, Ph.D.
!
!      This program is free software; you can redistribute it and/or modify
!      it under the terms of the GNU General Public License as posted by
!      the Free Software Foundation; either version 2 of the License, or
!      (at your option) any later version.
!
!      This program is distributed in the hope that it will be useful,
!      but WITHOUT ANY WARRANTY; without even the implied warranty of
!      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!      GNU General Public License for more details.
!
!      You should have received a copy of the GNU General Public License
!      along with this program; if not, write to the Free Software
!      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
!      MA 02110-1301, USA.


PROGRAM MasterMind

  IMPLICIT NONE
  
  INTEGER :: i,j
  REAL :: x
  INTEGER, DIMENSION(50) :: first = (/( 0, i=1,50)/)

  CHARACTER, DIMENSION(4) :: secret,guess
  logical :: match(4) = .false.

  character, parameter :: gameLetters(*) = ['G','Y','B','R','V','S']
  PRINT *, "Welcome to the MasterMind", "Game in Fortran"
          !"*****************************************"
  PRINT *, "*****************************************"
  PRINT *, " Here are the rules: "
  print *, "I choose a random combination of 4 colors out of 6. "
  print *, "You have 10 tries to guess what I chose. "
  PRINT *, " The colors possible are: "
  PRINT *, " Green (G), Yellow (Y),Blue (B), Red (R),   Violet (V), Silver (S) "

  call getsecret(secret)

  DO i=1,10
    call getGuess(guess)
    call compare(secret, guess, match)
    
  
    IF (all(match)) THEN
      print *, "That's right ! ", secret, " after",  i, "rounds !"
      stop
    END IF
  END DO
  
  PRINT *, "You have reached the maximu allowed tries, you lose"

contains


SUBROUTINE compare(secret, guess, match)

character, INTENT(IN) :: secret(:), guess(:)
logical, INTENT(OUT) :: match(:)

INTEGER :: i,j
character :: cmatch(4)

 cmatch = '0'
 match = .false.

!Just for practicing character operations roundPoints is also converted
!to a string
DO i=1,4
  IF (secret(i) == guess(i)) THEN
    cmatch(i)='B'
    cycle
  END IF
  
  where (secret(i) == guess .and. cmatch /= 'B') cmatch = 'W'

END DO

PRINT *, "Your score " , cmatch

where (cmatch=='B') match = .true.
!no need to give any output variable, just print scores to screen
END SUBROUTINE compare


impure elemental subroutine getsecret(secret)
! A subroutine to choose  the game combiantion from the game letters
character, intent(out) :: secret
REAL :: Y

call random_number(y)
  !get numbers from 1 to 6
secret = gameLetters(int(Y*6+1))

END subroutine getsecret


SUBROUTINE getGuess(guess)
  !get user guess
  character,INTENT(OUT) :: guess(:)

  PRINT *, "Type your guess as 4 letters separated by spaces:"

  READ *, guess
  
  guess = toUpper(guess)
END SUBROUTINE getGuess


elemental function toUpper(str)
! can be trivially extended to non-ASCII
  character(*), intent(in) :: str
  character(len(str)) :: toUpper
  character(*), parameter :: lower="abcdefghijklmnopqrstuvwxyz", &
                             upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  integer :: i,j

  toUpper = str

  do i = 1, len(str)
    j = index(lower,str(i:i))
    if (j > 0) toUpper(i:i) = upper(j:j)
  end do

end function toUpper

end program

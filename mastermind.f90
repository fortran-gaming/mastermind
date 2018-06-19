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

module mastermind_game
  use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, stdout=>output_unit
implicit none

private :: toUpper
character, parameter :: letters(*) = ['G','Y','B','R','V','S']

contains


logical function compare(secret, guess) result(match)

character, INTENT(IN) :: secret(:), guess(:)
dimension :: match(size(secret))

INTEGER :: i,j
character :: cmatch(size(secret))

 cmatch = '0'
 match = .false.

!Just for practicing character operations roundPoints is also converted
!to a string
DO i=1,size(secret)
  IF (secret(i) == guess(i)) THEN
    cmatch(i)='B'
    cycle
  END IF
  
  where (secret(i) == guess .and. cmatch /= 'B') cmatch = 'W'

END DO

PRINT '(A,20A1)', "Your score: " , cmatch

where (cmatch=='B') match = .true.
!no need to give any output variable, just print scores to screen
END function compare


impure elemental subroutine getsecret(S)
! game combiantion from the game letters
character, intent(out) :: S
REAL :: y

  !get numbers from 1 to 6
call random_number(y)
S = letters(int(Y*6+1))

end subroutine getsecret


character function getGuess(i, N) result(guess)
  integer, intent(in) :: i, N
  dimension :: guess(N)

  write(stdout,'(A,I2,A,I2,A)', advance='no') 'Round # ',i, ": Type guess as ",N," letters separated by spaces: "

  READ *, guess
  
  guess = toUpper(guess)
end function getGuess


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


subroutine reward(secret, i)
character, intent(in) :: secret(:)
integer, intent(in) :: i

print *,'Correct!   ',secret

select case (i)
  case (1,2)
    print '(A,I2,A)', 'How lucky to guess the answer in ',i,' tries'
  case (3,4) 
    print '(A,I2,A)', 'Excellent strategy, ',i,' is less than the theoretical average minimum tries!'
  case (5) 
    print '(A,I2,A)', 'Great: ',i,' tries is consistent with theoretical minimal tries'
  case (6,7,8)
    print '(A,I2,A)', 'Good work, you can do even better than ',i,' tries'
  case (9,10)
    print '(A,I2,A)', 'More practice will help you get it in fewer than ',i,' tries'
  case default
    write(stderr,*) 'ERROR: impossible number of tries: ',i
    stop 1
end select

stop

end subroutine

end module mastermind_game


PROGRAM MasterMind
  use mastermind_game

  IMPLICIT NONE
  
  INTEGER :: i
  integer:: N=4
  character(2) :: argv

  CHARACTER, allocatable :: secret(:), guess(:)
  logical, allocatable :: match(:)
  
  call get_command_argument(1, argv,status=i)
  if (i==0) read(argv,'(A2)') N
  
  allocate(secret(N), guess(N), match(N))

  PRINT *, "Welcome to the MasterMind", "Game in Fortran"
          !"*****************************************"
  PRINT *, "*****************************************"
  PRINT *, " Here are the rules: "
  print '(A,I2,A)', "I choose a random combination of ",N," colors (letters). "
  print *, "You have 10 tries to guess what I chose. "
  PRINT *, " The colors possible are: "
  PRINT '(20A2)', letters
  
  call getsecret(secret)

  DO i=1,10
    guess = getGuess(i, N)
    match = compare(secret, guess)
    
  
    IF (all(match)) call reward(secret,i)
  END DO
  
  write(stderr,*) "You have reached the maximum allowed tries, you lose"
  stop 1

end program

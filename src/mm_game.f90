module mm_game
  use, intrinsic:: iso_fortran_env, only: stderr=>error_unit, stdout=>output_unit, stdin=>input_unit
implicit none

character, parameter :: letters(6) = ['G','Y','B','R','V','S']  ! 6 for PGI, Flang

contains


logical function compare(secret, guess) result(match)

character, INTENT(IN) :: secret(:), guess(:)
dimension :: match(size(secret))

INTEGER :: i, j, n
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

DO i=1,size(guess)
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

END function compare


pure integer function findfirst(A,x)
!! find first matching index in vector

character,intent(in) :: x, A(:)
integer :: i

do i = 1,size(A)
  if (A(i) == x) then
    findfirst = i
    return
  endif
enddo

findfirst = 0
!! no match found, like Fortran 2008 std.

end function findfirst



impure elemental subroutine getsecret(S)
!! game combination from the game letters
use random, only: randint
character, intent(out) :: S

S = letters(randint(1,size(letters)))

end subroutine getsecret


integer function getN(N)

integer, intent(in) :: N

character(2) :: argv
integer :: i

getN = N

call get_command_argument(1, argv, status=i)

if (i==0) read(argv,'(I2)', iostat=i) getN
!! falls back to default if garbage input

end function getN


character function getGuess(i, N) result(guess)
  integer, intent(in) :: i, N
  dimension :: guess(N)
  integer :: ios


  write(stdout,'(A,I2,A,I2,A)', advance='no') 'Round # ',i, ": Type guess as ",N," letters:  "

  READ(stdin, '(*(A1))', iostat=ios) guess

  if (ios<0) stop  ! Ctrl-D or Ctrl-Z

  guess = toUpper(guess)
end function getGuess


elemental function toUpper(str)
!! can be trivially extended to non-ASCII
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
    print '(A,I2,A)', 'It was ', i,' tries to finish'
end select

stop

end subroutine

end module mm_game

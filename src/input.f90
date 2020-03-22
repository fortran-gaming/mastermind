submodule (mm_game) input

use utils, only : toUpper

implicit none

contains


module procedure getN

character(2) :: argv
integer :: i

getN = N

call get_command_argument(1, argv, status=i)

if (i==0) read(argv,'(I2)', iostat=i) getN
!! falls back to default if garbage input

end procedure getN


module procedure getGuess
integer :: ios

do
write(stdout,'(A,I2,A,I2,A)', advance='no') 'Round # ',i, ": Type guess as ",N," letters without spaces: "

READ(stdin, '(*(A1))', iostat=ios) guess

if (IS_IOSTAT_END(ios)) then
  !! Ctrl-D or Ctrl-Z
  stop 'Goodbye.'
endif
if (all(len_trim(guess) == 1)) exit
end do

guess = toUpper(guess)
end procedure getGuess

end submodule input
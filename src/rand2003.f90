submodule (random) rand

use, intrinsic:: iso_fortran_env, only: stderr=>error_unit

implicit none (type, external)

contains

module procedure rand_init
!! NOTE: this subroutine is replaced by "call random_init()" in Fortran 2018
integer :: i,n, u,ios
integer, allocatable :: seed(:)

character(*), parameter :: randfn = '/dev/urandom'

call random_seed(size=n)
allocate(seed(n))

open(newunit=u, file=randfn, access="stream", form="unformatted", action="read", status="old", iostat=ios)
if (ios==0) then
  read(u,iostat=ios) seed
  close(u)
endif

if (ios/=0) return

call random_seed(put=seed)

end procedure rand_init


end submodule rand

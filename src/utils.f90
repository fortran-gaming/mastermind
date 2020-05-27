module utils

implicit none (type, external)

contains

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

end module utils
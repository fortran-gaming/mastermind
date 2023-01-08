submodule (mm_game) output

implicit none

contains

module procedure reward

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

stop 'Thanks for playing Mastermind'

end procedure reward

end submodule output

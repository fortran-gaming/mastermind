
mastermind: random.f90 rand2003.f90 mastermind.f90
	$(FC) -g $^ -o $@
	
clean: 
	$(RM) mastermind *.o *.mod

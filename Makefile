
mastermind: mastermind.f90
	$(FC) -g $^ -o $@
	
clean: 
	$(RM) mastermind *.o *.mod

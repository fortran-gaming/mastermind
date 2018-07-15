[![Build Status](https://travis-ci.com/fortran-gaming/mastermind.svg?branch=master)](https://travis-ci.com/fortran-gaming/mastermind)

# MasterMind Fortran game

This is the classic [MasterMind game](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29) in modern Fortran.
Some of the other Mastermind Fortran games out there have subtly incorrect game logic, but this one is believed correct.

Tested with Fortran compilers including:

* GNU `gfortran` 5, 6, 7, 8
* Intel `ifort`
* Nvidia `flang`
* PGI `pgf90`


## Install 

Pick one of the following methods.

### Homebrew / Linuxbrew

    brew tap scivision/tap
    
    brew install rpncalc
    
    
### Compile

Using any Fortran 2003+ compiler:

    cmake ..
    
    cmake --build . --target install

## Usage

Simply type

    mastermind
    
You can play with more than 4 letters by specifying at the command line. 
Say you want 8 letters:

    mastermind 8

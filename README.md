[![Build Status](https://travis-ci.com/fortran-gaming/mastermind.svg?branch=master)](https://travis-ci.com/fortran-gaming/mastermind)
[![Build status](https://ci.appveyor.com/api/projects/status/1tqvgjxpsfx6kpd4?svg=true)](https://ci.appveyor.com/project/scivision/mastermind)

# MasterMind Fortran game

This is the classic [MasterMind game](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29) in Fortran.


## Build
Using any Fortran 2003+ compiler (tested with gfortran, ifort, flang, pgf90):

    make
    
## Usage

    ./mastermind
    
You can play with more than 4 letters by specifying at the command line. Say you want 8 letters:

    ./mastermind 8

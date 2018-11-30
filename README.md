[![Build Status](https://travis-ci.com/fortran-gaming/mastermind.svg?branch=master)](https://travis-ci.com/fortran-gaming/mastermind)
[![Build status](https://ci.appveyor.com/api/projects/status/3s4vmat2pkxp9c65?svg=true)](https://ci.appveyor.com/project/scivision/mastermind)

# MasterMind Fortran game

This is the classic 
[MasterMind game](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29) 
in modern Fortran 2008.
Some of the other Mastermind Fortran games out there have subtly incorrect game logic, but this one is believed correct.

Tested with Fortran compilers including:

* GNU `gfortran` 6, 7, 8
* Intel `ifort`
* Nvidia `flang`
* PGI `pgf90`


## Install 

Pick one of the following methods.

   
### Compile

Using any Fortran 2008 compiler supporting `submodule`:
```sh
cmake ..

cmake --build . --target install
```

---

**Flang / PGI only**: there is a bug with PGI 18.10 and Flang 6 that requires manually compiling instead of using CMake:
```sh
flang random.f90 rand2003.f90 mm_game.f90 mastermind.f90 -o mastermind
```


### Homebrew / Linuxbrew

```sh
brew tap scivision/tap

brew install mastermind
 ```   

## Usage

Simply type
```sh
mastermind
```
    
You can play with more than 4 letters by specifying at the command line. 
Say you want 8 letters:
```sh
mastermind 8
```

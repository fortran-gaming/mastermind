[![Build Status](https://travis-ci.com/fortran-gaming/mastermind.svg?branch=master)](https://travis-ci.com/fortran-gaming/mastermind)
[![Build status](https://ci.appveyor.com/api/projects/status/3s4vmat2pkxp9c65?svg=true)](https://ci.appveyor.com/project/scivision/mastermind)

# MasterMind Fortran game

This is the classic
[MasterMind game](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29)
in modern Fortran 2018.
Some of the other Mastermind Fortran games out there have subtly incorrect game logic, but this one is believed correct.

Tested with Fortran compilers including:

* GNU `gfortran`
* Intel `ifort`
* Nvidia `flang`
* PGI `pgfortran`


## Install

Pick one of the following methods.


### Compile

```sh
cmake -B build

cmake --build build --target install
```

OR

```sh
meson build --prefix=~/.local/bin

meson install -C build
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

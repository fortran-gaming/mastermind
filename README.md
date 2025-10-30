# MasterMind Fortran game

[![ci](https://github.com/fortran-gaming/mastermind/actions/workflows/ci_cmake.yml/badge.svg)](https://github.com/fortran-gaming/mastermind/actions/workflows/ci_cmake.yml)

This is the classic
[MasterMind game](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29)
in modern Fortran 2008.
Some of the other Mastermind Fortran games out there have subtly incorrect game logic, but this one is believed correct.

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

`B`
: the correct color is in the right position

`W`
: the color is used, but this guess is in the wrong position

`0`
: this color is not used in the solution anywhere not already `B`

## Install

Pick one of the following methods.

### Compile

```sh
cmake -B build

cmake --build build

# optional
cmake --install build
```

OR

```sh
meson build

meson install -C build
```

### Homebrew / Linuxbrew

```sh
brew tap scivision/tap

brew install mastermind
 ```

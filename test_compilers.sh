#!/bin/bash
# boilerplate to test with popular Fortran compilers, helping check for quirks

set -e

# --- colors https://stackoverflow.com/a/20983251
red=`tput setaf 1`
reset=`tput sgr0`

# --- loops
for comp in gfortran nag ifort flang pgf95
do

(
[[ $comp == ifort ]] && . ~/intel.sh

echo
if $comp --version; then
  echo  
  echo "testing with"
  echo $comp
  echo "press Enter to proceed."
  read
else
  echo
  echo "${red}*** skipping $comp *** ${reset}"
  continue
fi

make clean

FC=$comp make

)
  
done


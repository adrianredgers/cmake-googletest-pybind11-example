#!/usr/bin/env bash

#
# Re-clone Pybind11 and install it under src/main/lib/ (remove any existing copy)
#
git clone git@github.com:pybind/pybind11.git
rm -rf pybind11/.git*
rm -rf src/main/lib/pybind11
mv pybind11 src/main/lib/

#!/usr/bin/env bash

#
# Re-clone googletest and install it under src/test/lib/ (remove any existing copy)
#
git clone git@github.com:google/googletest.git
rm -rf googletest/.git*
rm -rf src/test/lib/googletest
mv googletest src/test/lib/

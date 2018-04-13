#!/usr/bin/env bash

#
# Create build dir and make the targets
#
PYTHON_MODULE=cannopy
rm $PYTHON_DIST_LIB/${PYTHON_MODULE}.so

BUILD_DIR=build
mkdir -p $BUILD_DIR
rm -rf $BUILD_DIR/*
pushd $BUILD_DIR
cmake ..
make
popd



#!/usr/bin/env bash

#
# Create build dir and make the targets
#
PYTHON_MODULE=myfactorial
PYTHON_DIST_DIR=/usr/local/lib/python2.7/dist-packages
rm -f $PYTHON_DIST_DIR/${PYTHON_MODULE}.so
rm -f $PYTHON_DIST_DIR/*.so

BUILD_DIR=build
mkdir -p $BUILD_DIR
rm -rf $BUILD_DIR/*
pushd $BUILD_DIR
cmake ..
make
popd



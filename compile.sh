#!/usr/bin/env bash


export PYTHON_DIST_DIR=/usr/local/lib/python2.7/dist-packages




addpath () {
    if [ $# -ne 2 -a  $# -ne 3 ]
    then
        echo "Usage: addpath <PATH-VARIABLE-NAME> <ADD-THIS-TO-PATH> [after]"
        echo "example:\n  addpath LD_LIBRARY_PATH /usr/bin after\n"
        exit 1
    fi
    path_var_name=$1
    eval path_var=\$$path_var_name
    add_this=$2

    if  ! echo $path_var | /bin/grep -Eq "(^|:)$add_this($|:)"
    then
        if [ "$3" = "after" ]
        then
            path_var=${path_var:+"${path_var}:"}${add_this}
        else
            path_var=${add_this}${path_var:+":${path_var}"}
        fi
    fi
    echo $path_var
}


#
# Idempotently add python distribution dir to library path
#
PYTHON_DIST_DIR=/usr/local/lib/python2.7/dist-packages
export LD_LIBRARY_PATH=`addpath LD_LIBRARY_PATH $PYTHON_DIST_DIR`

#
# Create build dir and make the targets
#
PYTHON_MODULE=myfactorial
rm -f $PYTHON_DIST_DIR/${PYTHON_MODULE}.so
rm -f $PYTHON_DIST_DIR/libFactorialLib.so

BUILD_DIR=build
mkdir -p $BUILD_DIR
rm -rf $BUILD_DIR/*
pushd $BUILD_DIR
cmake ..
make
popd







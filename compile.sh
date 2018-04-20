#!/usr/bin/env bash



addpath () {
    if [ $# -ne 2 -a  $# -ne 3 ]
    then
        echo "Usage: addpath <PATH-VARIABLE-NAME> <ADD-THIS-TO-PATH> [after]"
        echo "example:"
        echo "    LD_LIBRARY_PATH=\`addpath LD_LIBRARY_PATH /usr/bin after\`"
        echo "Adds <ADD-THIS-TO-PATH> to colon-separated <PATH-VARIABLE-NAME> if it's not already in there."
        echo ""
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
# Idempotently add my Python distribution dir to library paths.
# (doesn't work in a shell script - need to do this yourself)
#
MY_PYTHON_DIST_DIR=~
export LD_LIBRARY_PATH=`addpath LD_LIBRARY_PATH $MY_PYTHON_DIST_DIR`
export PYTHONPATH=`addpath PYTHONPATH $MY_PYTHON_DIST_DIR`

#
# Wipe out any existing libs in PYTHON_DIST_DIR
# (keeps last two versions in case of cock-up)
#
keepLastTwo () {
    my_file=$1
    mv ${my_file}_bak ${my_file}_bak_older 2>/dev/null
    mv ${my_file} ${my_file}_bak 2>/dev/null
}

keepLastTwo $MY_PYTHON_DIST_DIR/myfactorial.so
keepLastTwo $MY_PYTHON_DIST_DIR/libFactorialLib.so

#
# Create build dir and make the targets.
#
BUILD_DIR=build
mkdir -p $BUILD_DIR
rm -rf $BUILD_DIR/*
pushd $BUILD_DIR
cmake ..
make

#
# Run unit tests
#
RETVAL=0
for utest in *UnitTests
do
    ./$utest
    RVAL=$?
    RETVAL=`expr $RETVAL + $RVAL`
done

popd

exit $RETVAL


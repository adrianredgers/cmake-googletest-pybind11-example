Example project to import a C++ function googletest-ed  into Python using pybind11:
-
- **Python**
- **Project targets**
- **Project files**
- **in-source** vs **out-of-source**:
- **CLion tips**
- **CMake**
- **Contact**


**Python**

What a palaver! The aim is that you should be able run a `make` script, then start up Python, import a module written
in C++ (and tested with googletest) that has a pybind11 interface, and run a function from that module:
```
$ ./compile.sh
$ ./build/runUnitTests
$ echo $?
0
$ python
Python 2.7.12 (default, Dec  4 2017, 14:50:18) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import myfactorial
>>> myfactorial.fact(5)
120.0
>>> quit()
``` 

**Project targets**
- There are 3 targets, they are created in the directory `build` by the script  `compile.sh`. 
- CLion also builds two of them, kind of (see **Clion tips** below).
- CMake target `FactorialLib` builds the shared library: `libFactorialLib.so` , which is used by tests and the Python module.
- CMake target `myfactorial` builds the Python module (shared library) `myfactorial.so`
    - A custom-command then copies it to your system's Python distribution directory.
    - That dir is something like `/usr/local/lib/python2.7/dist-packages`. 
    - You will need permissions to copy to the dir (I used `sudo chmod a+w`). 
- CMake target `runUnitTests` builds an executable that runs the unit tests.


**Project files**
- `CMakeLists.txt` - top-level CMake file that calls the other 2 CMake files.
- `compile.sh` - creates `build` directory, runs `cmake` and then `make`.
- `src/main`
    - `CMakeLists.txt` - CMake for the main targets: `FactorialLib` and `myfactorial`.
    - `Factorial.cpp Factorial.h` - C++ source of the function that we want to import into Python.
    - `PyModule.cpp` - defines interface to our C++ library `libFactorial.so` ` ` in the Python module `myfactorial.so`.
    - `lib/pybind11` - pybind11 source cloned from: `git@github.com:pybind/pybind11.git`.
        - Delete its .git file, and then rename it if necessary so your git picks it up.
- `src\include`
    - `FactorialLib.h` - library include file used by `PyModule.cpp` and the tests (and any other C++ that wants to use `libFactorialLib.so`).
- `src/test`
    - `CMakeLists.txt` - CMake for test target: `runUnitTests`.
    - `FactorialTest.cpp` - googletests of the `FactorialLib` library.
    - `lib/googletest` - googletest source code.
        - Cloned from: `git@github.com:google/googletest.git`.
- `build` - temporary directory containing targets and artifacts.
    - Auto-generated, not under source code control
    - Regenerated by running `compile.sh`.
- `cmake-build-debug` - another temporary directory.
    - Annoyingly generated by CLion until you set out-of-source dir to `build` (see **CLion tips** below).


**in-source** vs **out-of-source** builds
- An **in-source** build creates build artifacts next to files in the source tree.
- An **out-of-source** build creates build artifacts in a directory (structure) you choose.
- We want to use an **out-of-source** build so we can easily remove and re-generate all build artifacts.
- The script `compile.sh` does this by creating a directory, `cd`-ing to it and running `CMake` and `make` from there.
- By default CLion builds out-of-source in the directory `cmake-build-debug`, but you can change this (see **CLion Tips** below).


**CLion tips:**
- [Don't know why you can't edit any files? CLion uses VIM by default. Get rid of VIM by removing the VIM plugin.]
- Clone this template project from GitHub, then clone it locally:
  - `git clone myFirstClion <new-directory>`.
- Navigate to the new project and open it in CLion:
    - Import sources.
    - Do **not** overwrite `CMakeLists.txt`.
- Note: `Ctrl-Shift-T` does not work for switching to tests.
- Optional, but probably worthwhile, is marking `src` as a source directory:
    - Right-click on project window.
    - Select `Mark directory as > Project Sources and Headers`.
- Optional: set out-of-source build directory in CLion:
    - In `File menu > Settings > Build, Generation, Deployment > CMake`  set the `Generation path:` to `build`.
    - Optional because it means CLion puts all build artifacts in the `build` directory, instead of some of them in `cmake-build-debug`.
- You can always delete `build` and `cmake-build-debug` and regenerate them with a rebuild.
- CLion CMake is lazy - only builds what it uses.
    - So it builds the `FactorialLib` and `runUnitTests` needed to run tests in CLion.
    - But it does not build the Python module target `myfactorial`
    - Hence the need for `compile.sh`


**CMake tips:**
- Set the location of each created target individually with `set_target_properties` as we have, or globally by setting `CMAKE_*_OUTPUT_DIRECTORY*` in a CMakeLists.txt file. 
- Ob. Hack: `pybind11_add_module` has a _feature_ that causes it to look for Python 3.5.
    - So we need to set `PYBIND11_PYTHON_VERSION` before you add the pybind11 sub-directory.
    - Some details of this in `https://github.com/pybind/pybind11/issues/587`.
- Note the use of keywords like `SHARED` and `PRIVATE`.

**Contact me**
- This is my first attempt at a lot of things - CMake, CLion, googletest, python, pybind11, C++, GitHub, README ml, Licences.
- I would be grateful for any suggestions:-
- aredgers@yahoo.com
        


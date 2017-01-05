# cygdb-demo

Example of debugging Cython project


## Install dependencies

Set-up environment, for example using `vagrant`

    $ vagrant init debian/jessie64
    $ vagrant up
    $ vagrant ssh

    $ sudo apt-get install build-essential python-dbg git gdb \
                           python-setuptools python-pip python-dev

    $ sudo /usr/bin/python-dbg /usr/bin/pip install cython


## Check version and configuation

    $ python-dbg --version
    Python 2.7.9


    $ python --version
    Python 2.7.9


    $ python3
    -bash: python3: command not found


    $ cython --version
    Cython version 0.25.2
    [89796 refs]


    $ gdb --version
    GNU gdb (Debian 7.7.1+dfsg-5) 7.7.1
    Copyright (C) 2014 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
    and "show warranty" for details.
    This GDB was configured as "x86_64-linux-gnu".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <http://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.
    For help, type "help".
    Type "apropos word" to search for commands related to "word".


    $ gdb --configuration
    This GDB was configured as follows:
        configure --host=x86_64-linux-gnu --target=x86_64-linux-gnu
                  --with-auto-load-dir=$debugdir:$datadir/auto-load
                  --with-auto-load-safe-path=$debugdir:$datadir/auto-load
                  --with-expat
                  --with-gdb-datadir=/usr/share/gdb (relocatable)
                  --with-jit-reader-dir=/usr/lib/gdb (relocatable)
                  --without-libunwind-ia64
                  --with-lzma
                  --with-python=/usr (relocatable)
                  --with-separate-debug-dir=/usr/lib/debug (relocatable)
                  --with-system-gdbinit=/etc/gdb/gdbinit
                  --with-zlib
                  --without-babeltrace
    ("Relocatable" means the directory can be moved with the GDB installation
    tree, and GDB will still find it.)


## build

Get the source code:

``` bash
git clone https://github.com/dfroger/cygdb-demo
cd cygdb-demo
```

Build:

``` bash
python-dbg setup.py build_ext --inplace
```

## demo.c and debug infos

`demo.pyx` compiles to `demo.c` and `cython_debug/cython_debug_info_demo`

For readiblity, `cython_debug_info_demo` has been formatted bellow with:

``` bash
sudo apt-get install libxml2-utils
xmllint --format --recover cython_debug_info_demo > out.xml
```

### cdef

``` Cython
cdef double foo(double x):
    return 2*x
```

compiles to:

``` c
static double __pyx_f_4demo_foo(double __pyx_v_x)
```

debug info:

``` xml
<Function cname="__pyx_f_4demo_foo" lineno="1" name="foo" pf_cname="" qualified_name="demo.foo">
  <Locals>
    <LocalVar cname="__pyx_v_x" lineno="1" name="x" qualified_name="demo.foo.x" type="CObject"/>
  </Locals>
  <Arguments>
    <x/>
  </Arguments>
  <StepIntoFunctions/>
</Function>
```

### def

``` Cython
def bar(double x):
    return 2*x
```

compiles to:

``` c
static PyObject *__pyx_pw_4demo_1bar(PyObject *__pyx_self, PyObject *__pyx_arg_x)
static PyObject *__pyx_pf_4demo_bar(CYTHON_UNUSED PyObject *__pyx_self, double __pyx_v_x)
```

debug info:

``` xml
<Function cname="__pyx_pw_4demo_1bar" lineno="4" name="bar" pf_cname="" qualified_name="demo.bar">
  <Locals>
    <LocalVar cname="__pyx_v_x" lineno="4" name="x" qualified_name="demo.bar.x" type="CObject"/>
  </Locals>
  <Arguments/>
  <StepIntoFunctions/>
</Function>
```

### cpdef

``` Cython
cpdef double baz(double x):
    return 2*x
```

compiles to:

``` c
static PyObject *__pyx_pw_4demo_3baz(PyObject *__pyx_self, PyObject *__pyx_arg_x)
static PyObject *__pyx_pf_4demo_2baz(CYTHON_UNUSED PyObject *__pyx_self, double __pyx_v_x)
static double __pyx_f_4demo_baz(double, int __pyx_skip_dispatch)
```

debug info:

``` xml
<Function cname="__pyx_f_4demo_baz" lineno="7" name="baz" pf_cname="__pyx_pw_4demo_3baz" qualified_name="demo.baz">
  <Locals>
    <LocalVar cname="__pyx_v_x" lineno="7" name="x" qualified_name="demo.baz.x" type="CObject"/>
  </Locals>
  <Arguments>
    <x/>
  </Arguments>
  <StepIntoFunctions/>
</Function>
```


## Demo of using cygdb


Run debugger:

    $ cygdb . -- --args python-dbg main.py

Set up a breakpoint, and run:

```GDB
cy break foo

cy run

cy list
```

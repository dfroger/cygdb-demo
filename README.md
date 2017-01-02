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


## Demo of using cygdb

Get the source code:

    $ git clone https://github.com/dfroger/cygdb-demo
    $ cd cygdb-demo

Build:

    $ python-dbg setup.py build_ext --inplace

Run debugger:

    $ cygdb . -- --args python-dbg main.py

Set up a breakpoint, and run:

    (gdb) cy break foo
    Function "__pyx_f_4demo_foo" not defined.
    Breakpoint 1 (__pyx_f_4demo_foo) pending.
    Function "__pyx_pw_4demo_1foo" not defined.
    Breakpoint 2 (__pyx_pw_4demo_1foo) pendin

    (gdb) cy run
    812      PyObject *__pyx_r = 0;

    (gdb) cy list
       807
       808    /* Python wrapper */
       809    static PyObject *__pyx_pw_4demo_1foo(PyObject *__pyx_self, PyObject *__pyx_arg_x); /*proto*/
       810    static PyObject *__pyx_pw_4demo_1foo(PyObject *__pyx_self, PyObject *__pyx_arg_x) {
       811      double __pyx_v_x;
    >  812      PyObject *__pyx_r = 0;
       813      __Pyx_RefNannyDeclarations
       814      __Pyx_RefNannySetupContext("foo (wrapper)", 0);
       815      assert(__pyx_arg_x); {
       816        __pyx_v_x = __pyx_PyFloat_AsDouble(__pyx_arg_x); if (unlikely((__pyx_v_x == (double)-1) && PyErr_Occurred())) __PYX_ERR(0, 1, __pyx_L3_error)

    (gdb) cy next
    815      assert(__pyx_arg_x); {

    (gdb) cy bt
    #8  0x000000000051f00b in <module>() at main.py:4
             4    y = demo.foo(x)

    (gdb) cy globals
    Not a function cygdb knows about. Use the normal GDB commands instead.

    (gdb) cy locals
    Not a function cygdb knows about. Use the normal GDB commands instead.

# cygdb-demo

Example of debugging Cython project


## Install dependencies

Set-up environment, for example using `vagrant`

    $ vagrant init debian/jessie64
    $ vagrant up
    $ vagrant ssh

    $ sudo apt-get install build-essential python-dbg git gdb python-setuptools python-pip python-dev
    $ sudo /usr/bin/python-dbg /usr/bin/pip install cython


##	Check version and configuation

		$ python-dbg --version
		Python 2.7.9


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

    $ cygdb . -- --args python main.py

Set up a breakpoint, and run:

    cy break foo
    cy run

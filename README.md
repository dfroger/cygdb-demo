# cygdb-demo

Example of debugging Cython project

## Set-up VM

Set-up environment, for example using `vagrant`

    vagrant init ubuntu/jessie64
    vagrant up
    vagrant ssh

Install dependencies:

    sudo apt-get install build-essential python-dbg git gdb python-setuptools
    sudo /usr/bin/python-dbg /usr/bin/pip install cython

Get the source code:

    git clone https://github.com/dfroger/quickstart
    cd quickstart/cython/debug

Build:

    python-dbg setup.py build_ext --inplace

Run debugger:

    cygdb . -- --args python main.py

Set up a breakpoint, and run:

    cy break foo
    cy run

ext:
	python-dbg setup.py build_ext --inplace

test:
	python-dbg main.py

debug:
		cygdb . -- --args python-dbg main.py

clean:
	rm -rf build/ *.so *.c cython_debug/

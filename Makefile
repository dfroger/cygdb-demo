ext:
	python-dbg setup.py build_ext --inplace

test:
	python main.py

debug:
		cygdb . -- --args python main.py

clean:
	rm -rf build/ *.so *.c cython_debug/

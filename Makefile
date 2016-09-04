# mruby is using Rake (http://rake.rubyforge.org) as a build tool.
# We provide a minimalistic version called minirake inside of our
# codebase.

RAKE = ruby ./minirake

all :
	$(RAKE)
.PHONY : all

test : all
	$(RAKE) test
.PHONY : test

clean :
	$(RAKE) clean
.PHONY : clean

withrust: rust all
rust: libarray.a
.PHONY : rust withrust

libarray.a: array.rs src/array.c
	rustup run nightly rustc array.rs --crate-type=staticlib -Cpanic=abort
	gcc -Iinclude -c src/array.c -o array.o
	ld -r array.o libarray.a -o ./build/bench/src/array.o
	ld -r array.o libarray.a -o ./build/test/src/array.o
	ld -r array.o libarray.a -o ./build/host-debug/src/array.o
	ld -r array.o libarray.a -o ./build/host/src/array.o

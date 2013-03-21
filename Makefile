#!/usr/bin/make -f

BEAMFILES := $(wildcard ebin/*.beam) $(wildcard test/*.beam)

all: build

build: ebin/$(APPFILE)
	erl -make

clean:
	-rm -rf ebin/$(APPFILE) $(BEAMFILES)

test: build
	erlc -W +debug_info +compressed +strip -o test/ test/*.erl
	erl -noshell -pa ebin -pa test -eval "query_tests:test()" -eval "init:stop()"

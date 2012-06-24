runner = lib/run-jasmine.phantom.js

html = $(wildcard *.html)

.PHONY: all
all: $(html)

%.html: FORCE
	@phantomjs $(runner) file://$(CURDIR)/$@

FORCE:
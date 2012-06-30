html = $(wildcard *.html)

.PHONY: all
all: $(html)

spine.html: specs/class.js specs/events.js specs/model.js specs/model.local.js specs/model.relation.js specs/controller.js
ajax.html: specs/ajax.js
manager.html: specs/manager.js
route.html: specs/route.js

%.html: FORCE
	phantomjs lib/run-jasmine.phantom.js file://$(CURDIR)/$@

.PRECIOUS: specs/%.js
specs/%.js: specs/src/%.coffee
	coffee --compile --print $< > $@

.PHONY: clean
clean:
	rm -Rf specs/*.js

FORCE:
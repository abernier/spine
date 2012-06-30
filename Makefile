js = $(patsubst %.coffee,%.js,$(addprefix lib/,$(notdir $(wildcard src/*.coffee))))

.PHONY: build
build: $(js)

$(js): lib

lib:
	mkdir -p $@

lib/%.js: src/%.coffee
	coffee --compile --print $< > $@

.PHONY: test
test: $(js)
	$(MAKE) -C $@

.PHONY: publish
publish: build test

.PHONY: clean
clean:
	rm -Rf lib
	$(MAKE) -C test clean
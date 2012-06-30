js = $(patsubst %.coffee,%.js,$(addprefix lib/,$(notdir $(wildcard src/*.coffee))))

.PHONY: build
build: $(js)

lib/%.js: src/%.coffee
	@test -d $(@D) || mkdir $(@D)
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
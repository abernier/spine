src  = ${npm_package_directories_src}
lib  = ${npm_package_directories_lib}
test = ${npm_package_directories_test}

js = $(patsubst %.coffee,%.js,$(addprefix $(lib)/,$(notdir $(wildcard $(src)/*.coffee))))

.PHONY: build
build: $(js)

$(js): $(lib)

$(lib):
	mkdir -p $@

$(lib)/%.js: $(src)/%.coffee
	coffee --compile --print $< > $@

.PHONY: test
test: $(js)
	@$(MAKE) -C $@

.PHONY: clean
clean:
	rm -Rf $(lib)
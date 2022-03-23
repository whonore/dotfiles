.PHONY: all clean

all: .ctags

.ctags: .ctags.tmpl
	envsubst <$< >$@

clean:
	rm -f .ctags

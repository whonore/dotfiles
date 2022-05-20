SHELL := /bin/bash

TMPLS := $(wildcard */*.tmpl) $(wildcard */.*.tmpl)
SUBST := $(basename $(TMPLS))

.PHONY: all clean

all: $(SUBST)

%: %.tmpl
	source $(dir $@)/env.sh 2>/dev/null; envsubst <$< >$@

clean:
	rm -rf $(SUBST)

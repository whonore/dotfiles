TMPLS := $(wildcard */*.tmpl) $(wildcard */.*.tmpl)
SUBST := $(basename $(TMPLS))

.PHONY: all clean

all: $(SUBST)

%: %.tmpl
	envsubst <$< >$@

clean:
	rm -rf $(SUBST)

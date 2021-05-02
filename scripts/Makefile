SCRIPTS := $(addprefix bin/, $(subst .py,,$(wildcard *.py)))
CFLAGS := -Wall -Wextra
file-to-sym = $(basename $(notdir $1))_$(subst .,,$(suffix $1))
redefine-sym = --redefine-sym _binary_$(call file-to-sym,$1)_$2=_binary_prog_$2

.PHONY: all clean

all: $(SCRIPTS)

wrapper.o: wrapper.c
	$(CC) $(CFLAGS) -c $^ -o $@

%.o: %.py
	objcopy -I binary -O elf64-x86-64 -B i386 $^ $@ \
	    $(foreach sym,start end size,$(call redefine-sym,$^,$(sym))) \
	    --rename-section .data=.rodata,alloc,load,readonly,data,contents

bin/%: %.o wrapper.o
	mkdir -p bin
	$(CC) $(CFLAGS) $^ -o $@
	sudo chown root $@
	sudo chmod u+s $@

clean:
	rm -f $(SCRIPTS) *.o

SCRIPTS := $(addprefix bin/, $(subst .py,,$(wildcard *.py)))

.PHONY: all clean

all: $(SCRIPTS)

wrapper.o: wrapper.c
	gcc -Wall -c $^ -o $@

%.o: %.py
	objcopy -I binary -O elf64-x86-64 -B i386 $^ $@ \
	    --redefine-sym _binary_$(basename $(notdir $^))_$(subst .,,$(suffix $^))_start=_binary_prog_start \
	    --redefine-sym _binary_$(basename $(notdir $^))_$(subst .,,$(suffix $^))_end=_binary_prog_end \
	    --redefine-sym _binary_$(basename $(notdir $^))_$(subst .,,$(suffix $^))_size=_binary_prog_size \
	    --rename-section .data=.rodata,alloc,load,readonly,data,contents

bin/%: %.o wrapper.o
	mkdir -p bin
	gcc -Wall $^ -o $@
	sudo chown root $@
	sudo chmod u+s $@

clean:
	rm -f $(SCRIPTS) *.o

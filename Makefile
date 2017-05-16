BIN = $(HOME)/bin
C   = $(HOME)/.udx # where to install config files

PROG = refine scale
CONF = off.awk refine.awk scale.awk

install: install_prog install_conf

install_prog:; mkdir -p $(BIN) && cp $(PROG) $(BIN)
install_conf:; mkdir -p $(C)   && cp $(CONF) $(C)

.PHONY: install install_conf install_prog

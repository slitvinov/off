BIN = $(HOME)/.local/bin
C   = $(HOME)/.udx

PROG = refine scale area volume
CONF = off.awk refine.awk scale.awk area.awk volume.awk

install:
	mkdir -p '$(BIN)'
	for i in $(PROG); do cp $$i '$(BIN)'/off.$$i; chmod +x '$(BIN)'/off.$$i; done
	mkdir -p '$C'
	cp $(CONF) '$C'

default: build_all xfer_writefile

build_all: test.prg build_writefile build_errchnl

build_writefile: clean_writefile
	acme -l writefile.lst test/writefile.s

build_errchnl: clean_errchnl
	acme -l errchnl.lst test/errchnl.s

xfer_writefile:
	m65 writefile.prg

xfer_errchnl:
	m65 errchnl.prg
	
clean: clean_writefile clean_errchnl
	(rm test.prg test.lst ; exit 0)

clean_errchnl:
	(rm errchnl.prg errchnl.lst; exit 0)

clean_writefile:
	(rm writefile.prg writefile.lst; exit 0)

test.prg:test/test.s
	acme -l test.lst test/test.s 

xfer:test.prg
	m65 test.prg

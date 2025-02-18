kickass=java -jar ${HOME}/m65/asm/kickassembler65ce02/out/KickAss65CE02.jar
default: build_all xfer_writefile

build_all: test.prg build_writefile build_errchnl

build_writefile: clean_writefile
	${kickass}  test/writefile.s

build_errchnl: clean_errchnl
	${kickass}  test/errchnl.s

xfer_writefile:
	m65 test/writefile.prg

xfer_errchnl:
	m65 test/errchnl.prg
	
clean: clean_writefile clean_errchnl
	(rm test.prg test.lst ; exit 0)

clean_errchnl:
	(rm errchnl.prg errchnl.lst; exit 0)

clean_writefile:
	(rm writefile.prg writefile.lst; exit 0)

test.prg:test/test.s
	${kickass}  test/test.s 

xfer:test.prg
	m65 test/test.prg

kickass=java -jar ${HOME}/m65/asm/kickassembler65ce02/out/KickAss65CE02.jar
xfer=etherload
# xfer=m65
default: build_all

build_all: test.prg build_writefile build_errchnl

build_writefile: 
	${kickass}  test/writefile.s

build_errchnl:
	${kickass}  test/errchnl.s

xfer_writefile:
	${xfer} test/writefile.prg

xfer_errchnl:
	${xfer} test/errchnl.prg
	
clean: 
	(rm test/*.prg test/*.sym test/*.log ; exit 0)

test.prg:test/test.s
	${kickass}  test/test.s

xfer:test.prg
	${xfer} test/test.prg

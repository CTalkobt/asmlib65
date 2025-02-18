//
// Generates a basic stub that creates a "SYS" statement
// to the given .start routine, along with REM comment. 
//
.macro basic_stub(start, comment) {
	//* = $0201  ; mega65
    //* = $0801  ; c64
    //* = $1001  ; c16/+4
    //* = $1c01  ; c128
        .word line2, 2021 // link pointer and line number
        .byte $9e, ' '    // "sys "
        .byte '0' + mod(start,10000) / 1000
        .byte '0' + mod(start,1000) /  100
        .byte '0' + mod(start,100) /   10
        .byte '0' + mod(start,10)
	.if (comment.size() > 0)  {
        .text  ':'
		.byte $8f
		.text comment     // REM
	}
        .byte 0   // line terminator
line2:      .word 0   // program terminator

}


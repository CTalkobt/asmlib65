;
; Generates a basic stub that creates a "SYS" statement
; to the given .start routine, along with REM comment. 
;
!macro basic_stub .start, .comment {
	;* = $0201  ; mega65
    ;* = $0801  ; c64
    ;* = $1001  ; c16/+4
    ;* = $1c01  ; c128
        !wo line2, 2021 ; link pointer and line number
        !by $9e, ' '    ; "sys "
        !by '0' + .start % 10000 / 1000
        !by '0' + .start %  1000 /  100
        !by '0' + .start %   100 /   10
        !by '0' + .start %    10
	!if len(.comment) > 0 {
        !pet ':', $8f, .comment     ; REM
	}
        !by 0   ; line terminator
line2       !wo 0   ; program terminator

}

; entry will be the label that it jumps to. 
; 
; entry       ; the BASIC stub jumps here

!macro print_lowercase {
	lda #14
	jsr _bsout
}
!macro print .string {
	jsr _primm
	!pet .string, 0
}


!macro ld_az .location {
	lda .location
	ldz .location+1
}

!macro putchar .val {
	lda #.val
	jsr _bsout
}	

!macro print_strat .address {
	ldy #$00
-	lda .address,y
	beq +
	jsr bsout
	iny
	bne -
+
}

; 
; print decimal value of .az
;
!macro print_a_dec {
	+todecimal
	clc
	adc #'0'
	jsr bsout
	tza
	clc
	adc #'0'
	jsr bsout
}

!macro hex_az {
	pha
	lsr 
	lsr 
	lsr 
	and #15
	cmp #10
	bcc +
	adc #6
+   adc #'0'
	taz
	pla
	and #15
	cmp #10
	bcc +
	adc #6
+   adc #'0'
}

hex_digits !pet "0123456789abcdef",0
; 
; .A = hex nibble 
!macro hex_digit {
	and #$0f
	tax
	lda hex_digits,x
}

; 
; Convert .A to hex digits to .AZ
!macro convert_hex {
	pha
	+hex_digit
	taz
	pla
	lsr
	lsr
	lsr
	lsr
	+hex_digit
}

!macro print_a_hex {
	+convert_hex
	phz
	jsr _bsout
	pla
	jsr _bsout
		
}

!macro print_az_hex {
	phz
	+print_a_hex
	pla
	+print_a_hex
}

!macro print_space {
	lda #" "
	jsr _bsout
}


; .X = string length 
!macro str_len .address {
	ldx #$ff
-	inx
	lda .address,x
	bne -
}

; Transfer .X to .Z
!macro txz {
	phx
	plz
}

; Convert .A to decimal digits into .AZ
;
!macro todecimal {
	sta $2003
	ldz #$ff		; .Z=10's digits. 
	sec
-   inz
	sbc #10
	bpl -
	adc #10
	phz
	taz
	pla
}

; 
; Compare .str1 to .str2
; 
; z flag = matched, .A = last character from str1 on mismatch. 
; .x = index of mismatch.
!macro str_cmp .str1, .str2 {
	ldx #$ff   ; index str1
-   inx
	lda .str1,x
	cmp .str2,x
	bne +      ; strings don't match, return.
	cmp #0     ; check if str1 == null, if so, then str2 didn't due to prior
	beq +
	bra -
+   
}

;
; Load 8 bit value at 32 bit address offset by z into .A
; Uses $fc-$ff
;
!macro ld8_32 .ptr32 {
	lda #< ((.ptr32 & $ff000000)>>24)
	sta $ff
	lda #< ((.ptr32 & $00ff0000)>>16)
	sta $fe
	lda #< ((.ptr32 & $0000ff00)>>8)
	sta $fd
	lda #< ((.ptr32 & $000000ff))
	sta $fc
	ldz #$00
	lda [$fc],z
}

#importonce


.macro print_lowercase() {
	lda #14
	jsr _bsout
}
.macro print(string) {
	jsr _primm
	.text string
	.byte 0
}

.macro ld_az(location) {
	lda location
	ldz location+1
}

.macro putchar(val) {
	lda #val
	jsr _bsout
}	

.macro print_strat(address) {
	ldy #$00
!:
	lda address,y
	beq !+
	jsr _bsout
	iny
	bne !-
!:
}

// 
// print decimal value of .az
//
.macro print_a_dec() {
	todecimal()
	clc
	adc #'0'
	jsr _bsout
	tza
	clc
	adc #'0'
	jsr _bsout
}

.macro hex_az() {
	pha
	lsr 
	lsr 
	lsr 
	and #15
	cmp #10
	bcc !+
	adc #6
!:  adc #'0'
	taz
	pla
	and #15
	cmp #10
	bcc !+
	adc #6
!:  adc #'0'
}

hex_digits: 
	.text "0123456789abcdef"
	.byte 0
// 
// .A = hex nibble 
.macro hex_digit() {
	and #$0f
	tax
	lda hex_digits,x
}

// 
// Convert .A to hex digits to .AZ
.macro convert_hex() {
	pha
	hex_digit()
	taz
	pla
	lsr
	lsr
	lsr
	lsr
	hex_digit()
}

.macro print_a_hex() {
	convert_hex()
	phz
	jsr _bsout
	pla
	jsr _bsout
		
}

.macro print_az_hex() {
	phz
	print_a_hex()
	pla
	print_a_hex()
}

.macro print_space() {
	lda #" "
	jsr _bsout
}


// Transfer .X to .Z
.macro txz() {
	phx
	plz
}

// Convert .A to decimal digits into .AZ
//
.macro todecimal() {
	ldz #$ff		// .Z=10's digits. 
	sec
!:  inz
	sbc #10
	bpl !-
	adc #10
	phz
	taz
	pla
}

//
// Load 8 bit value at 32 bit address offset by z into .A
// Uses $fc-$ff
//
.macro ld_8x32(ptr32) {
	lda #< ((ptr32 & $ff000000)>>24)
	sta $ff
	lda #< ((ptr32 & $00ff0000)>>16)
	sta $fe
	lda #< ((ptr32 & $0000ff00)>>8)
	sta $fd
	lda #< ((ptr32 & $000000ff))
	sta $fc
	ldz #$00
	lda (($fc)),z
}

//
// Compare .ax against (ptr32)
//
.macro cmpp_ax(ptr16) {
    cmp ptr16+1
    bne !+
    bcs !+
    cpx ptr16
!:
}

// 
// Load .ax from ptr16. 
//
.macro ld_ax(ptr16) {
    lda ptr16+1
    ldx ptr16
}

//
// Store .ax to ptr16
//
.macro st_ax(ptr16) {
    sta ptr16+1
    stx ptr16
}

//
// Compare two 16 bite ptrs. 
// 
.macro cmp_16(ptr16a, ptr16b) {
    ldax ptr16a
    cpax ptr16b
}

.macro incw_16(ptr16) {
    // TODO: If ptr16 is zero page based, then used dew. 
    // inw ptr16
    inc ptr16
    bne !+
    inc ptr16
!:
}

.macro dec_16(ptr16) {
    // TODO: If ptr16 is zero page based, then used dew. 
    // dew ptr16
    dec ptr16
    bne !+
    dec ptr16+1
!:
}

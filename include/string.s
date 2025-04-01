#importonce

// 
// Compare .str1 to .str2
// 
// z flag = matched, .A = last character from str1 on mismatch. 
// .x = index of mismatch.
.macro str_cmp(str1, str2) {
	ldx #$ff   // index str1
!:   inx
	lda str1,x
	cmp str2,x
	bne !+     // strings don't match, return.
	cmp #0     // check if str1 == null, if so, then str2 didn't due to prior
	beq !+
	bra !-
!:
}

// .X = string length 
.macro str_len(address) {
	ldx #$ff
!:	inx
	lda address,x
	bne !-
}



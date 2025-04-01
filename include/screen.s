#importonce

//
// This is only accurate for screen in bank 0. 
// Otherwise use full 24 bit address at $d060-$d063
//
.macro screen_address() {
    lda $d060+1
    ldx $d061
}

//
// This is only accurate for normal mode, where first 1k of color
// is available, at $d800-$dfff. Otherwise use full 24bit address
// mode referencd at $ff8.0000-$ff8.ffff
.macro color_address() {
    lda #$00
    ldx #$d8
}

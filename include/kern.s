#importonce


.import "include/kernal.s"

.macro push_to_keyboard_buffer(str) {
	.for(var i=0; i<str.size(); i++) {
    lda #str.get(i)
	jsr _addkey
    }
}


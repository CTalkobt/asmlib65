	.cpu _45gs02
	.encoding "petscii_mixed"
* = $2001
#import "include/basicstub.s"
#import "include/kernal.s"
basic_stub(start, " CTALKOBT")


diagnoseerror:
start:
	k_setbank(0,0)
	k_setnam_va(6, filename)    // indicate no filename needed. 
	k_setlfs($01, $08, $01)     // set lfs=<generate>, dev 8, channel 1. 
	tax                      // .x = logical file number. 
	stx $0801

	k_open()
	bcs error

	ldx #$1
	jsr _ckout            // set default output channel.


	ldy #$00
!:  lda text,y
	beq done
	jsr _chrout
	iny
	bne !-

//    jsr _chkin         ; CHKIN (Set input channel)

//	phx               ; Save logical file number.
// read_error:
// 	jsr _readst       ; get status byte. 
// 	bne done		  ; got eof.
// 
 //    jsr _basin        ; BASIN (Read a byte from input)
  //   bcs done          ; If null terminator, we're done
   //  beq done
    // jsr 0xFFD2        ; Print character to screen
//     bcc read_error    ; Always branches, loop until null

done:
//     jsr _clrchn       ; CLRCHN (Clear input channel)

//	pla				  ; .A = logical file number
	k_close(1)          // Close lfn #1
	jsr _clrchn
    rts               // Return

error:
	inc $d020
	bra error

filename: .text "test,s"
	     .byte 0
text:    .text "Do not fold, bend, spindle or mutilate this program any further."
         .byte 0

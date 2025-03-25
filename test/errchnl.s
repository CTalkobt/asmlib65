	.cpu _45gs02
	.encoding "petscii_mixed"
* = $2001
#import "include/basicstub.s"
#import "include/kernal.s"
basic_stub(start, " CTALKOBT")

diagnoseerror:
start:
	k_setbank(0,0)
	k_setnam_none()    // indicate no filename needed. 
	k_setlfs($00, $08, $0f)  // set lfs=00, dev 8, channel 15. 
	tax

	jsr _open
	bcs error

    jsr _chkin         // CHKIN (Set input channel)

	phx               // Save logical file number.
read_error:
	jsr _readst       // get status byte. 
	bne done		  // got eof.

    jsr _basin        // BASIN (Read a byte from input)
    bcs done          // If null terminator, we're done
    beq done
    jsr _bsout        // Print character to screen
    bcc read_error    // Always branches, loop until null

done:
    jsr _clrchn       // CLRCHN (Clear input channel)

	pla				  // .A = logical file number
	sec				  // don't close other files open on the device 
    jsr _close        // CLOSE file
    rts               // Return

error:
	inc $d020
	bra error

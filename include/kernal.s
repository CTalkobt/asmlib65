
.const current_device = $ba        // Current device number, generally 8

//
// Kernal vectors
// 
.const _savefl      = $ff3b    // Save to file,.A-ZP ptr to start address,.YX - End address, .Z:6-Raw mode, (no start address). 
.const _getio       = $ff41
.const _getlfs      = $ff44
.const _keylocks    = $ff47
.const _addkey      = $ff4a
.const _spin_spout  = $ff4d
.const _close_all   = $ff50
.const _c64mode     = $ff53
.const _monitorcall = $ff56
.const _phoenix     = $ff5c
.const _lkupla      = $ff5f
.const _lkupsa      = $ff62
.const _swapper     = $ff65
.const _setbnk      = $ff6b
.const _jsrfar      = $ff6e
.const _jmpfar      = $ff71
.const _ldafar      = $ff74
.const _stafar      = $ff77
.const _primm       = $ff7d
.const _cint        = $ff81
.const _ioinit      = $ff84
.const _ramtas      = $ff87
.const _restor      = $ff8a
.const _vector      = $ff8d
.const _setmsg      = $ff90
.const _secnd       = $ff93
.const _tksa        = $ff96
.const _key         = $ff9f
.const _monexit     = $ffa2
.const _acptr       = $ffa5
.const _ciout       = $ffa8
.const _untlk       = $ffab
.const _unlsn       = $ffae
.const _listn       = $ffb1
.const _talk        = $ffb4
.const _readss      = $ffb7
.const _readst      = $ffb7    // *preferred
.const _setlfs      = $ffba
.const _setnam      = $ffbd
.const _open        = $ffc0
.const _close       = $ffc3
.const _chkin       = $ffc6
.const _ckout       = $ffc9
.const _clrch       = $ffcc
.const _clrchn      = $ffcc    // *preferred
.const _basin       = $ffcf
.const _chrout      = $ffd2
.const _bsout       = $ffd2	// *preferred
.const _load        = $ffd5
.const _save        = $ffd8    // Save to file, .A-ZP ptr to start address, .YX - End address
.const _settim      = $ffdb
.const _rdtim       = $ffde
.const _stop        = $ffe1
.const _getin       = $ffe4
.const _clall       = $ffe7
.const _scrorg      = $ffed
.const _plot        = $fff0

//
// File handling routines. 
//
// Due to the way macros expand w/in ACME it's unable to determine
// value of address for the parameters. The following convention has
// been adapted for different parameter invocation:
//    macro_name - Without any _a or _v suffixes will indicate a
//       macro invocation that takes values instead of memory 
//       addresses. 
//    macro_name_a - Indicates that the 1st parameter takes an address
//    macro_name_aav - Indicates that the 1st and 2nd paramters are 
//      addresses while the 3rd is a value. 
//
// Note that the _a or _v suffixes are only provided when it makes 
//   sense and not all permuations are provided. 
// 

//
// Set bank for kernal I/O and filename memory address. 
// Input: 
//   (immediate mode / value)
//   bank_mem      - Value of bank for memory
//   bank_filename - Value of bank for filename location.
// 
// Output: 
//   None defined. 
//   Unknown registers modified.
//
.macro k_setbank(bank_mem, bank_filename) {
	lda #bank_mem
	ldx #bank_filename
	jsr _setbnk
}

//
// Like k_setbank but uses values at addr_bank_mem, addr_bank_filename
//
.macro k_setbank_aa(addr_bank_mem, addr_bank_filename) {
	lda addr_bank_mem
	ldx addr_bank_filename
	jsr _setbnk
}

//
// Set filename pointer
// Input:
//   .length   - Length of filename not including 0 byte.
//   .filename - Filename; only needed if .length != 0 
//
.macro k_setnam(length, str) {
	lda #length
	.if (length > 0) {
	bra !++
!: .text str
	.byte 0
!:
    ldx #(<!--)
	ldy #(>!--)
	}
	jsr _setnam
}

.macro k_setnam_va(length, filename) {
	lda #length
	.if (length > 0) {
	ldx #<filename
	ldy #>filename
	}
	jsr _setnam
}



//
// Set file, device, secondary address
// Input:
//   lfn       - Logical file number
//   dev_num   - Device number
//   dev_chnl  - Secondary address
//     For serial disk:
//         0 - Reserved for Load
//         1 - Reserved for Save
//        15 - Command channel. 
// Output:
//   .A - logical file number
//   
//  
.macro k_setlfs(lfn, dev_num, dev_chnl) {
	lda #lfn
	ldx #dev_num
	ldy #dev_chnl
	jsr _setlfs
}

//
// Open logical file.
// Input:
// Output:
//   .C flag - Error
//   .A      - Error code if error. 
.macro k_open() {
	jsr _open
}

// 
// Close logical file
// Input:
//   .lfn - Logical file number, immediate
//
.macro k_close(lfn) {
	lda  #lfn
	jsr _close
}


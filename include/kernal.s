
current_device = $ba        ; Current device number, generally 8

;;
;; Kernal vectors
;; 
_savefl      = $ff3b    ; Save to file,.A-ZP ptr to start address,.YX - End address, .Z:6-Raw mode, (no start address). 
_getio       = $ff41
_getlfs      = $ff44
_keylocks    = $ff47
_addkey      = $ff4a
_spin_spout  = $ff4d
_close_all   = $ff50
_c64mode     = $ff53
_monitorcall = $ff56
_phoenix     = $ff5c
_lkupla      = $ff5f
_lkupsa      = $ff62
_swapper     = $ff65
_setbnk      = $ff6b
_jsrfar      = $ff6e
_jmpfar      = $ff71
_ldafar      = $ff74
_stafar      = $ff77
_primm       = $ff7d
_cint        = $ff81
_ioinit      = $ff84
_ramtas      = $ff87
_restor      = $ff8a
_vector      = $ff8d
_setmsg      = $ff90
_secnd       = $ff93
_tksa        = $ff96
_key         = $ff9f
_monexit     = $ffa2
_acptr       = $ffa5
_ciout       = $ffa8
_untlk       = $ffab
_unlsn       = $ffae
_listn       = $ffb1
_talk        = $ffb4
_readss      = $ffb7
_readst      = $ffb7    ; *preferred
_setlfs      = $ffba
_setnam      = $ffbd
_open        = $ffc0
_close       = $ffc3
_chkin       = $ffc6
_ckout       = $ffc9
_clrch       = $ffcc
_clrchn      = $ffcc    ; *preferred
_basin       = $ffcf
_chrout      = $ffd2
_bsout       = $ffd2	; *preferred
_load        = $ffd5
_save        = $ffd8    ; Save to file, .A-ZP ptr to start address, .YX - End address
_settim      = $ffdb
_rdtim       = $ffde
_stop        = $ffe1
_getin       = $ffe4
_clall       = $ffe7
_scrorg      = $ffed
_plot        = $fff0

;;
;; File handling routines. 
;;
;; Due to the way macros expand w/in ACME it's unable to determine
;; value of address for the parameters. The following convention has
;; been adapted for different parameter invocation:
;;    macro_name - Without any _a or _v suffixes will indicate a
;;       macro invocation that takes values instead of memory 
;;       addresses. 
;;    macro_name_a - Indicates that the 1st parameter takes an address
;;    macro_name_aav - Indicates that the 1st and 2nd paramters are 
;;      addresses while the 3rd is a value. 
;;
;; Note that the _a or _v suffixes are only provided when it makes 
;;   sense and not all permuations are provided. 
;; 

;
; Set bank for kernal I/O and filename memory address. 
; Input: 
;   (immediate mode / value)
;   bank_mem      - Value of bank for memory
;   bank_filename - Value of bank for filename location.
; 
; Output: 
;   None defined. 
;   Unknown registers modified.
;
!macro k_setbank .bank_mem, .bank_filename {
	lda #.bank_mem
	ldx #.bank_filename
	jsr _setbnk
}

;
; Like k_setbank but uses values at addr_bank_mem, addr_bank_filename
;
!macro k_setbank_aa .addr_bank_mem, .addr_bank_filename {
	lda .addr_bank_mem
	ldx .addr_bank_filename
	jsr _setbnk
}

;
; Set filename pointer
; Input:
;   .length   - Length of filename not including 0 byte.
;   .filename - Filename; only needed if .length != 0 
;
!macro k_setnam .length, .filename {
	lda #.length
	!if .length > 0 {
	bra +
.local_filename !pet .filename,0
+   ldx #<.local_filename
	ldy #>.local_filename
	}
	jsr _setnam
}

!macro k_setnam_va .length, .filename {
	lda #.length
	!if .length > 0 {
	ldx #<.filename
	ldy #>.filename
	}
	jsr _setnam
}



;
; Set file, device, secondary address
; Input:
;   lfn       - Logical file number
;   dev_num   - Device number
;   dev_chnl  - Secondary address
;     For serial disk:
;         0 - Reserved for Load
;         1 - Reserved for Save
;        15 - Command channel. 
; Output:
;   .A - logical file number
;   
;  
!macro k_setlfs .lfn, .dev_num, .dev_chnl {
	lda #.lfn
	ldx #.dev_num
	ldy #.dev_chnl
	jsr _setlfs
}

;
; Open logical file.
; Input:
; Output:
;   .C flag - Error
;   .A      - Error code if error. 
!macro k_open {
	jsr _open
}

; 
; Close logical file
; Input:
;   .lfn - Logical file number, immediate
;
!macro k_close .lfn {
	lda  #.lfn
	jsr _close
}

;
; Clear all channels.
; Input 
;   .lfn - 

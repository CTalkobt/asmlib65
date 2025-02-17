	!cpu m65
	!to "test.prg", cbm
* = $2001
!source "include/basicstub.s"
+basic_stub banner, " CTALKOBT"

!source "include/keydefs.s"
!source "include/kernal.s"
!source "include/common.s"


; rtc = $fd7110 ; RTC register.
; rtc = $fd7140
; rtc_mb = $0f
rtc = $0ffd7140
rtc2 = $0ffd7111

banner = *
 	+print_lowercase
 	+print "Test v0.0.1\r"

	+ld8_32 rtc
	+print_a_hex

	rts



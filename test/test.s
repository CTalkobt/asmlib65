	.cpu _45gs02
	.encoding "petscii_mixed"
* = $2001
#import "include/basicstub.s"
basic_stub(banner, " CTALKOBT")

#import "include/keydefs.s"
#import "include/kernal.s"
#import "include/common.s"


// rtc = $fd7110 ; RTC register.
// rtc = $fd7140
// rtc_mb = $0f
.const rtc  = $0ffd7140
.const rtc2 = $0ffd7111

banner:
 	print_lowercase()
 	print(@"Test v0.0.1\nLine2\r")

	ld8_32(rtc)
	print_a_hex()

	rts



#importonce

#import "include/kernal.s"

.macro bload(filename,bank,address,raw_mode,drive,unit) {
	.error("Not implemented")
}

.macro boot(filename,bank,address,drive,unit) {
	.error("Not implemented")
}

.macro border(color) {
	lda #color
	sta $d020   // @@TODO: Remove direct reference, use label. 
}

.macro box(x0,y0,x1,y1,x2,y2,sold) {
	.error("Not implemented")
}

.macro bsave(filename,start_addr,end_addr,bank,drive,unit) {
	.error("Not implemented")
}

.macro bump(type) {
	.error("Not implemented")
}

.macro bverify(filename,address,bank,drive,unit) {
	.error("Not implemented")
}

.macro catalog() {
	.error("NEVER IMPLEMETNED - USE DIR instead")
}

.macro char(col,row,height,width,direction,string,charset_addr) {
	.error("Not implemented")
}

.macro chardef(index,values) {
	.error("Not implemented")
}

.macro chdir(dirname,unit) {
	.error("Not implemented")
}

.macro circle(xc,yc,radius,flag,start,stop) {
	.error("Not implemented")
}

.macro close(channel) {
	k_close(channel)
}

.macro cmd(channel,string) {
	.error("Not implemented")
}

.macro collect(drive,unit) {
	.error("Not implemented")
}

.macro collision(type,address) {
	.error("Not Implemented / Potential future IRQ /NMI vector jump?")
}


#importonce

.function __abs(val) {
	.print "Type:"+val.getType()
	.if (val.hasIntRepresentation()) 
		.return 1
	.return CmdArgument(val.getType(), "Value:"+val.getValue())
}

.function __16bitnextArg(arg) {
	.if (arg.getType()==AT_IMMEDIATE)
		.return CmdArgument(arg.getType(),>arg.getValue())
	.return CmdArgument(arg.getType(),arg.getValue())
}





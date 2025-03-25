#importonce

// 
// Petscii Color codes. 
// 
// For use during putchar / bsout invocations
// See vic_color for color code equivalents for
// setting border and background registers etc directly.
.namespace pet_palette1 {
	.label enable     = 4

	.label black      = 144
	.label white      = 5
	.label red        = 28
	.label cyan       = 159
	.label purple     = 156
	.label green      = 30
	.label blue       = 31
	.label yellow     = 158
	.label orange     = 129
	.label brown      = 149
	.label lightred   = 150
	.label darkgrey   = 151
	.label mediumgrey = 152
	.label lightgreen = 153
	.label lightblue  = 154
	.label lightgrey  = 155
}

.namespace pet_palette2 {
	.label enable          = 1

	.label gurumeditation  = 144
	.label rambutan        = 5
	.label carrot          = 28
	.label lemontart       = 159
	.label pandan          = 156
	.label seasickgreen    = 30
	.label solyentgreen    = 31
	.label slimergreen     = 158
	.label othercyan       = 129
	.label seasky          = 149
	.label smurfblueth     = 150
	.label screendeath     = 151
	.label plumsaucer      = 152
	.label sourgrape       = 153
	.label bubblegum       = 154
	.label bottamales      = 155
}


// 
// Petscii character codes 
// 
.namespace pet_fn {
	.label f1            = 133
	.label f2            = 137
	.label f3            = 134
	.label f4            = 138
	.label f5            = 135
	.label f6            = 139
	.label f7            = 136
	.label f8            = 140
	.label f9            = 16
	.label f10           = 21  // Alternate for word_back 
	.label f11           = 22
	.label f12           = 23  // Alternate for word_next
	.label f13           = 25
	.label f14           = 26  // ALternate for Back-Tab
	.label help          = 132 // ALternate for Back-Tab
}

.namespace pet {
	.label palette_alt      = 1
	.label underline_off    = 2
	.label palette_default  = 4
	.label bell             = 7
	.label linefeed         = 10
	.label disable_case_chg = 11   // Disable case chg via Mega-shift
	.label enable_case_chg  = 12   // Enable case chg via Mega-shift
	.label return           = 13
	.label lower_case       = 14
	.label flash_on         = 15
	.label reverse_on       = 18
	.label clear_home       = 19
	.label insert_delete    = 20
	.label delete           = 20   // Alternate for insert_delete
	.label insert           = 20   // Alternate for insert_delete
	.label word_back        = 21   // Alternate for fn_f10
	.label word_next        = 23   // Alternate for fn_f12
	.label tab_toggle       = 24
	.label back_tab         = 26   // Alternate for fn-f14
	.label escape           = 27
	.label arrow_up         = 145
	.label arrow_down       = 17
	.label arrow_right      = 29
	.label arrow_left       = 157
	.label shift_space      = 160
    .label space            = 32
    .label shift_return     = 141
	.label shift_runstop    = 131
	.label shift_clrhome    = 147
	.label shift_insdel     = 148
	.label up_arrow         = 94   // ^ key next to restore. 
	.label back_rrow        = 95   // <- key
	.label pound            = 92   // pound symbol. 
}


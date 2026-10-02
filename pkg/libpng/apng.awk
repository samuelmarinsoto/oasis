# insert the APNG option defines inside the pnglibconf.h include guard
# (the dfa pipeline only knows stock options; the browser's PNG decoder
# guards its APNG paths on PNG_APNG_SUPPORTED)
/#endif/ && !done {
	print "#define PNG_APNG_SUPPORTED 1"
	print "#define PNG_READ_APNG_SUPPORTED 1"
	print "#define PNG_WRITE_APNG_SUPPORTED 1"
	done = 1
}
{ print }

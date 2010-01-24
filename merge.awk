FILENAME ~ ERRFILE {
	if (started) {
	 	if (match($0, /[ ]+\^$/)) {
			started = 0
			print entry SUBSEP $0
		} else if (first) {
			entry = entry $0
		} else {
			entry = entry SUBSEP $0
		}
		
		first = 0
	} else if (!started) {
		started = 1
		first = 1
		entry = $0":"
	}
}

FILENAME ~ WARNFILE {
	print $0
}
BEGIN {
	sub(/\/$/, "", DIR)
	DIR = DIR"/"
	
	print "<!DOCTYPE html>"
	print "<html dir=\"ltr\" lang=\"en-US\">"
	print "	<head>"
	print "		<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
	print "		<title></title>"
	print "		<link rel=\"stylesheet\" href=\"master.css\" media=\"screen\" />"
	print "	</head>"
	print "	<body>"
	print "		<header>"
	print "			<h1>Pyflakes output for " DIR "</h1>"
	print "		</header>"
	print "		"
	print "		<ul class=\"pyflakes-list\">"
}

{
	sub("^"DIR, "", $1)
	sub(/^  */, "", $2)
	sub(/^  */, "", $3)
	
	file = $1
	
	if (file != prevfile) {
		if (prevfile) {
			print "				</ul>"
			print "			</li>"
		}
		print "			<li><code>" $1 "</code>"
		print "				<ul>"
	}
	
	prevfile = file
	
	# Format the error message
	msg = $3
	
	gsub(/'[^']+'/, "<code>&</code>", msg)
	gsub(/<code>'/, "<code>", msg)
	gsub(/'<\/code>/, "</code>", msg)
	
	if (NF > 3) {
		print "					<li class=\"error\"><strong>" $2 "</strong><p>" msg "</p>"
		printf "						<pre><code>"
		
		code = ""
		for (i=4; i<=NF; i++) {
			code = code $i
		}
		
		gsub(SUBSEP, "\n", code)
		
		printf code
		
		print "</code></pre>"
		print"					</li>"
	} else {
		print "					<li class=\"warning\"><strong>"$2"</strong> " msg "</li>"
	}
}

END {
	if (prevfile) {
		print "				</ul>"
		print "			</li>"
	}
	
	print "		</ul>"
	print "		"
	print "		<footer>"
	print "			<p>Generated by <a href=\"http://divmod.org/trac/wiki/DivmodPyflakes\">PyFalkes</a> and <a href=\"http://github.com/garetjax/Cornflakes\">Cornflakes</a></p>"
	print "		</footer>"
	print "	</body>"
	print "</html>"
}
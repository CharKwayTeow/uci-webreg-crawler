#!/usr/bin/python

import urllib2, sys, os, string

def find_between( s, first, last ):
    try:
        start = s.index( first ) + len( first )
        end = s.index( last, start )
        return s[start:end]
    except ValueError:
        return ""

url = 'http://websoc.reg.uci.edu/perl/WebSoc'
webfile = urllib2.urlopen(url).read()

department = sys.argv[1]

if not os.path.exists(department):
    os.makedirs(department)

print 'Begin to download all courses in', department, ':' 

for line in webfile.splitlines():
	if "<option" in line and "value=\"20" in line:
		param = find_between(line, "value=\"", "\" style")
		term = find_between(line, ">", "<")
		query_url = "http://websoc.reg.uci.edu/perl/WebSoc?Submit=Display+Web+Results&YearTerm="+ param + "&Dept=" + department
		response = urllib2.urlopen(query_url).read()
		
		#build file name
		trans = string.maketrans(' ', '_')
		filename = term.translate(trans)

		print term

		#store to html file
		fo = open(department + '/' + filename + ".html", "w+")
		fo.write(response)
		fo.close()

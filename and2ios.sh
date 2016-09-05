#!/bin/bash

FILENAME=$1

awk '
BEGIN{
	FS = "^ *<string *| *>|<\/string>.*$|^ *<!-- *| *--> *$";
}
{
	if (/<string.*name\=\".*\".*>.*<\/string>.*$/){
		match($2, /name *\= *\"[^ ]+\"/)
		name = substr($2, RSTART + 5, RLENGTH - 5)	
		print name " \= \"" $3 "\";"
	}
	else if(/<!--.*-->/)
		print "// "$2;
	else if(/^ *$/)
		print ""
}' $FILENAME
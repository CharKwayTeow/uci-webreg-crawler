#!/usr/bin/env bash

# This is a script to find when a course was opened in past quarters.
# Usage: ./find_course_history.sh department_name course_number
# Example: ./find_course_history.sh COMPSCI 222

department=$1
course=$2
echo "Quarters have course $department $course:"
curl --silent http://websoc.reg.uci.edu/perl/WebSoc | grep '<option value="20' | while read -r line; do
    param=$(echo $line | cut -d'"' -f 2)
    term=$(echo $line | cut -d'>' -f 2 | cut -d'<' -f 1)
    count=$(curl --silent http://websoc.reg.uci.edu/perl/WebSoc\?Submit\=Display+Web+Results\&YearTerm\=$param\&Dept\=$department | grep CourseTitle | grep -c $course)
    if [[ count -gt 0 ]]; then
        echo "$term"
    fi
done
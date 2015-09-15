#!/usr/bin/env bash

# This is a script to download course lists of a department in all quarters.
# Usage: ./download_all_courses_in_a_department.sh department_name
# Example: ./download_all_courses_in_a_department.sh COMPSCI

department=$1
output_directory=$department
rm -rf $output_directory
mkdir $output_directory
echo "Begin to download all courses in $department:"
curl --silent https://www.reg.uci.edu/perl/WebSoc | grep '<option value="20' | while read -r line; do
    param=$(echo $line | cut -d'"' -f 2)
    term=$(echo $line | cut -d'>' -f 2 | cut -d'<' -f 1)
    echo $term
    curl --silent -o $output_directory/$(echo $term | tr ' ' '_').html https://www.reg.uci.edu/perl/WebSoc\?Submit\=Display+Web+Results\&YearTerm\=$param\&Dept\=$department
done
#!/bin/bash
# junitize - convert stdin to junit
# Based on shUnit: https://github.com/akesterson/shunit
# Requires shunit to be installed in order to run
# Usage:
# junitize [-f filename] [-o output file] [-c class name] [-t test name]

INPUT="/dev/stdin"

USAGE="
junitize [-f] [-c] [-t]
Where:   -f|--filename   Input filename
         -c|--classname  Name of test class
         -t|--testname   Name of test
"
# Parse Command Line Arguments
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
	-f|--filename)
	INPUT="$2"
	shift # past argument
	;;
	-c|--classname)
	CLASSNAME="$2"
	shift # past argument
	;;
	-t|--testname)
	TESTNAME="$2"
	shift # past argument
	;;
	*)
	# unknown option
	echo "Unknown Option $2"
	printf "$USAGE"
	exit 1
	;;
esac
shift # past argument or value
done

if [ -z "$CLASSNAME" -o -z "$TESTNAME" ]
then
	echo "Missing Arguments"
	printf "$USAGE"
	exit 1
fi

start=$(date "+%s")


set -e
source /usr/lib/junit.sh
set +e

junit_header

ERR=$(<$INPUT)
ERRFLAG=1

if [ -z "$ERR" ]
then
	ERRFLAG=0
fi

delta=$(($(date "+%s") - $start))
if [[ $ERRFLAG -eq 0 ]]; then
	junit_testcase "$CLASSNAME" "$TESTNAME" "$delta"
else
	SHORTERR=$(echo "$ERR" | head -n 1)
	junit_testcase "$CLASSNAME" "$TESTNAME" "$delta" "Exit ${ERRFLAG}" "$SHORTERR" "${ERR}"
fi

junit_footer

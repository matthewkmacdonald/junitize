#!/bin/bash
# junitize - convert stdin to junit
# Based on shUnit: https://github.com/akesterson/shunit
# Requires shunit to be installed in order to run
# arg 1: The class name
# arg 2: The test name

if [ $# -ne 2 ]
then
	echo "arg 1: class name.  arg 2: test name"
	exit 1
fi


start=$(date "+%s")
CLASSNAME=$1
TESTNAME=$2

set -e
source /usr/lib/junit.sh
set +e

junit_header

ERR=$(</dev/stdin)
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

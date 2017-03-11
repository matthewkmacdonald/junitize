# junitize
Bash script for converting stdout into junit test results.  Useful if you want to integrate bash scripts into your jenkins or bamboo CI environment.  It is based upon a re-working of the [shUnit framework developed by akestesterson](https://github.com/akesterson/shunit)

## Usage
Pipe standard output into junitize to generate a test failure in junit format.
Example:
```
$echo "Hello World" | junitize -c "Test Cases" -t "Hello World Test"
```
Output:
```
<?xml version="1.0" encoding="UTF-8"?>
<testsuite failures="1" time="0" timestamp="Sat Mar 11 13:53:03 PST 2017" errors="1" tests="1">
    <properties/>
    <testcase classname="Test Cases" time="0" name="Hello World Test">
        <failure type="Exit 1" message="Hello World">
            <![CDATA[
Hello World
            ]]>
        </failure>
    </testcase>
</testsuite>
```
If no input was received then junitize outputs success
Example:
```
$echo "" | junitize -c "Test Cases" -t "Hello World Test"
```
Output:
```
<?xml version="1.0" encoding="UTF-8"?>
<testsuite failures="0" time="0" timestamp="Sat Mar 11 13:54:13 PST 2017" errors="0" tests="1">
    <properties/>
    <testcase classname="Test Cases" time="0" name="Hello World Test">
    </testcase>
</testsuite>
```
  
# Installation
  1.  Install shunit: https://github.com/akesterson/shunit
  2.  Install junitize (this).
    `sudo make install`
  3.  run junitize: echo "Hello World" | junitize "Hello World" "Hello World Test"
  
# Background
  Junitize was developed as a way to easily transform logs and other script output into something that could be easily parsed and understood by Jenkins or Bamboo.

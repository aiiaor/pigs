#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

# Test Case: Repository Not Found
if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
output=$(pigs-commit -m "test commit" 2>&1)
expected_output=$(echo "${output}"| grep "error: pigs repository directory .pig not found")
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 1: Passed"
else
  echo "Test Case 1: Failed"
fi

# Setup for the tests
if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
pigs-init
touch testfile1 testfile2


# Test Case: Missing Commit Message
output=$(pigs-commit -a 2>&1)
expected_output=$(echo "${output}"| grep "\[-a\] -m commit-message")
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 2: Passed"
else
  echo "Test Case 2: Failed"
fi

# Test Case: Valid Commit Without -a Flag
pigs-add testfile1
output=$(pigs-commit -m "test commit" 2>&1)
expected_output="Committed as commit 0"
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 3: Passed"
else
  echo "Test Case 3: Failed"
fi

# Test Case: Valid Commit With -a Flag
echo "line 1" > testfile1
output=$(pigs-commit -a -m "test commit" 2>&1)
expected_output="Committed as commit 1"
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 4: Passed"
else
  echo "Test Case 4: Failed"
fi

# Test Case: No File Changes
output=$(pigs-commit -a -m "No changes commit" 2>&1)
expected_output="nothing to commit"
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 5: Passed"
else
  echo "Test Case 5: Failed"
fi

# Test Case: Unrecognized Input
output=$(pigs-commit -x 2>&1)
expected_output=$(echo "${output}"| grep "\[-a\] -m commit-message")
if [ "${output}" = "${expected_output}" ]
then
  echo "Test Case 6: Passed"
else
  echo "Test Case 6: Failed"
fi

if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
rm -f "testfile1" "testfile2"
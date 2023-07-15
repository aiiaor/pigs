#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

# Test Case 1: Repository Not Found
if [ -d ".pig" ]
then
    rm -rf ".pig"
fi
output=$(pigs-rm "test_file.txt" 2>&1)
expected_output=$(echo "${output}"| grep "error: pigs repository directory .pig not found")
if [ "${output}" = "${expected_output}" ]; then
  echo "Test Case 1: Passed"
else
  echo "Test Case 1: Failed"
fi

# Create a repo for further testing
if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
pigs-init
touch testfile1
pigs-add "testfile1"
pigs-commit -m "First Commit"

# Test Case 2: Valid Remove
output=$(pigs-rm testfile1 2>&1)
if [ ! -f testfile1 ] && [ "$output" = "" ]; then
  echo "Test Case 2: Passed"
else
  echo "Test Case 2: Failed"
fi

# Reset repo for further testing
touch testfile1
pigs-add "testfile1"

#Test Case 3: Remove with --cached
output=$(pigs-rm --cached "testfile1" 2>&1)
if [ ! -f ".pig/object/file/testfile1" ] && [ "${output}" = "" ]; then
  echo "Test Case 3: Passed"
else
  echo "Test Case 3: Failed"
fi

pigs-commit -m "Second Commit"

# Test Case 4: None commit with remove cached
output=$(pigs-rm --cached "testfile1" 2>&1)
expected_output=$(echo "${output}"|grep "error: 'testfile1' is not in the pigs repository")
if [ ! -f ".pig/object/file/testfile1" ] && [ "$output" = "${expected_output}" ]; then
  echo "Test Case 4: Passed"
else
  echo "Test Case 4: Failed"
fi

# Reset repo for further testing
echo "Test file content" > ".pig/object/file/testfile1"

# Test Case 5: Remove with --force
output=$(./pigs-rm --force "testfile1" 2>&1)
if [ ! -f "testfile1" ] && [ ! -f ".pig/object/file/testfile1" ] && [ "$output" = "" ]; then
  echo "Test Case 5: Passed"
else
  echo "Test Case 5: Failed"
fi

# Reset repo for further testing
echo "Test file content" > ".pig/object/file/testfile1"
pigs-add "testfile1"

# Test Case 6: File not in repo
rm -f ".pig/object/file/testfile1"
output=$(pigs-rm testfile1 2>&1)
expected_output=$(echo "${output}"| grep "error: 'testfile1' is not in the pigs repository")
if [ "$output" = "$expected_output" ]; then
  echo "Test Case 6: Passed"
else
  echo "Test Case 6: Failed"
fi

# Clean up test
rm -rf ".pig"
rm -f "testfile1"

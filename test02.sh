#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

# Setup for the tests
if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
pigs-init


# Test Case 1: .pig directory does not exist
rm -rf ".pig"
pigs-log
if [ $? -eq 1 ]; then
  echo "Test Case 1 Passed"
else
  echo "Test Case 1 Failed"
fi

# Setup for the next tests
if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
pigs-init
touch testfile1 testfile2
pigs-add "testfile1"
pigs-commit -m "First commit"
pigs-add "testfile2"
pigs-commit -m "Second commit"

# Test Case 2: .pig directory and commits exist
pigs-log | grep -q "First commit"
if [ $? -eq 0 ]; then
  echo "Test Case 2 Passed"
else
  echo "Test Case 2 Failed"
fi

# Test Case 3: commit files are correctly ordered
output=$(mktemp)
expected_output=$(mktemp)
trap 'rm -rf ${output}' INT HUP QUIT TERM EXIT
trap 'rm -rf ${expected_output}' INT HUP QUIT TERM EXIT
pigs-log | cut -d ' ' -f 1 > "$output"
echo "1\n0" > "${expected_output}"
diff "${output}" "${expected_output}"
if [ $? -eq 0 ]; then
  echo "Test Case 3 Passed"
else
  echo "Test Case 3 Failed"
fi


# Cleanup
rm -rf ".pig"
rm "testfile1" "testfile2"
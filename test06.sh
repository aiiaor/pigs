#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

if [ -d ".pig" ]
then
	rm -rf ".pig"
fi

# Test Case 1: Repository Not Found
output=$(pigs-rm "test_file.txt" 2>&1)
expected_output=$(echo "${output}"| grep "error: pigs repository directory .pig not found")
if [ "${output}" = "${expected_output}" ]; then
  echo "Test Case 1: Passed"
else
  echo "Test Case 1: Failed"
fi

pigs-init
touch "testfile1"
# Test Case 2: Untrack
output=$(pigs-status)
expected_output=$(echo "${output}"| grep "testfile1 - untracked")
if [ -n "${expected_output}" ]; then
  echo "Test Case 2: Passed"
else
  echo "Test Case 2: Failed"
fi

# Test Case 3: Add to index
pigs-add "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - added to index")
if [ -n "${expected_output}" ]; then
  echo "Test Case 3: Passed"
else
  echo "Test Case 3: Failed"
fi

# Test Case 4: Add to index, file changed
echo "Line 1" >> "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - added to index, file changed")
if [ -n "${expected_output}" ]; then
  echo "Test Case 4: Passed"
else
  echo "Test Case 4: Failed"
fi

# Test Case 5: Add to index, file delete
rm -f "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - added to index, file deleted")
if [ -n "${expected_output}" ]; then
  echo "Test Case 5: Passed"
else
  echo "Test Case 5: Failed"
fi

# Test Case 6: same as repo
touch "testfile1"
pigs-add "testfile1"
pigs-commit -m "First Commit"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - same as repo")
if [ -n "${expected_output}" ]; then
  echo "Test Case 6: Passed"
else
  echo "Test Case 6: Failed"
fi

# Test Case 7: file changed, changes not staged for commit
echo "Line 1" >> "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - file changed, changes not staged for commit")
if [ -n "${expected_output}" ]; then
  echo "Test Case 7: Passed"
else
  echo "Test Case 7: Failed"
fi

# Test Case 8: file changed, changes staged for commit
pigs-add "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - file changed, changes staged for commit")
if [ -n "${expected_output}" ]; then
  echo "Test Case 8: Passed"
else
  echo "Test Case 8: Failed"
fi

# Test Case 9: file changed, different changes staged for commit
echo "Line 2" >> "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - file changed, different changes staged for commit")
if [ -n "${expected_output}" ]; then
  echo "Test Case 9: Passed"
else
  echo "Test Case 9: Failed"
fi

# Test Case 10: deleted from index
pigs-rm --cached --force "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - deleted from index")
if [ -n "${expected_output}" ]; then
  echo "Test Case 10: Passed"
else
  echo "Test Case 10: Failed"
fi

# Test Case 11: file deleted, deleted from index
rm "testfile1"
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - file deleted, deleted from index")
if [ -n "${expected_output}" ]; then
  echo "Test Case 11: Passed"
else
  echo "Test Case 11: Failed"
fi

# Test Case 12: file deleted, deleted from index
echo "Line 1" >> "testfile1"
pigs-add "testfile1"
rm "testfile1" 
output=$(pigs-status )
expected_output=$(echo "${output}"| grep "testfile1 - file deleted")
if [ -n "${expected_output}" ]; then
  echo "Test Case 12: Passed"
else
  echo "Test Case 12: Failed"
fi

# Test Case 13: file deleted, then commit

output=$(pigs-commit -a -m "Second Commit" )
echo $output
expected_output=$(echo "${output}"| grep "Committed as commit 1")
if [ -n "${expected_output}" ]; then
  echo "Test Case 13: Passed"
else
  echo "Test Case 13: Failed"
fi

rm -rf ".pig"
rm -f "testfile1"
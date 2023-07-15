#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

if [ -d ".pig" ]
then
    rm -rf ".pig"
fi

# Test Case 1: .pig directory exists
pigs-init
pigs-init
if [ $? -eq 1 ]; then
  echo "Test Case 1 Passed"
else
  echo "Test Case 1 Failed"
fi

# Clean up for next test
rm -rf ".pig"

# Test Case 2: .pig directory does not exist
pigs-init
if [ -d ".pig" ] && [ -d ".pig/object" ] && [ -d ".pig/object/file" ] && \
   [ -d ".pig/object/commit" ] && [ -d ".pig/branches" ] && [ -f ".pig/HEAD" ] && \
   grep -q 'ref: refs/heads/master' ".pig/HEAD"
then
  echo "Test Case 2 Passed"
else
  echo "Test Case 2 Failed"
fi

# Clean up after tests
rm -rf ".pig"
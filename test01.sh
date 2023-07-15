#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"



# Test Case 1: .pig directory does not exist
echo "Start test"
pigs-add testfile1
if [ $? -eq 1 ]; then
  echo "Test Case 1 Passed"
else
  echo "Test Case 1 Failed"
fi

if [ -d ".pig" ]
then
  rm -rf ".pig"
fi
pigs-init

# Test Case 2: file exists in the current directory
echo "Test data" > testfile2
pigs-add testfile2
if [ -f ".pig/object/file/testfile2" ]; then
  echo "Test Case 2 Passed"
else
  echo "Test Case 2 Failed"
fi

# Test Case 3: file does not exist in the current directory, but exists in .pig/object/file/
rm "testfile2"
pigs-add "testfile2"
if [ ! -f ".pig/object/file/testfile2" ]; then
  echo "Test Case 3 Passed"
else
  echo "Test Case 3 Failed"
fi

# Test Case 4: file does not exist in the current directory or .pig/object/file/
pigs-add "testfile3"
if [ $? -eq 1 ]; then
  echo "Test Case 4 Passed"
else
  echo "Test Case 4 Failed"
fi

# Test Case 5: .pig/index file handling
echo "Test data" > "testfile4"
pigs-add "testfile4"
if grep -q "testfile4" .pig/index; then
  echo "Test Case 5 Passed"
else
  echo "Test Case 5 Failed"
fi

# Cleanup
rm -rf ".pig"
rm "testfile4"
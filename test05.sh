#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

if [ -d ".pig" ]
then
    rm -rf ".pig"
fi

pigs-init

# test without input
pigs-show
if [ $? -eq 1 ]; then
    echo "Test 1 Passed"
else
    echo "Test 1 Failed"
fi

# test with incorrect number of inputs
pigs-show arg1 arg2
if [ $? -eq 1 ]; then
    echo "Test 2 Passed"
else
    echo "Test 2 Failed"
fi

# create a sample commit folder and file
echo "Sample Text" > testfile1
pigs-add "testfile1"
pigs-commit -m "First Commit"

# test with correct commit id and filename
pigs-show 0:testfile1
if [ $? -eq 0 ]; then
    echo "Test 3 Passed"
else
    echo "Test 3 Failed"
fi

# test with incorrect commit id
pigs-show 1:sample
if [ $? -eq 1 ]; then
    echo "Test 4 Passed"
else
    echo "Test 4 Failed"
fi

# test with incorrect file name
pigs-show 0:wrong
if [ $? -eq 1 ]; then
    echo "Test 5 Passed"
else
    echo "Test 5 Failed"
fi

# test with filename only (index file)
pigs-show :testfile1
if [ $? -eq 0 ]; then
    echo "Test 6 Passed"
else
    echo "Test 6 Failed"
fi

# test with incorrect filename (index file)
pigs-show :wrong
if [ $? -eq 1 ]; then
    echo "Test 7 Passed"
else
    echo "Test 7 Failed"
fi

# leave test directory and clean up

rm -rf ".pig"
rm -f "testfile1"

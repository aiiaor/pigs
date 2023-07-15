#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

if [ -d ".pig" ]
then
    rm -rf ".pig"
fi

# Delete no .pig case
pigs-branch -d "dev"
if [ $? -eq 1 ]; then
    echo "Test 1 Passed"
else
    echo "Test 1 Failed"
fi

pigs-init

touch "testfile1"

# Create branch without commit
pigs-branch "dev"
if [ $? -eq 1 ]; then
    echo "Test 2 Passed"
else
    echo "Test 2 Failed"
fi

pigs-add "testfile1"
pigs-commit -m "First Commit"

# Happy case
pigs-branch "dev"
if [ $? -eq 0 ]; then
    echo "Test 3 Passed"
else
    echo "Test 3 Failed"
fi


# Delete case
pigs-branch -d "dev"
if [ $? -eq 0 ]; then
    echo "Test 4 Passed"
else
    echo "Test 4 Failed"
fi

# Delete master branch
pigs-branch -d "master"
if [ $? -eq 1 ]; then
    echo "Test 5 Passed"
else
    echo "Test 5 Failed"
fi

# Delete one exist branch
pigs-branch -d "dev"
if [ $? -eq 1 ]; then
    echo "Test 6 Passed"
else
    echo "Test 6 Failed"
fi

# Create exist branch
pigs-branch "dev"
pigs-branch "dev"
if [ $? -eq 1 ]; then
    echo "Test 7 Passed"
else
    echo "Test 7 Failed"
fi


# leave test directory and clean up

rm -rf ".pig"
rm -f "testfile1"

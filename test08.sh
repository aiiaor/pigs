#!/bin/dash

current_path=$(pwd)
PATH="$PATH:${current_path}"

if [ -d ".pig" ]
then
    rm -rf ".pig"
fi

# Delete no .pig case
pigs-checkout "dev"
if [ $? -eq 1 ]; then
    echo "Test 1 Passed"
else
    echo "Test 1 Failed"
fi


pigs-init

touch "testfile1"

# Create branch without commit
pigs-checkout "dev" 
if [ $? -eq 1 ]; then
    echo "Test 2 Passed"
else
    echo "Test 2 Failed"
fi

pigs-add "testfile1"
pigs-commit -m "First Commit"
pigs-branch "dev"

# Happy case
pigs-checkout "dev"
if [ $? -eq 0 ]; then
    echo "Test 3 Passed"
else
    echo "Test 3 Failed"
fi


# Wrong input
pigs-checkout "dev" "master"
if [ $? -eq 1 ]; then
    echo "Test 4 Passed"
else
    echo "Test 4 Failed"
fi

# On specific branch
pigs-checkout "dev"
if [ $? -eq 0 ]; then
    echo "Test 5 Passed"
else
    echo "Test 5 Failed"
fi

# Checkout unknown branch
pigs-checkout "dev2"
if [ $? -eq 1 ]; then
    echo "Test 6 Passed"
else
    echo "Test 6 Failed"
fi

# Changed data that overwrite
touch "testfile2"
pigs-add "testfile2"
pigs-commit -m "commit-2"
pigs-checkout "master"
echo "Line2">"testfile2"
pigs-add "testfile2"
pigs-checkout "dev"
if [ $? -eq 1 ]; then
    echo "Test 7 Passed"
else
    echo "Test 7 Failed"
fi

# Changed data that overwrite and delete cache
pigs-rm --cached "testfile2"
pigs-checkout "dev"
if [ $? -eq 1 ]; then
    echo "Test 8 Passed"
else
    echo "Test 8 Failed"
fi

# Changed data that overwrite and remove all testfile2 file
rm "testfile2"
pigs-checkout "dev"
if [ $? -eq 0 ]; then
    echo "Test 9 Passed"
else
    echo "Test 9 Failed"
fi



# clean up and set new case

rm -rf ".pig"
rm -f "testfile1"
rm -f "testfile2"

#rm force overwritten file
pigs-init
touch "testfile1"
pigs-add "testfile1"
pigs-commit -m "First Commit"
pigs-branch "dev"
pigs-checkout "dev"
touch "testfile2"
pigs-add "testfile2"
pigs-commit -m "commit-2"
pigs-checkout "master"
echo "Line2">"testfile2"
pigs-add "testfile2"
pigs-rm --force "testfile2"
pigs-checkout "dev"
if [ $? -eq 0 ]; then
    echo "Test 10 Passed"
else
    echo "Test 10 Failed"
fi

# clean up and set new case
rm -rf ".pig"
rm -f "testfile1"
rm -f "testfile2"

#rm force cache overwritten file
pigs-init
touch "testfile1"
pigs-add "testfile1"
pigs-commit -m "First Commit"
pigs-branch "dev"
pigs-checkout "dev"
touch "testfile2"
pigs-add "testfile2"
pigs-commit -m "commit-2"
pigs-checkout "master"
echo "Line2">"testfile2"
pigs-add "testfile2"
pigs-rm --force --cached "testfile2"
pigs-checkout "dev"
if [ $? -eq 1 ]; then
    echo "Test 11 Passed"
else
    echo "Test 11 Failed"
fi

# clean up 
rm -rf ".pig"
rm -f "testfile1"
rm -f "testfile2"
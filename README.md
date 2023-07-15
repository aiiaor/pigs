# Pigs: POSIX Implementation of Git in Shell

## Description
Pigs is a version control system, inspired by Git, implemented in POSIX Shell (dash). This project has been developed as an assignment for university, to help improve shell programming skills and provide a clear understanding of Git's core semantics. The purpose of Pigs is to replicate a simplified version of Git, implementing a subset of its most important commands. 

## Features

- **pigs-init:** This command creates an empty Pigs repository.
- **pigs-add:** The pigs-add command adds the contents of one or more files to the index.
- **pigs-commit:** The pigs-commit command saves a copy of all files in the index to the repository.
- **pigs-log:** The pigs-log command prints a line for every commit made to the repository.
- **pigs-show:** The pigs-show command prints the contents of the specified filename as of the specified commit.
- **pigs-rm:** pigs-rm removes a file from the index, or, from the current directory and the index.
- **pigs-status:** pigs-status shows the status of files in the current directory, the index, and the repository.
- **pigs-branch:** pigs-branch either creates a branch, deletes a branch, or lists current branch names.
- **pigs-checkout:** pigs-checkout switches branches.

## Usage
Examples of how to use the Pigs commands can be found in the original assignment text, including examples for each subset of commands. 

## Implementation
Pigs is implemented in POSIX-compatible Shell (dash). Early versions of Git made heavy use of Shell and Perl, thus providing a valuable learning experience by diving into the shell scripting world and understanding Git's core semantics. 

## Contributing
As this is an academic project, contributions will not be accepted. This repository is designed to demonstrate my ability to implement a version control system in POSIX Shell. 

## Disclaimer
Pigs is a simplified version of Git, designed for educational purposes. It is not intended for managing real-world, production codebases. The use of Pigs in such environments is discouraged. 

## Author
Boonjira Angsumalee

## Acknowledgments
Special thanks to my university and professors for providing the assignment and the guidance necessary to complete this project.


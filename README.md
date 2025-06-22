# Advanced Shell Scripts for AWS EC2

This repository contains advanced-level shell scripts designed to interact with AWS EC2 and automate common DevOps tasks.

## 📁 Folder: `aws-ec2-scripts`

This folder includes various Bash scripts to:
- Manage EC2 instances
- Automate resource creation
- Perform operational tasks efficiently

These scripts are written with modularity, error-handling, and real-world AWS usage in mind.

> ⚠️ **Note:** AWS CLI must be configured before using these scripts.

## 🚀 Requirements
- AWS CLI configured (`aws configure`)
- IAM credentials with EC2 permissions
- Bash / Linux environment

## 🛠️ Makefile Included

You can now use the included `Makefile` to quickly run, test, lint, or clean your scripts.

### 🔧 Available Commands:
```bash
make run     # Run all scripts in scripts/ folder
make test    # Execute test suite (e.g. test_all.sh)
make lint    # Run ShellCheck linter
make clean   # Remove temporary files

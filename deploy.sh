#!/bin/sh

# If a command fails then the deploy stops
set -e

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Add changes to git.
git add .

# Commit changes.
git commit -m "$msg"

# pull to be fresh:
git pull -r

cd public

git pull -r

cd ..

# Build the project.
hugo -t ananke # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
git commit -m "$msg"

# Push source and build repos.
git push origin master

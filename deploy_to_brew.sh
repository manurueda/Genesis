#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print success messages
success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print error messages
error() {
    echo -e "${RED}$1${NC}"
}

# Check if required commands are available
for cmd in git curl shasum; do
    if ! command -v $cmd &> /dev/null; then
        error "$cmd is not installed. Please install $cmd and try again."
        exit 1
    fi
done

# Get the current version from setup.py
current_version=$(grep -oP "(?<=version=')\d+\.\d+" setup.py)

# Increment the version number
IFS='.' read -r major minor <<< "$current_version"
new_version="$major.$((minor + 1))"

# Tag the new version
git tag -a "v$new_version" -m "Release version $new_version"
git push origin "v$new_version"

# Download the new tarball
tarball_url="https://github.com/manurueda/Genesis/archive/refs/tags/v$new_version.tar.gz"
curl -L $tarball_url -o genesis.tar.gz

# Calculate the SHA256 checksum
sha256=$(shasum -a 256 genesis.tar.gz | awk '{ print $1 }')

# Update the Homebrew formula
formula_path="homebrew-genesis/genesis.rb"
sed -i '' "s|url \".*\"|url \"$tarball_url\"|" $formula_path
sed -i '' "s|sha256 \".*\"|sha256 \"$sha256\"|" $formula_path

# Commit and push the changes to the Homebrew tap repository
cd homebrew-genesis
git add genesis.rb
git commit -m "Update Genesis to version $new_version"
git push origin main
cd ..

# Clean up
rm genesis.tar.gz

success "Deployment to Homebrew completed successfully!"
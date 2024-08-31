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

# Get the current version from the formula file
current_version=$(grep -Eo 'url "https://github.com/manurueda/Genesis/archive/refs/tags/v[0-9]+\.[0-9]+\.[0-9]+"' genesis.rb | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')

# Increment the patch version
IFS='.' read -r -a version_parts <<< "$current_version"
version_parts[2]=$((version_parts[2] + 1))
new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"

# Update the formula file with the new version
sed -i '' "s|v$current_version|v$new_version|g" genesis.rb

# Commit the changes
git add genesis.rb
git commit -m "Bump version to v$new_version"
git tag "v$new_version"
git push origin main --tags

# Deploy to Homebrew
brew update
brew install --build-from-source ./genesis.rb

success "Deployment to Homebrew completed successfully!"
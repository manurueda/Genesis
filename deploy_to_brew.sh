#!/bin/bash

# Set your author details
AUTHOR_NAME="Manu Rueda"
AUTHOR_EMAIL="jm.glezderueda@gmail.com"

# Set the version as a parameter
VERSION=${1:-"0.1.15"}  # Default to 0.1.15 if no version is provided

# Hard-coded details
PACKAGE_NAME="genesis"
DESCRIPTION="Project Genesis: The Dawn of Autonomous Code Evolution"
PYTHON_VERSION="^3.12"

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

# Function to print info messages
info() {
    echo -e "${NC}$1${NC}"
}

# Check if required commands are available
for cmd in git curl shasum; do
    if ! command -v $cmd &> /dev/null; then
        error "$cmd is not installed. Please install $cmd and try again."
        exit 1
    fi
done

# Extract the last version from the git tags
info "Extracting the last version from git tags..."
latest_version=$(git tag | grep -E 'v[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)
current_version="${latest_version:1}"

if [ -z "$current_version" ]; then
    error "No valid version found in git tags."
    exit 1
fi
info "Current version: $current_version"

# Loop to find a non-existent version
while true; do
    IFS='.' read -r -a version_parts <<< "$current_version"
    version_parts[2]=$((version_parts[2] + 1))
    new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"

    # Check if the tag already exists
    if git rev-parse "v$new_version" >/dev/null 2>&1; then
        info "Tag v$new_version already exists. Trying the next version..."
        current_version=$new_version
    else
        break
    fi
done

info "New version: $new_version"

# Update pyproject.toml with new version and author
info "Updating pyproject.toml with new version and author..."
sed -i '' "s/^version = .*/version = \"$new_version\"/" pyproject.toml
sed -i '' "s/^authors = .*/authors = [\"$AUTHOR_NAME <$AUTHOR_EMAIL>\"]/" pyproject.toml

# Generate requirements.txt
info "Generating requirements.txt..."
poetry export -f requirements.txt --output requirements.txt --without-hashes

# Commit the changes
info "Committing changes to git..."
git add pyproject.toml requirements.txt
git commit -m "Bump version to v$new_version"

# Create and push the new tag
info "Creating and pushing new git tag..."
git tag "v$new_version"
git push origin main --tags

# Wait for GitHub to recognize the tag
info "Waiting for GitHub to recognize the tag..."
sleep 10  # Wait 10 seconds to give GitHub time to process the new tag

# Recalculate the SHA256 checksum after downloading the tarball
info "Recalculating SHA256 checksum..."
tarball_url="https://github.com/manurueda/Genesis/archive/refs/tags/v$new_version.tar.gz"
rm -f "genesis-$new_version.tar.gz"  # Remove any previous download
curl -L -o "genesis-$new_version.tar.gz" "$tarball_url"

# Verify the file was downloaded correctly before proceeding
if [ ! -f "genesis-$new_version.tar.gz" ]; then
    error "Failed to download tarball."
    exit 1
fi

# Calculate the new SHA256 checksum
sha256=$(shasum -a 256 "genesis-$new_version.tar.gz" | awk '{ print $1 }')
info "SHA256 checksum: $sha256"

# Create a new genesis.rb from the template
info "Creating new genesis.rb from template..."
mkdir -p Formula
sed "s/{{VERSION}}/$new_version/g; s/{{SHA256}}/$sha256/g" genesis_template.rb > Formula/genesis.rb

# Commit the Formula changes
info "Committing Formula changes to git..."
git add Formula/genesis.rb
git commit -m "Update Formula for v$new_version"
git push origin main

# Deploy to Homebrew
info "Deploying to Homebrew..."
brew update
brew tap manurueda/genesis https://github.com/manurueda/genesis.git
brew install --build-from-source Formula/genesis.rb

# Verify the SHA256 checksum
info "Verifying SHA256 checksum..."
expected_sha256=$(grep -Eo 'sha256 "[a-f0-9]{64}"' Formula/genesis.rb | grep -Eo '[a-f0-9]{64}')
actual_sha256=$(shasum -a 256 "genesis-$new_version.tar.gz" | awk '{ print $1 }')

if [ "$expected_sha256" != "$actual_sha256" ]; then
    error "SHA256 mismatch: expected $expected_sha256, got $actual_sha256"
    exit 1
fi

success "Deployment to Homebrew completed successfully!"

#!/bin/bash
NEW_VERSION="0.1.1"  # Replace with your desired version number

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
echo "Extracting current version from genesis.rb..."
current_version=$(grep -Eo 'url "https://github.com/manurueda/Genesis/archive/refs/tags/v[0-9]+\.[0-9]+\.[0-9]+"' genesis.rb | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
if [ -z "$current_version" ]; then
    error "Failed to extract current version from genesis.rb"
    exit 1
fi
echo "Current version: $current_version"

# Increment the patch version
IFS='.' read -r -a version_parts <<< "$current_version"
version_parts[2]=$((version_parts[2] + 1))
new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"
echo "New version: $new_version"

# Download the new tarball
tarball_url="https://github.com/manurueda/Genesis/archive/refs/tags/v$new_version.tar.gz"
echo "Downloading tarball from $tarball_url..."
curl -L -o "genesis-$new_version.tar.gz" "$tarball_url"

# Calculate the SHA256 checksum
echo "Calculating SHA256 checksum..."
sha256=$(shasum -a 256 "genesis-$new_version.tar.gz" | awk '{ print $1 }')
echo "SHA256 checksum: $sha256"

# Create a new genesis.rb from the template
echo "Creating new genesis.rb from template..."
sed "s|{{VERSION}}|$new_version|g; s|{{SHA256}}|$sha256|g" genesis_template.rb > genesis.rb

# Check if pyproject.toml exists
if [ ! -f pyproject.toml ]; then
    error "pyproject.toml not found. Please ensure the file exists."
    exit 1
fi

# Update version in pyproject.toml
echo "Updating pyproject.toml with new version..."
sed -i '' "s/version = .*/version = \"$NEW_VERSION\"/" pyproject.toml

# Commit the changes
echo "Committing changes to git..."
git add pyproject.toml genesis.rb
git commit -m "Bump version to v$NEW_VERSION"

# Check if the tag already exists
if git rev-parse "v$NEW_VERSION" >/dev/null 2>&1; then
    error "Tag v$NEW_VERSION already exists. Please update the version number."
    exit 1
fi

# Create and push the new tag
echo "Creating and pushing new git tag..."
git tag "v$NEW_VERSION"
git push origin main --tags

# Deploy to Homebrew
echo "Deploying to Homebrew..."
brew update
brew install --build-from-source ./genesis.rb

success "Deployment to Homebrew completed successfully!"
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

# Check if Python 3.12 is installed
if ! command -v python3.12 &> /dev/null; then
    error "Python 3.12 is not installed. Please install Python 3.12 and try again."
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    error "pip3 is not installed. Please install pip3 and try again."
    exit 1
fi

# Create a virtual environment
python3.12 -m venv genesis_env
source genesis_env/bin/activate

# Install the required packages
pip3 install -r requirements.txt

# Install the Genesis package globally
pip3 install -e .

# Test the installation
if command -v genesis &> /dev/null; then
    success "Genesis has been successfully installed globally!"
    success "You can now use the 'genesis' command from anywhere."
    success "Try 'genesis --help' to see available commands."
else
    error "Something went wrong. Genesis couldn't be installed globally."
    exit 1
fi

# Deactivate the virtual environment
deactivate

# Add update option
echo "Do you want to check for updates? (y/n)"
read check_updates

if [[ $check_updates == "y" || $check_updates == "Y" ]]; then
    update_genesis
fi

success "Installation complete. You may need to restart your terminal for changes to take effect."

update_genesis() {
    success "Checking for updates..."
    pip3 install --upgrade project-genesis
    success "Update complete. You may need to restart your terminal for changes to take effect."
}
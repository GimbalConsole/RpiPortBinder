#!/bin/bash

# Function to check if Python is installed
check_python_installed() {
    if command -v python3 &>/dev/null; then
        echo "Python is already installed"
        return 0
    else
        return 1
    fi
}

# Function to install Python
install_python() {
    echo "Updating package list..."
    sudo apt-get update

    echo "Installing Python..."
    sudo apt-get install -y python3 python3-pip

    echo "Python installation completed"
}

# Main script logic
if check_python_installed; then
    echo "Skipping installation"
else
    install_python
fi

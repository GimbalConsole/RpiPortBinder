#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH=$PATH:"$SCRIPT_DIR"

# Define the source and destination paths
SOURCE_PATH="autorun.sh"
DEST_PATH="/etc/init.d/autorun.sh"

# Function to add the script to crontab for autorun at startup
add_to_crontab() {
    crontab -l | grep -q "@reboot $DEST_PATH" 2>/dev/null
    if [ $? -eq 1 ]; then
        (crontab -l 2>/dev/null; echo "@reboot $DEST_PATH") | crontab -
        echo "Script added to crontab for autorun at startup."
    else
        echo "Script is already set to run at startup."
    fi
}

# Check if the file exists at the destination path
if [ ! -f "$DEST_PATH" ]; then
    echo "File not found at $DEST_PATH. Copying it from $SOURCE_PATH."
    sudo cp "$SOURCE_PATH" "$DEST_PATH"
    sudo chmod +x "$DEST_PATH"
    echo "File copied to $DEST_PATH and made executable."
else
    echo "File already exists at $DEST_PATH."
fi

# Add to crontab
add_to_crontab

# Main functionality of the script
echo "Setup complete!"

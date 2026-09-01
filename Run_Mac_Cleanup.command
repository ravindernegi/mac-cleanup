#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting Mac cleanup..."
echo ""

chmod +x "$SCRIPT_DIR/mac_cleanup.zsh"
"$SCRIPT_DIR/mac_cleanup.zsh"

echo ""
echo "Cleanup finished."
read -p "Press Enter to close..."
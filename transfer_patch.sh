#!/bin/bash
# iOS Activation Bypass - Transfer Patched mobileactivationd File

echo "=========================================="
echo "Transferring Patched Activation File"
echo "=========================================="
echo ""

# Configuration
SSH_PORT="2222"
SSH_HOST="127.0.0.1"
SSH_USER="root"
SSH_PASS="alpine"
PATCH_FILE="mobileactivationd"
DEST_PATH="/usr/libexec/mobileactivationd"

# Check if patch file exists
if [ ! -f "$PATCH_FILE" ]; then
    echo "[✗] Error: $PATCH_FILE not found in current directory"
    exit 1
fi

echo "[*] Transferring patched mobileactivationd..."
echo "    Source: ./$PATCH_FILE"
echo "    Destination: $DEST_PATH"
echo ""

# Check if sshpass is available
if command -v sshpass &> /dev/null; then
    echo "[*] Using sshpass for automated transfer"
    sshpass -p "$SSH_PASS" scp -O -P "$SSH_PORT" -o StrictHostKeyChecking=no "$PATCH_FILE" "${SSH_USER}@${SSH_HOST}:${DEST_PATH}"
else
    echo "[*] Enter password when prompted"
    echo "    Password: alpine"
    scp -O -P "$SSH_PORT" -o StrictHostKeyChecking=no "$PATCH_FILE" "${SSH_USER}@${SSH_HOST}:${DEST_PATH}"
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✓ Patch File Transferred Successfully!"
    echo "=========================================="
    echo ""
    echo "NEXT STEP:"
    echo "  Go back to your SSH session and run:"
    echo "  ./finalize_bypass.sh"
    echo ""
else
    echo ""
    echo "[✗] Transfer failed!"
    echo ""
    echo "Manual transfer method:"
    echo "  scp -O -P 2222 mobileactivationd root@127.0.0.1:/usr/libexec/mobileactivationd"
    echo "  Password: alpine"
    echo ""
    exit 1
fi

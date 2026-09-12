#!/bin/bash
# iOS Activation Bypass - Automated File Transfer Script for Linux/macOS
# This script transfers all necessary files to the jailbroken device

echo "=========================================="
echo "iOS Activation Bypass - File Transfer"
echo "=========================================="
echo ""

# Configuration
SSH_PORT="2222"
SSH_HOST="127.0.0.1"
SSH_USER="root"
SSH_PASS="alpine"  # Default checkra1n password

# Files to transfer
DEVICE_SCRIPTS=("bypass_device.sh" "finalize_bypass.sh")
PATCH_FILE="mobileactivationd"

echo "[*] This script will transfer files to the jailbroken device"
echo "[*] Make sure iproxy is running in another terminal!"
echo ""
echo "Prerequisites:"
echo "  - iproxy running (use ./setup_proxy.sh)"
echo "  - Device jailbroken with Checkra1n"
echo "  - Device at WiFi selection screen"
echo ""
read -p "Press Enter to continue or Ctrl+C to cancel..."
echo ""

# Check if sshpass is available for automated transfer
if command -v sshpass &> /dev/null; then
    USE_SSHPASS=true
    echo "[*] Using sshpass for automated transfer"
else
    USE_SSHPASS=false
    echo "[*] sshpass not found - you'll need to enter password manually"
    echo "    (Install with: sudo apt install sshpass)"
fi
echo ""

# Function to transfer file
transfer_file() {
    local file=$1
    local dest=$2

    echo "[*] Transferring $file to $dest..."

    if [ "$USE_SSHPASS" = true ]; then
        sshpass -p "$SSH_PASS" scp -O -P "$SSH_PORT" -o StrictHostKeyChecking=no "$file" "${SSH_USER}@${SSH_HOST}:${dest}"
    else
        echo "    Password: alpine"
        scp -O -P "$SSH_PORT" -o StrictHostKeyChecking=no "$file" "${SSH_USER}@${SSH_HOST}:${dest}"
    fi

    if [ $? -eq 0 ]; then
        echo "[✓] $file transferred successfully"
    else
        echo "[✗] Failed to transfer $file"
        return 1
    fi
}

# Transfer device scripts
echo "Step 1: Transferring bypass scripts..."
echo "--------------------------------------"
for script in "${DEVICE_SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        transfer_file "$script" "/var/root/$script" || exit 1
    else
        echo "[✗] File not found: $script"
        exit 1
    fi
done
echo ""

# Make scripts executable
echo "Step 2: Making scripts executable..."
echo "--------------------------------------"
if [ "$USE_SSHPASS" = true ]; then
    sshpass -p "$SSH_PASS" ssh -p "$SSH_PORT" -o StrictHostKeyChecking=no "${SSH_USER}@${SSH_HOST}" "chmod +x /var/root/*.sh"
else
    echo "Password: alpine"
    ssh -p "$SSH_PORT" -o StrictHostKeyChecking=no "${SSH_USER}@${SSH_HOST}" "chmod +x /var/root/*.sh"
fi

if [ $? -eq 0 ]; then
    echo "[✓] Scripts made executable"
else
    echo "[✗] Failed to set permissions"
    exit 1
fi
echo ""

echo "=========================================="
echo "✓ Phase 1 Complete!"
echo "=========================================="
echo ""
echo "NEXT STEPS:"
echo ""
echo "1. SSH into the device:"
echo "   ssh root@127.0.0.1 -p 2222"
echo "   (Password: alpine)"
echo ""
echo "2. Run the bypass script:"
echo "   cd /var/root"
echo "   ./bypass_device.sh"
echo ""
echo "3. Transfer the patched file:"
echo "   (On your host machine, in a new terminal)"
echo "   ./transfer_patch.sh"
echo ""
echo "4. Finalize the bypass:"
echo "   (Back in the SSH session)"
echo "   ./finalize_bypass.sh"
echo ""
echo "5. On the device, tap 'Connect to iTunes'"
echo ""

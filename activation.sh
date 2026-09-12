#!/bin/bash
cd $(dirname "$0")

sed '/localhost]:2222/d' ~/.ssh/known_hosts |  sed '/127.0.0.1]:2222/d' > ~/.ssh/known_hosts_tmp
mv ~/.ssh/known_hosts_tmp ~/.ssh/known_hosts

killall iproxy >& /dev/null

./setup_proxy.sh > /dev/null & sleep 3

if pgrep -l iproxy > /dev/null; then
    echo "[*] Starting iProxy..."
else
    echo "[!] No device detected. Please connect your jailbroken device."
    echo ""
    exit 1
fi

if command -v sshpass &> /dev/null; then
    USE_SSHPASS=true
    echo "[*] Using sshpass for automated transfer"
else
    USE_SSHPASS=false
    echo "[*] sshpass not found - you'll need to enter password manually"
fi

if [ "$USE_SSHPASS" = true ]; then
    sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "
        mount -o rw,union,update / &&
        launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist &&
        rm /usr/libexec/mobileactivationd &&
        uicache --all
    "

    sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/usr/libexec/mobileactivationd" < ./mobileactivationd

    sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p2222 root@localhost "
        chmod 755 /usr/libexec/mobileactivationd &&
        launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
        uicache --all
    "
else
    echo "Enter Password: alpine"
    ssh -o StrictHostKeyChecking=no -p2222 root@localhost "
        mount -o rw,union,update / &&
        launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist &&
        rm /usr/libexec/mobileactivationd &&
        uicache --all
    "

    echo "Enter Password: alpine"
    ssh -o StrictHostKeyChecking=no -p2222 root@localhost "dd of=/usr/libexec/mobileactivationd" < ./mobileactivationd

    echo "Enter Password: alpine"
    ssh -o StrictHostKeyChecking=no -p2222 root@localhost "
        chmod 755 /usr/libexec/mobileactivationd &&
        launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
        uicache --all
    "
fi

killall iproxy > /dev/null

echo "All done"
echo "FINAL STEP:"
echo "On the device, tap 'Connect to iTunes' at the bottom"
echo "of the 'Choose a Wi-Fi Network' page to complete the bypass."

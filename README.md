# iOS_ActivationBypass
iOS Activation Bypass Instructions for A7 Devices (Confirmed working on iPad Air Gen 1 - iOS 12.5.6)

- Jailbreak with Checkra1n 0.10.2
  - Alternatively use Bootra1n 10.2
- This can be a VERY finicky process with freezing at the 'Right Before Trigger (this is the real bug setup)'.  
  - Unplug the iDevice after ~15-20 seconds of the screen showing 'Right Before Trigger...' then plug the iDevice back in after 1-2 seconds.  You should see a 'Booting Up' message immediately after plugging the device back in.  If you don't you'll likely have to start all over with checkra!n.  If you keep failing you can try and restore the iOS firmware in iTunes and start over again.

- Boot to Windows

- Download libimobiledevice: https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip

- Extract zip and open powershell window in directory

- Start iProxy: **.\iproxy.exe 22 44**
  - 22 is the local masquerade port
  - 44 is the port SSH is running on on the iDevice

- Open a new powershell window
- Type: **ssh root@127.0.0.1**
  - Password: **alpine**

- Open WinSCP
  - Connect via SCP to 127.0.0.1
    - User: root
    - Password: alpine
 
- On the iDevice, continue to the 'Chose a Wi-Fi Netowrk' screen but DO NOT connect

- In the SSH Powershell console enter the following commands in order:
    **mount -o rw,union,update /
    launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
    rm /usr/libexec/mobileactivationd
    uicache --all**
    
- In WinSCP Transfer the mobileactivationd file to the directory **/usr/libexec/**
  - Full path should be: **/usr/libexec/mobileactivationd**
  
- Once complete enter the following commands in order:
    **chmod 755 /usr/libexec/mobileactivationd
    launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist**
    
- Finally chose 'Connect to iTunes' on the bottom of the 'Chose a Wi-Fi Network' page to complete bypass

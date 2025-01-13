## iOS Activation Bypass Instructions for A7 Devices ##
### Confirmed Working Devices ###
- iOS 12.5.6
  - iPad Air Gen 1 (As of 10/27/2022)
- iOS 12.5.7
  - iPad Mini 3 (As of 01/13/2025 - Thanks to [adamk324](<https://github.com/adamk324> "adamk324"))
  
### Jailbreak the iDevice ###
- Jailbreak with Checkra1n 0.10.2 
  - https://checkra.in/releases/0.10.2-beta#all-downloads
- Alternatively use Bootra1n 10.2
  - https://github.com/foxlet/bootra1n
- This can be a VERY finicky process with freezing at the 'Right Before Trigger (this is the real bug setup)'.  
  - Unplug the iDevice after ~15-20 seconds of the screen showing 'Right Before Trigger...' then plug the iDevice back in after 1-2 seconds.  You should see a 'Booting Up' message immediately after plugging the device back in.  If you don't you'll likely have to start all over with checkra!n.  If you keep failing you can try and restore the iOS firmware in iTunes and start over again.

### Bypass iCloud Activation ###
- Boot to Windows

- Download libimobiledevice
  - https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip

- Extract zip and open a Powershell window in the extracted directory
- Start iProxy
  ```
  .\iproxy.exe 22 44
  ```
  - 22 is the local masquerade port
  - 44 is the port SSH is running on on the iDevice (SSH on the iDevice is 44 per Checkra1n docs)

- Open a second powershell window
- Type: **ssh root@127.0.0.1**
  - Password: **alpine**

- Open WinSCP
  - Connect via SCP to 127.0.0.1
    - User: root
    - Password: alpine
 
- On the iDevice, continue to the 'Chose a Wi-Fi Netowrk' screen but **DO NOT** connect

- In the SSH Powershell console enter the following commands in order:
    ```
    mount -o rw,union,update /
    launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
    rm /usr/libexec/mobileactivationd
    uicache --all
    ```
- In WinSCP Transfer the mobileactivationd file to the directory **/usr/libexec/**
  - Full path should be: **/usr/libexec/mobileactivationd**
  
- Once complete enter the following commands in order:
    ```
    chmod 755 /usr/libexec/mobileactivationd
    launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
    ```
    
- Finally chose 'Connect to iTunes' on the bottom of the 'Chose a Wi-Fi Network' page to complete bypass
 
 
  
<sub> These directions were pulled from many sources and compiled by me, the steps and patched mobileactivationd file for the iCloud bypass were extracted from [iOS-Hacktivation](https://github.com/Hacktivation/iOS-Hacktivation-Toolkit/tree/master/bypass_scripts/mobileactivationd_12_4_7).  Many thanks to the talented individuals that create these tools! </sub>

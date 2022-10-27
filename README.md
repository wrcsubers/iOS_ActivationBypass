# iOS_ActivationBypass
iOS Activation Bypass Instructions for A7 Devices (up to iOS 12.5.6)

- Jailbreak with Checkra1n 0.10.2
  - Alternatively use Bootra1n 10.2 (I had more luck with this one)

- Boot to Windows

- Download libimobiledevice: https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip

- Extract zip and open powershell window in directory

- Start iProxy: .\iproxy.exe 22 44
  - 22 is the local masquerade port
  - 44 is the port SSH is running on on the iDevice

- Open a new powershell window
- Type: ssh root@127.0.0.1
  - Password: alpine

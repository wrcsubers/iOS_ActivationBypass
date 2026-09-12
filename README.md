# iOS Activation Bypass for A7 Devices

> **Quick Start:** See [PRESENTATION_GUIDE.md](PRESENTATION_GUIDE.md) for a streamlined demo workflow

## Table of Contents
- [Supported Devices](#supported-devices)
- [Quick Start](#quick-start)
- [Detailed Instructions](#detailed-instructions)
  - [Step 1: Jailbreak](#step-1-jailbreak-the-device)
  - [Step 2: Setup Windows Environment](#step-2-setup-windows-environment)
  - [Step 3: Bypass Activation](#step-3-bypass-activation)
- [Automation Scripts](#automation-scripts)
- [Troubleshooting](#troubleshooting)

---

## Supported Devices

### iOS 12.5.6
- ✅ iPad Air Gen 1 (As of 10/27/2022)

### iOS 12.5.7
| Device | Model | Confirmed Date | Contributor |
|--------|-------|---------------|-------------|
| iPad Mini 3 | - | 01/13/2025 | [adamk324](https://github.com/adamk324) |
| iPad Mini 2 | - | 02/26/2025 | [ManiProjs](https://github.com/ManiProjs) |
| iPad Air | - | 04/07/2025 | [VSjnk](https://github.com/VSjnk) |
| iPhone 5s | - | 04/13/2025 | [daodov](https://github.com/daodov) |
| iPhone 6 | - | 09/08/2025 | [lamduck2005](https://github.com/lamduck2005) |
| iPhone 6 Plus | A1522 | 07/29/2025 | [R3p1ns](https://github.com/R3p1ns) |
| iPad Air Gen 1 | A1475 | 09/27/2025 | [elvisef](https://github.com/elvisef) |

---

## Quick Start

### Prerequisites
- A7 device (iPhone 5s, 6, 6 Plus, iPad Air, iPad Mini 2/3)
- Computer running Windows, Linux, or macOS
- USB cable

### Overview
```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  Jailbreak  │ ──> │ Setup Proxy  │ ──> │   Bypass    │
│  (Checkra1n)│     │  (Any OS)    │     │ Activation  │
└─────────────┘     └──────────────┘     └─────────────┘
```

### Automated Method - Linux/macOS (Recommended)
1. **Jailbreak** with Checkra1n 0.10.2
2. **Run** setup and transfer scripts:
   ```bash
   ./activation.sh
   ```
   Or use a step-by-step approach：
   ```bash
   # Terminal 1: Start proxy
   ./setup_proxy.sh

   # Terminal 2: Transfer files and bypass
   ./transfer_files.sh
   ssh root@127.0.0.1 -p 2222  # Password: alpine
   cd /var/root && ./bypass_device.sh

   # Terminal 3: Transfer patch
   ./transfer_patch.sh

   # Back in Terminal 2 SSH session
   ./finalize_bypass.sh
   ```
4. **Complete** by tapping "Connect to iTunes"

### Automated Method - Windows
1. **Jailbreak** with Checkra1n 0.10.2
2. **Run** `setup_proxy.ps1` in PowerShell
3. **Use WinSCP** to transfer files and follow on-screen instructions
4. **Complete** by tapping "Connect to iTunes"

---

## Detailed Instructions

### Step 1: Jailbreak the Device

**Download Checkra1n:**
- **Recommended:** [Checkra1n 0.10.2](https://checkra.in/releases/0.10.2-beta#all-downloads)
- **Alternative:** [Bootra1n 10.2](https://github.com/foxlet/bootra1n) (Bootable USB option)

**Jailbreak Process:**
1. Connect device to computer
2. Run Checkra1n and follow on-screen instructions
3. Device will enter DFU mode

**Important Troubleshooting:**
> ⚠️ **Known Issue:** Freezing at "Right Before Trigger (this is the real bug setup)"
>
> **Solution:**
> - Wait ~15-20 seconds at the "Right Before Trigger..." screen
> - Unplug the device
> - Wait 1-2 seconds
> - Plug device back in
> - You should immediately see "Booting Up"
> - If not, restart the jailbreak process
> - If repeated failures occur, restore iOS firmware in iTunes and retry

---

### Step 2: Setup Host Environment

Choose your operating system:

---

#### **Linux / macOS Setup**

**Install libimobiledevice:**

Ubuntu/Debian:
```bash
sudo apt update
sudo apt install libusbmuxd-tools libimobiledevice-utils
```

Fedora/RHEL:
```bash
sudo dnf install libusbmuxd-utils libimobiledevice-utils
```

Arch Linux:
```bash
sudo pacman -S libusbmuxd libimobiledevice
```

macOS (with Homebrew):
```bash
brew install libusbmuxd libimobiledevice
```

**Optional (for automated file transfer):**
```bash
# Ubuntu/Debian
sudo apt install sshpass

# Fedora/RHEL
sudo dnf install sshpass

# macOS
brew install hudochenkov/sshpass/sshpass
```

**Start Proxy:**
```bash
./setup_proxy.sh
```
Keep this terminal open!

---

#### **Windows Setup**

**Download Required Tools:**
1. **libimobiledevice** - [Download v1.3.17](https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip)
2. **WinSCP** - For file transfer to device

**Setup:**
1. Extract `libimobiledevice.1.2.1-r1122-win-x64.zip`
2. Open PowerShell in the extracted directory

**Option A: Automated (Recommended)**
```powershell
.\setup_proxy.ps1
```

**Option B: Manual**
```powershell
.\iproxy.exe 22 44
```
- Port 22 = Local masquerade port
- Port 44 = SSH port on device (Checkra1n default)

**Keep this PowerShell window open!**

---

### Step 3: Bypass Activation

**On Device:**
Navigate to "Choose a Wi-Fi Network" screen
> ⚠️ **DO NOT connect to WiFi yet**

---

#### **Method A: Linux/macOS Automated (Recommended)**

**Terminal 1** (already running from Step 2):
```bash
./setup_proxy.sh  # Keep this running
```

**Terminal 2** - Transfer files and start bypass:
```bash
# Transfer bypass scripts to device
./transfer_files.sh

# SSH into device
ssh root@127.0.0.1 -p 2222
# Password: alpine

# On device, run bypass script
cd /var/root
./bypass_device.sh
# Leave this SSH session open
```

**Terminal 3** - Transfer patched file:
```bash
./transfer_patch.sh
```

**Back in Terminal 2** (SSH session):
```bash
# Finalize the bypass
./finalize_bypass.sh
```

**On Device:**
Tap "Connect to iTunes" at bottom of WiFi screen ✓

---

#### **Method B: Windows Automated**

**Connect to Device:**

Open a **second PowerShell window** and connect via SSH:
```powershell
ssh root@127.0.0.1
```
**Password:** `alpine`

**Setup WinSCP:**
- Protocol: SCP
- Host: `127.0.0.1`
- User: `root`
- Password: `alpine`

1. **Transfer scripts to device** via WinSCP:
   - `bypass_device.sh` → `/var/root/`
   - `finalize_bypass.sh` → `/var/root/`

2. **In SSH session, run:**
   ```bash
   cd /var/root
   chmod +x bypass_device.sh finalize_bypass.sh
   ./bypass_device.sh
   ```

3. **Transfer patched file** via WinSCP:
   - Transfer `mobileactivationd` to `/usr/libexec/mobileactivationd`

4. **Finalize bypass:**
   ```bash
   ./finalize_bypass.sh
   ```

5. **On device:** Tap "Connect to iTunes" at bottom of WiFi screen

---

#### **Method C: Manual Commands (Any OS)

**Phase 1 - Prepare Device:**
```bash
mount -o rw,union,update /
launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
rm /usr/libexec/mobileactivationd
uicache --all
```

**Phase 2 - Transfer File:**
- Using WinSCP, transfer `mobileactivationd` to `/usr/libexec/mobileactivationd`

**Phase 3 - Finalize:**
```bash
chmod 755 /usr/libexec/mobileactivationd
launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
```

**Complete:**
- On device, tap "Connect to iTunes" at bottom of "Choose a Wi-Fi Network" screen

---

## Automation Scripts

This repository includes automation scripts to streamline the bypass process:

| Script | Platform | Purpose |
|--------|----------|---------|
| `setup_proxy.sh` | Linux/macOS | Automatically starts iProxy with correct ports |
| `setup_proxy.ps1` | Windows | Automatically starts iProxy with correct ports |
| `transfer_files.sh` | Linux/macOS | Transfers bypass scripts to device |
| `transfer_patch.sh` | Linux/macOS | Transfers patched mobileactivationd to device |
| `bypass_device.sh` | Device (SSH) | Automates Phase 1 commands |
| `finalize_bypass.sh` | Device (SSH) | Automates Phase 3 commands |

**Benefits:**
- ✅ Cross-platform support (Windows, Linux, macOS)
- ✅ Reduces human error
- ✅ Faster execution
- ✅ Visual progress indicators
- ✅ Error checking at each step
- ✅ Automated file transfer (Linux/macOS)

---

## Troubleshooting

### Checkra1n Freezes
- See [Step 1 troubleshooting](#step-1-jailbreak-the-device)

### Cannot Connect via SSH
- Ensure iProxy is running
- Verify device is jailbroken (Checkra1n app should be visible)
- Try reconnecting USB cable
- Restart iProxy

### Permission Denied Errors
- Ensure you're logged in as `root`
- Check that filesystem is mounted read-write: `mount -o rw,union,update /`

### Device Won't Complete Bypass
- Verify `mobileactivationd` was transferred to correct location: `/usr/libexec/mobileactivationd`
- Check file permissions: `ls -la /usr/libexec/mobileactivationd` (should show `-rwxr-xr-x`)
- Try restarting device and re-running finalization script

## Credits & Attribution

These instructions were compiled from multiple sources. Special thanks to:

- **[iOS-Hacktivation](https://github.com/Hacktivation/iOS-Hacktivation-Toolkit/)** - Source of the patched `mobileactivationd` binary
- **Checkra1n Team** - Jailbreak tool
- **libimobiledevice Project** - Device communication libraries
- **Community Contributors** - All those who tested and confirmed device compatibility

---

## Legal Notice

This tool is for educational and research purposes only. Use only on devices you own or have explicit permission to modify. Bypassing activation locks on devices you don't own may be illegal in your jurisdiction.

---

## Repository Structure

```
iOS_ActivationBypass/
├── README.md                      # Complete documentation
├── PRESENTATION_GUIDE.md          # Quick reference for demos
├── mobileactivationd              # Patched activation daemon binary
├── libimobiledevice.*.zip         # Windows libimobiledevice tools
│
├── Linux/macOS Scripts:
│   ├── setup_proxy.sh             # Start iProxy (Linux/macOS)
│   ├── transfer_files.sh          # Auto-transfer bypass scripts
│   └── transfer_patch.sh          # Auto-transfer patched file
│
├── Windows Scripts:
│   └── setup_proxy.ps1            # Start iProxy (Windows)
│
└── Device Scripts (Run via SSH):
    ├── bypass_device.sh           # Phase 1: Prepare device
    └── finalize_bypass.sh         # Phase 3: Complete bypass
```

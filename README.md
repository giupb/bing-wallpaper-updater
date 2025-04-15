# 🌅 Bing Wallpaper Updater (macOS)

Automatically fetch and set the daily Bing wallpaper as your desktop background on macOS. Uses `launchd` to run once per day.

---

## 🚀 Features

- Downloads the daily Bing wallpaper in UHD
- Sets it as your macOS desktop background
- Runs automatically every day at a chosen time
  
---

## 📦 Requirements

- macOS
- `curl` (pre-installed)
- [`jq`](https://stedolan.github.io/jq/) — install with:
  ```bash
  brew install jq
  ```

---

## 🛠 Installation

### 1. Clone this repository
```bash
git clone https://github.com/giupb/bing-wallpaper-updater.git
cd bing-wallpaper-updater
```

### 2. Copy the script
```bash
mkdir -p ~/Scripts
cp update_bing_wallpaper.sh ~/Scripts/
chmod +x ~/Scripts/update_bing_wallpaper.sh
```

📸 Optional: Test it manually

You can manually run the script to see if it works:
```bash
bash ~/Scripts/update_bing_wallpaper.sh
```

---

### 3. Copy and configure the LaunchAgent plist
```bash
cp com.github.giupb.bing-wallpaper-updater.plist ~/Library/LaunchAgents/
```

Then edit the `.plist` to point to your script:
```xml
<string>/Users/YOUR_USERNAME/Scripts/update_bing_wallpaper.sh</string>
```
> Replace `YOUR_USERNAME` with your actual macOS username.

---

## 📅 Schedule the script with launchd

### Load the job:
```bash
launchctl load ~/Library/LaunchAgents/com.github.giu.bingwallpaper.plist
```

### Unload if needed:
```bash
launchctl unload ~/Library/LaunchAgents/com.github.giu.bingwallpaper.plist
```

---

## 📂 Folder Structure
- The downloaded wallpapers are saved in:
  ```
  ~/Pictures/Bing Wallpapers
  ```
- A `.last_wallpaper_update` file is used to prevent re-downloading the same wallpaper in a single day.

---

## 🐞 Logs
By default, standard output and errors are written to:
```bash
/tmp/bingwallpaper.out
/tmp/bingwallpaper.err
```

---

Enjoy fresh Bing wallpapers every day! 🌅


# Bing Daily Wallpaper for macOS

Automatically updates your macOS wallpaper once a day using Bing's daily image.

This script and launch agent will:
- Download Bing's daily wallpaper in UHD
- Save it in your `~/Pictures/Bing Wallpapers/` folder with the correct title
- Set it as your desktop wallpaper (for all spaces)
- Run automatically each day at 7:30 AM or when you wake your Mac — but only once per day

---

## 📁 Repository Contents

- `change_wallpaper.sh`: The shell script that downloads and sets the wallpaper.
- `com.user.wallpaper-change.plist`: A `launchd` job configuration file to automate the script daily.

---

## ⚙️ Setup Instructions

1. **Move the Files to the Appropriate Locations**

   ```bash
   mkdir -p ~/Library/Scripts
   mkdir -p ~/Library/LaunchAgents
   ```

   Then move the files:

   ```bash
   mv change_wallpaper.sh ~/Library/Scripts/
   mv com.user.wallpaper-change.plist ~/Library/LaunchAgents/
   ```

2. **Edit File Paths in Both Files**

   - Open the `.plist` file in a text editor:
     ```bash
     open -a TextEdit ~/Library/LaunchAgents/com.user.wallpaper-change.plist
     ```
     Update the `<string>` under `ProgramArguments` to reflect the correct path:
     ```xml
     <string>/Users/your-username/Library/Scripts/change_wallpaper.sh</string>
     ```

   - Open the `.sh` file in a text editor:
     ```bash
     open -a TextEdit ~/Library/Scripts/change_wallpaper.sh
     ```
     And update the two variables at the top:
     ```bash
     LAST_UPDATE_FILE="/Users/your-username/Library/Application Support/BingWallpaper/.last_wallpaper_update"
     WALLPAPER_FOLDER_PATH="/Users/your-username/Pictures/Bing Wallpapers"
     ```

3. **Make Sure the Script is Executable**

   ```bash
   chmod +x ~/Library/Scripts/change_wallpaper.sh
   ```

4. **Load the Launch Agent**

   This tells macOS to start watching for when to run the script:

   ```bash
   launchctl load ~/Library/LaunchAgents/com.user.wallpaper-change.plist
   ```

   To verify it's running:
   ```bash
   launchctl list | grep wallpaper-change
   ```

---

## ✅ Notes

- The script ensures the wallpaper is changed **only once per day**, even if the Mac wakes up multiple times.
- If you want to test it manually:
  ```bash
  bash ~/Library/Scripts/change_wallpaper.sh
  ```

---

Enjoy fresh Bing wallpapers every day! 🌅


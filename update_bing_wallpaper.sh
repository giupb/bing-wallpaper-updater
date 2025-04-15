#!/bin/bash

# update_bing_wallpaper.sh
# Downloads and sets Bing's daily wallpaper as your macOS desktop background
# Dependencies: curl, jq, osascript (macOS built-in)

# Define user-agnostic wallpaper folder
WALLPAPER_DIR="$HOME/Pictures/Bing Wallpapers"
mkdir -p "$WALLPAPER_DIR"

# File to track the last update date
LAST_UPDATE_FILE="$WALLPAPER_DIR/.last_wallpaper_update"
current_date=$(date +"%Y-%m-%d")

# Read the last update date
if [ -f "$LAST_UPDATE_FILE" ]; then
    last_update=$(cat "$LAST_UPDATE_FILE")
else
    last_update="none"
fi

# Only proceed if the wallpaper hasn't been updated today
if [ "$last_update" != "$current_date" ]; then
    # Fetch Bing Wallpaper JSON
    API_URL="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"
    json_response=$(curl -s "$API_URL")

    # Extract image URL base and title using jq
    image_url_base=$(echo "$json_response" | jq -r '.images[0].urlbase')
    image_title=$(echo "$json_response" | jq -r '.images[0].title')

    # Construct full image URL
    image_url="https://bing.com${image_url_base}_UHD.jpg"

    # Define file path
    safe_title=$(echo "$image_title" | tr -cd '[:alnum:] ._-')
    save_path="$WALLPAPER_DIR/${safe_title}.jpg"

    # Download the image
    curl -s "$image_url" -o "$save_path"

    # Set the image as wallpaper
    osascript -e "
    tell application \"System Events\"
        tell every desktop
            set picture to \"$save_path\"
        end tell
    end tell
    "

    # Check if the wallpaper was actually changed
    current_wallpaper=$(osascript -e '
    tell application "System Events"
        tell desktop 1
            return picture
        end tell
    end tell
    ')

    if [ "$current_wallpaper" == "$save_path" ]; then
        # Update the last update date
        echo "$current_date" > "$LAST_UPDATE_FILE"
        echo "Wallpaper updated successfully!"
    else
        echo "Warning: Wallpaper change failed!"
    fi
else
    echo "Wallpaper already updated today!"
fi
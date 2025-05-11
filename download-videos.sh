#!/bin/bash

INPUT_FILE="C:/final_cleaned_hamza_courses.txt"

while IFS= read -r line || [[ -n "$line" ]]; do
  # Extract file name and video ID
  video_name="${line%% - *}"
  video_id="${line##* - }"

  # Replace slashes or other special characters in file name
  safe_name=$(echo "$video_name" | tr -cd '[:alnum:] ._-')

  echo "Downloading: $safe_name.mp4 (ID: $video_id)"

  # Run the Node.js script
  node ./loom-downloader/loom-dl.js --url "https://www.loom.com/share/$video_id" --out "$safe_name.mp4"

  # Sleep 10-60 seconds
  sleep_time=$((RANDOM % 51 + 10))
  echo "Sleeping for $sleep_time seconds..."
  sleep $sleep_time

done < "$INPUT_FILE"

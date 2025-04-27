#!/bin/bash

# List of some example random websites
urls=(
  "https://www.google.com"
  "https://www.youtube.com"
  "https://www.wikipedia.org"
  "https://www.reddit.com"
  "https://www.twitter.com"
  "https://www.facebook.com"
  "https://www.amazon.com"
  "https://www.instagram.com"
  "https://www.netflix.com"
  "https://www.github.com"
  "https://www.medium.com"
  "https://www.bbc.com"
  "https://www.cnn.com"
  "https://www.nytimes.com"
  "https://www.stackoverflow.com"
  "https://www.quora.com"
  "https://www.twitch.tv"
  "https://www.apple.com"
  "https://www.microsoft.com"
  "https://www.spotify.com"
  "https://www.pinterest.com"
  "https://www.reddit.com"
  "https://www.linkedin.com"
  "https://www.flickr.com"
  "https://www.ebay.com"
  "https://www.cnet.com"
  "https://www.washingtonpost.com"
  "https://www.theguardian.com"
  "https://www.nationalgeographic.com"
  "https://www.buzzfeed.com"
  "https://www.scribd.com"
  "https://www.tumblr.com"
  "https://www.vox.com"
  "https://www.sciencedaily.com"
  "https://www.espn.com"
  "https://www.forbes.com"
)

# Open 35 random websites in Safari
for i in {1..35}
do
  random_index=$(($RANDOM % ${#urls[@]}))
  open -a "Safari" "${urls[$random_index]}"
done

echo "Opened 35 random websites in Safari!"

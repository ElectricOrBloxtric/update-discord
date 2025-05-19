#!/bin/bash

latest_version=$(curl -s "https://discord.com/api/updates/stable?platform=linux" | jq -r '.name')

build_info="/usr/share/discord/resources/build_info.json"

if [ ! -f "$build_info" ]; then
    echo "Error: $build_info not found."
    exit 1
fi

tmp_file=$(mktemp)

jq --arg ver "$latest_version" '.version = $ver' "$build_info" > "$tmp_file" && sudo mv "$tmp_file" "$build_info"

echo "Updated Discord version in build_info.json to $latest_version"

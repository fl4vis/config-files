#!/bin/bash

echo "🔄 Syncing config files from system to repo..."

cp ~/.bashrc ./.bashrc
cp ~/.starship.toml ./.starship.toml

rsync -av --delete ~/.config/tmux/ ./tmux/
rsync -av --delete ~/.config/nvim/ ./nvim/
rsync -av --delete ~/.config/hypr/ ./hypr/

rsync -av --delete ~/.config/yazi/ ./yazi/


echo "✅ Done syncing. Now committing..."

git add .
git commit -m "Sync config changes"
git push origin main

echo "🚀 Changes pushed to GitHub"

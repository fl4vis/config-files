#!/bin/bash

echo "🔄 Syncing config files from system to repo..."

cp ~/.bashrc ./.bashrc
cp ~/.config/tmux ./tmux
cp ~/.config/nvim ./nvim

echo "✅ Done syncing. Now committing..."

git add .
git commit -m "Sync config changes"
git push origin main

echo "🚀 Changes pushed to GitHub"

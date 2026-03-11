
# The "Safety First" Maintenance Script
# Arch-based systems like CachyOS are fast, but they can be fragile if you don't clean up after updates. This script performs a "Deep Clean" and a BTRFS snapshot in one go.


#!/bin/bash
# 1. Update Mirrors for fastest speed
echo "Updating mirrors..."
sudo cachyos-rate-mirrors

# 2. Update System
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# 3. Clean Package Cache (keep only last 2 versions)
echo "Cleaning cache..."
sudo paccache -r
sudo paccache -rk2

# 4. Remove Orphaned Packages
echo "Removing orphans..."
sudo pacman -Rs $(pacman -Qdtq) --noconfirm

# 5. Create a Pre-Work Snapshot (Requires Timeshift)
echo "Creating BTRFS snapshot..."
sudo timeshift --create --comments "Post-Maintenance Cleanup" --tags D

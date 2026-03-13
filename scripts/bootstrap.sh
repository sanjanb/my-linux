#!/bin/bash

# --- 🚀 CachyOS + HyDE + AI/ML Bootstrap Script ---
echo "Starting the ultimate CachyOS setup..."

# 1. Update Mirrors and System
echo "Updating mirrors for maximum speed..."
sudo cachyos-rate-mirrors
sudo pacman -Syu --noconfirm

# 2. Essential Hardware & ROG Tools
echo "Setting up ASUS ROG specific tools..."
sudo pacman -S --needed asusctl supergfxctl rog-control-center power-profiles-daemon --noconfirm
sudo systemctl enable --now supergfxd

# 3. Development & AI/ML Stack
echo "Installing AI/ML toolchain (UV, CUDA, Ollama)..."
sudo pacman -S cuda cudnn btop nvtop git base-devel ghostty zellij zoxide fzf eza starship --noconfirm
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://ollama.com/install.sh | sh

# 4. Content Creation Stack (Wayland Native)
echo "Installing Content Creation tools..."
sudo pacman -S obs-studio xdg-desktop-portal-hyprland helvum pipewire-pulse --noconfirm
# Optional: yay -S davinci-resolve shutter-encoder-bin (AUR)

# 5. Create Local Scripts Directory
mkdir -p ~/scripts
cat << 'EOF' > ~/scripts/monitor_handler.sh
#!/bin/bash
handle() {
  case $1 in
    monitoradded*) hyprctl keyword monitor "HDMI-A-1, preferred, -1920x0, 1" ;;
    monitorremoved*) hyprctl keyword monitor "eDP-1, preferred, 0x0, 1.25" ;;
  esac
}
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
EOF
chmod +x ~/scripts/*.sh

# 6. HyDE Project Installation
echo "Downloading and Installing HyDE (Hyprland Desktop Environment)..."
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
cd ~/HyDE/Scripts
./install.sh

echo "✅ BOOTSTRAP COMPLETE. Please reboot to enjoy your new system."

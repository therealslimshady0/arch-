#!/bin/bash

# Ensure services start on boot (user-specific services)
services_user=(
    "pipewire"
    "wireplumber"
    "xdg-desktop-portal"
    "xdg-desktop-portal-wlr"
)

# Ensure services start on boot (system-wide services)
services_system=(
    "bluetooth.service"
    "docker.service"
    "NetworkManager.service"
)

# Ensure virtualization services are enabled
virt_services=(
    "libvirtd.service"
    "virtqemud.service"
    "virtqemud-ro.socket"
    "virtqemud-admin.socket"
    "virtinterfaced.service"
    "virtinterfaced.socket"
    "virtnetworkd.service"
    "virtnetworkd.socket"
    "virtnodedevd.service"
    "virtnodedevd.socket"
    "virtnwfilterd.service"
    "virtnwfilterd.socket"
    "virtsecretd.service"
    "virtsecretd.socket"
    "virtstoraged.service"
    "virtstoraged.socket"
    "virtstoraged-admin.socket"
)

# User services
for service in "${services_user[@]}"; do
    systemctl --user enable "$service"
    systemctl --user start "$service"
done

# System services
for service in "${services_system[@]}"; do
    sudo systemctl enable "$service"
    sudo systemctl start "$service"
done

# Virtualization services
for service in "${virt_services[@]}"; do
    sudo systemctl enable "$service"
    sudo systemctl start "$service"
done

# Launch GUI components (e.g., sway, waybar, or custom environment setup)
if pgrep -x sway > /dev/null; then
    echo "Sway is already running."
else
    sway &
    echo "Launching Sway..."
fi

# Example: Custom startup commands for GUI environment
echo "Starting custom GUI components..."
wofi &  # Wofi launcher
dunst & # Notification daemon
wl-clipboard &  # Clipboard manager
yambar & # Status bar
swaybg -i ~/.config/backgrounds/default.png &  # Set wallpaper

#!/bin/bash

# Zorg ervoor dat het script alleen wordt uitgevoerd met root-rechten
if [ "$(id -u)" -ne 0 ]; then
  echo "Dit script moet worden uitgevoerd als root (gebruik sudo)."
  exit 1
fi

# apt update, duh
echo "Pakketlijst wordt geüpdatet..."
apt update

# Librewolf repo
echo "LibreWolf repository wordt toegevoegd..."
echo "deb [signed-by=/usr/share/keyrings/librewolf.asc] https://deb.librewolf.net bullseye main" > /etc/apt/sources.list.d/librewolf.list

# Librewolf GPG key
wget -qO - https://deb.librewolf.net/librewolf.asc | tee /usr/share/keyrings/librewolf.asc

# apt update, duh
echo "Pakketlijst wordt opnieuw geüpdatet..."
apt update
echo "apt update voltooid"

# Installeer LibreWolf
echo "LibreWolf wordt geïnstalleerd..."
apt install -y librewolf
echo "Librewolf is geinstalleerd"

# VSCodium repo toevoegen
echo "VSCodium repository wordt toegevoegd..."
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscodium.list

# GPG-key
wget -qO - https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc

# apt update, duh
echo "Pakketlijst wordt opnieuw geüpdatet..."
apt update

#  VSCodium
echo "VSCodium wordt geïnstalleerd..."
apt install -y codium
echo "VSCodium is gedownload"

# vesktop
echo "Vesktop wordt gedownload..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.vencord.Vesktop
echo "Vesktop flatpak is gedownload"

# lutris
echo "Lutris flatpak wordt geinstalleerd..."
flatpak install flathub --user -y net.lutris.Lutris
echo "Lutris flatpak is geinstalleerd"

# heroic games launcher
echo "Heroic Games Launcher wordt geinstalleerd"
flatpak install flathub com.heroicgameslauncher.hgl
echo "Heroic Games Launcher is geinstalleerd"

# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# signal desktop
# signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# Signal repo toevoegen
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

# apt update en installeren
apt update && apt install signal-desktop

# proton pass (zeer goede install, ik weet het)
echo "Installeer proton pass. Weet niet hoe het moet met terminal, dus moet maar zo :)"

# brave browser 
echo "Brave browser wordt gedownload..."
curl -fsS https://dl.brave.com/install.sh | sh
echo "Brave is gedownload, checksum check:"
echo curl -fsSLO "https://dl.brave.com/install.sh{,.asc}" && gpg --keyserver hkps://keys.openpgp.org --recv-keys D16166072CACDF2C9429CBF11BF41E37D039F691 && gpg --verify install.sh.asc

#flatseal
echo "Flatseal flatpak..."
flatpak install flathub com.github.tchx84.Flatseal
echo "Flatseal gedownload"

# skyblock
echo "Minecraft, skyclient.co"

# Dingen gewoon in apt
echo "Steam etc wordt gedownload..."
apt install -y steam audacity virtualbox gimp mangohud goverlay protontricks winetricks neofetch
#!/bin/bash

url="https://discord.com/api/download?platform=linux&format=deb"
filename=$(basename "$url" | sed 's/\?.*//')

# Download Discord .deb file
wget "$url" -O "$filename"

if [ $? -eq 0 ]; then
    sudo dpkg -i "$filename"
    sudo apt-get install -f
    
    rm "$filename"
    
    echo "Installing Vencord..."

    wget -O vencord-installer.sh https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh
    
    if [ $? -eq 0 ]; then
        bash vencord-installer.sh
        
        rm vencord-installer.sh
        
        echo "Vencord installation complete."
    else
        echo "Vencord installation script download failed."
        exit 1
    fi
    
else
    echo "Download of Discord failed. Exiting."
    exit 1
fi

#!/bin/bash
CONFIG_FILE="config.json"
script_name=$(basename "$0" .sh) 

# Leer la lista de paquetes desde JSON
packages=$(jq -r '.${script_name}[]' "$CONFIG_FILE")

if [[ -z "$packages" ]]; then
    echo "[SYS]: No packages to install."
else
    echo "[SYS]: Installing packages..."
    sudo apt update
    for pkg in $packages; do
        #sudo apt install -y "$pkg"
        echo "[SYS]: Installed $pkg"
    done
    echo "[SYS]: Packages installed successfully."
fi

#!/bin/bash

CONFIG_FILE="../config"

# Leer la configuración actual
onscreen_keyboard=$(grep "^onscreen_keyboard=" "$CONFIG_FILE" | cut -d '=' -f2)

if [[ "$onscreen_keyboard" == "enabled" ]]; then
    echo "[SYS]: Enabling on-screen keyboard..."
    #sudo apt install -y onboard  # Instala el teclado en pantalla
else
    echo "[SYS]: Disabling on-screen keyboard..."
    #sudo apt remove -y onboard  # Desinstala el teclado en pantalla
fi

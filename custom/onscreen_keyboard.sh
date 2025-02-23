#!/bin/bash

CONFIG_FILE="../config.json"
script_name=$(basename "$0" .sh)  # Obtener el nombre del script sin la extensión .sh

# Leer la configuración actual
#value=$(jq -r ".${script_name}.value" "$CONFIG_FILE")
#
#if [[ "$value" == "enabled" ]]; then
#    echo "[SYS]: Enabling on-screen keyboard..."
#    #sudo apt install -y onboard  # Instala el teclado en pantalla
#else
#    echo "[SYS]: Disabling on-screen keyboard..."
#    #sudo apt remove -y onboard  # Desinstala el teclado en pantalla
#fi

echo $script_name

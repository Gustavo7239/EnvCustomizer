#!/bin/bash

CONFIG_FILE="config"

# Modo debug: se activa si se pasa "y" como argumento
debug_mode="n"
if [[ "$1" == "y" ]]; then
    debug_mode="y"
    echo "[DEBUG]: Debug mode enabled."
fi

# Si el modo debug está activado, actualiza el repositorio si es un proyecto Git
if [[ "$debug_mode" == "y" ]]; then
    if [ -d ".git" ]; then
        echo "[DEBUG]: Updating repository..."
        git pull
        echo "[SYS]: Repository updated successfully."
    else
        echo "[DEBUG]: No Git repository detected."
    fi
fi

# Preguntar al usuario si desea inicializar la personalización
read -p "Initialize customization? (y/n): " start_customize
if [[ "$start_customize" == "y" ]]; then
    echo "customized"
else
    echo "not customized"
fi
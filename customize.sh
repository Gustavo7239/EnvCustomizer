#!/bin/bash

CONFIG_FILE="config.json"

# Verificar si jq está instalado
if ! command -v jq &> /dev/null; then
    echo "[ERROR]: jq is not installed. Installing it now..."
    sudo apt update && sudo apt install -y jq
fi

# Verificar si el archivo config.json existe
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "[ERROR]: No config.json found. Please create one and try again."
    exit 1
fi

echo "[SYS]: Configuration file detected. Loading settings..."

# Recorrer todas las configuraciones del JSON
jq -r 'keys[]' "$CONFIG_FILE" | while read -r key; do
    enabled=$(jq -r ".${key}.enabled" "$CONFIG_FILE")
    applied=$(jq -r ".${key}.applied" "$CONFIG_FILE")

    echo "[SYS]: $key → Enabled: $enabled | Applied: $applied"
done

# Ejecutar personalizaciones individuales si están habilitadas y no aplicadas
for script in custom/*.sh; do
    sudo chmod +x "$script"
    
    if [[ -x "$script" ]]; then
        script_name=$(basename "$script" .sh)
        
        # Verificar si la configuración está habilitada y no aplicada
        script_enabled=$(jq -r ".${script_name}.enabled" "$CONFIG_FILE")
        script_applied=$(jq -r ".${script_name}.applied" "$CONFIG_FILE")
        
        if [[ "$script_enabled" == "true" && "$script_applied" == "false" ]]; then
            echo "[SYS]: Running $script..."
            "$script"
            
            # Marcar la configuración como aplicada en config.json
            jq ".${script_name}.applied = true" "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"
            jq ".${script_name}.enabled = false" "$CONFIG_FILE" > temp.json && mv temp.json "$CONFIG_FILE"
        else
            echo "[SYS]: Skipping $script (disabled or already applied)"
        fi
    else
        echo "[WARN]: Skipping $script (not executable)"
    fi
done

echo "[SYS]: Full customization complete."

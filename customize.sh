#!/bin/bash

CONFIG_FILE="config"

# Verificar si el archivo config existe
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "[SYS]: No config file found. Creating one..."
    echo "onscreen_keyboard=disabled" > "$CONFIG_FILE"
    echo "customized_packages=" >> "$CONFIG_FILE"
else
    echo "[SYS]: Config file detected. Checking for missing settings..."
fi

# Función para agregar una clave al archivo si no existe
update_config() {
    key=$1
    value=$2
    if ! grep -q "^$key=" "$CONFIG_FILE"; then
        echo "$key=$value" >> "$CONFIG_FILE"
        echo "[SYS]: Added missing setting: $key=$value"
    fi
}

read -p "Will this system be monted on touchscreen? (y/n): " touchscreen_bool
if [[ "$touchscreen_bool" == "y" ]]; then
    update_config "onscreen_keyboard" "enabled"
else
    update_config "onscreen_keyboard" "disable"
fi

# Verificar y agregar configuraciones faltantes
update_config "customized_packages" ""

echo "[SYS]: Configuration base complete."


# Ejecutar personalizaciones individuales
for script in custom/*.sh; do
    sudo chmod +x $script
    if [[ -x "$script" ]]; then
        echo "[SYS]: Running $script..."
        "$script"
    else
        echo "[WARN]: Skipping $script (not executable)"
    fi
done

echo "[SYS]: Full customization complete."

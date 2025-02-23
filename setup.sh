#!/bin/bash

CONFIG_FILE="config"

read -p "Inicializar la customizacion? (y/n): " enable_keyboard
if [[ "$enable_keyboard" == "s" ]]; then
    update_config "onscreen_keyboard" "enabled"
else
    update_config "onscreen_keyboard" "disabled"
fi
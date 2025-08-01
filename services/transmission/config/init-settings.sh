#!/bin/bash

SETTINGS=/config/settings.json

# Esperar a que se genere settings.json si no existe aún
while [ ! -f "$SETTINGS" ]; do
    echo "Esperando a que se genere $SETTINGS..."
    sleep 1
done

# Sobrescribir solo las 2 líneas necesarias
jq '. += {
  "script-torrent-done-enabled": true,
  "script-torrent-done-filename": "/config/posttorrent.sh"
}' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"

# Continuar con el proceso original
exec /init

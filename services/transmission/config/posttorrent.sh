#!/bin/bash
set -e
set -u
set -o pipefail

LOG_FILE="/config/posttorrent.log"
exec >> "$LOG_FILE" 2>&1
echo "[$(date)] Ejecutando script post-descarga para: $TR_TORRENT_NAME"

# Ruta donde se descargó el torrent
TORRENT_DIR="$TR_TORRENT_DIR"
DEST_DIR="$TR_TORRENT_DIR"

# Buscar archivos .part1.rar o .rar (inicio de archivo multipartido)
mapfile -t RAR_FILES < <(find "$TORRENT_DIR" -type f \( -iname "*.part1.rar" -o -iname "*.rar" \))

# Revisar si encontró archivos
if [[ ${#RAR_FILES[@]} -eq 0 ]]; then
    echo "No se encontraron archivos .rar en $TORRENT_DIR"
    exit 0
fi

# Extraer cada archivo .part1.rar o .rar
for RAR_FILE in "${RAR_FILES[@]}"; do
    echo "Extrayendo: $RAR_FILE"
    7z x -y "$RAR_FILE" -o"$DEST_DIR"
done

echo "Extracción completada."

# Borrar torrent (solo si todo salió bien)
transmission-remote -n 'transmission:transmission' --torrent "$TR_TORRENT_ID" --remove-and-delete
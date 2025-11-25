#!/usr/bin/env bash

# =========================================================
# Usage:
# ./gcpbucketcollector.sh <prefix> <output_file>
# Example:
# ./gcpbucketcollector.sh try try_output.txt
# =========================================================

# Validar argumentos
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <prefix> <output_file>"
    echo "Example: $0 try all_output.txt"
    exit 1
fi

PREFIX="$1"
OUTFILE="$2"
BUCKET="gs://PUT_BUCKET_NAME_HERE/${PREFIX}/**"

echo "Starting collection for prefix: $PREFIX"
echo "Output file: $OUTFILE"

# Limpiar/crear archivo de salida
: > "$OUTFILE"

# Procesar cada objeto
gsutil ls "$BUCKET" | grep -v '/$' | while IFS= read -r key; do
    echo "===== Processing: $key ====="
    echo "===== Processing: $key =====" >> "$OUTFILE"

    # Metadata
    echo "-- Metadata --"
    echo "-- Metadata --" >> "$OUTFILE"
    if ! gsutil ls -L "$key" 2>&1 | tee -a "$OUTFILE"; then
        echo "[ERROR fetching metadata for $key]"
        echo "[ERROR fetching metadata for $key]" >> "$OUTFILE"
    fi

    # Contenido
    echo "-- Content --"
    echo "-- Content --" >> "$OUTFILE"
    if ! gsutil cat "$key" 2>&1 | tee -a "$OUTFILE"; then
        echo "[ERROR reading content of $key]"
        echo "[ERROR reading content of $key]" >> "$OUTFILE"
    fi

    echo "===== Finished: $key ====="
    echo "===== Finished: $key =====" >> "$OUTFILE"
    echo
done

echo "All done. Output saved to $OUTFILE"

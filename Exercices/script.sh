#!/bin/bash

fichier_urls="$1"

# Validation de l'argument
if [ -z "$fichier_urls" ]; then
    echo "Erreur : veuillez fournir un fichier d'URL."
    exit 1
fi

ligne_num=1

while read -r line; do
    # Code HTTP
    http_code=$(curl -o /dev/null -s -w "%{http_code}" "$line")

    # Encodage
    encoding=$(curl -s -I "$line" | grep -i "charset" | cut -d'=' -f2)

    # Nombre de mots
    word_count=$(curl -s "$line" | wc -w)

    # Affichage des résultats
    echo -e "${ligne_num}\t${line}\t${http_code}\t${encoding}\t${word_count}"
    ligne_num=$((ligne_num + 1))
done < "$fichier_urls"


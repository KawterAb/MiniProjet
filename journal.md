On évite d'utiliser cat ici, car il lit tout le fichier en une seule fois avant de le transmettre à while. Cette méthode peut être moins performante pour les fichiers volumineux, puisqu'elle charge tout le contenu dans un sous-processus avant de l'envoyer à while. En utilisant directement < fichier, les lignes du fichier sont transmises une par une à while, ce qui est plus efficace en termes de mémoire et de temps d'exécution pour les grands fichiers.
Pour utiliser "urls/fr.txt" comme paramètre, on peut employer $1, qui représente le premier argument passé au script lors de son exécution.
#pour valider l'argument on doit d'abord assigner un argument au script 
fichier_urls=$1 
# après on vérifie si le paramètre est fourni 
if [ -z "$fichier_urls" ]; then
    echo "Erreur : veuillez fournir un fichier d'URL."
    exit 1
fi
# Pour afficher le numéro de ligne, on utilise une variable ligne_num qui est initialisée à 1 et incrémentée à chaque itération. On utilise echo -e pour activer les tabulations (\t) et séparer le numéro de ligne et l'URL par une tabulation 

echo -e "${ligne_num}\t${line}"

# Exercice 2 :
# le scripte finale de notre travail est : 

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




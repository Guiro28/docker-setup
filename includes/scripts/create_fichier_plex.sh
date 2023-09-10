#!/bin/bash

# Fonction pour afficher une question en jaune
function ask_question() {
  echo -e "\033[33m$1\033[0m"
}

# Chemin par défaut pour le fichier .env
env_file_path="/home/$USER"
env_file="$env_file_path/.env"

# Fonction pour charger toutes les variables depuis le fichier .env
function load_env_variables() {
  local env_file="$1"
  if [ -f "$env_file" ]; then
    source "$env_file"
  else
    echo "Le fichier .env n'a pas été trouvé à $env_file. Assurez-vous qu'il existe avant de continuer."
    exit 1
  fi
}

# Charger toutes les variables depuis le fichier .env
load_env_variables "$env_file"

# À partir de ce point, toutes les variables du fichier .env sont disponibles, y compris $FOLDER_APP_SETTINGS

# Chemin vers les dossiers
create_fichier_shows="$FOLDER_RCLONE/realdebrid/shows"
create_fichier_movies="$FOLDER_RCLONE/realdebrid/movies"
create_fichier_default="$FOLDER_RCLONE/realdebrid/default"

# Définir les noms des fichiers
nom_fichier_shows="ZeroZeroZero - imdb-tt8332438 - S01E08 - Same Blood WEBDL-1080p.mkv"
nom_fichier_movies_default="Slumberland (2022) imdb-tt13320662 WEBDL-1080p.mkv"

# Créer les fichiers dans les dossiers spécifiés
for dossier in "$create_fichier_shows" "$create_fichier_movies" "$create_fichier_default"; do
  if [ "$dossier" == "$create_fichier_shows" ]; then
    nom_fichier="$nom_fichier_shows"
  else
    nom_fichier="$nom_fichier_movies_default"
  fi

  chemin_fichier="$dossier/$nom_fichier"

  # Créez le fichier vide
  touch "$chemin_fichier"
done

# Redémarrer le conteneur Docker Plex
docker restart plex

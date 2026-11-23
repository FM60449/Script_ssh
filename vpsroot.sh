#!/bin/bash
# Configuration de l’accès root - franckfmk
set -e

if [ "${EUID}" -ne 0 ]; then
    echo "Ce script doit être exécuté en root."
    exit 1
fi

wget -qO /etc/ssh/sshd_config "https://raw.githubusercontent.com/FM60449/Script_ssh/main/sshd_config"
systemctl restart sshd 2>/dev/null || systemctl restart ssh

read -r -s -p "Entrez le nouveau mot de passe root : " pwe
echo
if [ -z "$pwe" ]; then
    echo "Le mot de passe ne peut pas être vide."
    exit 1
fi

echo "root:${pwe}" | chpasswd

cat <<INFO
============================================
Compte root configuré
IP        : $(curl -Ls http://ipinfo.io/ip)
Utilisateur: root
Mot de passe: (celui que vous venez de définir)
============================================
INFO

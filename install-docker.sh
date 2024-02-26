#!/bin/bash

echo "                                      Instalação do docker e docker-compose $(uname -s)-$(uname -m)"
sleep 10
clear

echo "                                      Atualizando repositorio"
sudo apt update && apt upgrade -y
sleep 1
clear

echo "                                      Instalando dependencias"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sleep 1
clear

echo "                                      Adiciocionando chave GPG do repositorio oficial"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 1
clear

echo "                                      Adicionando repositorio do docker ao APT"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 1
clear

echo "                                      Atualizando repositorio"
sudo apt update
sleep 1
clear

echo "Instalando o docker"
sudo apt install -y docker-ce
sleep 1
clear

echo "                                      Instalando o docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
clear
sleep 1

docker ps

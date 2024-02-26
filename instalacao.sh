#!/bin/bash

# Função para verificar se um comando está instalado
check_command() {
    command -v $1 >/dev/null 2>&1
}

clear

# Verifica se o GIT está instalado, e instala se necessário
if ! check_command git; then
    echo "Instalando o GIT..."
    apt update
    apt install -y git
    clear
fi

# Verifica se o curl está instalado, e instala se necessário
if ! check_command curl; then
    echo "Instalando o curl..."
    apt install -y curl
    clear
fi

echo "Clonando repositório..."
git clone https://github.com/limatecnologia/docker.git
clear

echo "Acessando a pasta..."
cd docker/

echo "Dando permissão ao arquivo..."
chmod +x install_docker.sh
clear

echo "Iniciando instalação..."
clear
sleep 1
chmod +x limazap

./install_docker.sh

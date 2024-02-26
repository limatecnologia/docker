#!/bin/bash

# Função para verificar se um comando está instalado
check_command() {
    command -v $1 >/dev/null 2>&1
}

echo "Instalação do docker e docker-compose $(uname -s)-$(uname -m)"
sleep 10
clear

echo "Atualizando repositório"
sudo apt update
sleep 1
clear

echo "Instalando dependências"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sleep 1
clear

echo "Adicionando chave GPG do repositório oficial"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 1
clear

echo "Adicionando repositório do docker ao APT"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 1
clear

echo "Atualizando repositório"
sudo apt update
sleep 1
clear

# Verifica se o Docker está instalado, e instala se necessário
if ! check_command docker; then
    echo "Instalando o Docker"
    sudo apt install -y docker-ce
    sleep 1
    clear
fi

# Verifica se o docker-compose está instalado, e instala se necessário
if ! check_command docker-compose; then
    echo "Instalando o Docker Compose"
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    clear
    sleep 1
fi

docker ps

clear

docker-compose up -d

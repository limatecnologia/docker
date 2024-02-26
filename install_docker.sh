#!/bin/bash

# Função para verificar se um comando está instalado
check_command() {
    command -v $1 >/dev/null 2>&1
    return $?
}

# Função para lidar com erros
handle_error() {
    local exit_code=$?
    local phone_number=$1
    local message=$2
    echo "Erro encontrado na linha $3 com código de saída $exit_code."
    ./limazap "$phone_number" "Erro" "$message"
    exit $exit_code
}

# Função para enviar mensagem de sucesso
send_success_message() {
    local phone_number=$1
    local message=$2
    ./limazap "$phone_number" "Sucesso" "$message"
}

# Pergunta se deseja receber alertas no WhatsApp
read -p "Gostaria de receber alertas da instalação no WhatsApp? (s/n): " receive_alerts

if [ "$receive_alerts" == "s" ] || [ "$receive_alerts" == "S" ]; then
    # Pergunta e armazena o número de telefone
    read -p "Digite o seu número de telefone (DDD+numero sem o digito 9 do início): " phone_number
fi

echo "Instalação do docker e docker-compose $(uname -s)-$(uname -m)"
sleep 10
clear

echo "Atualizando repositório"
sudo apt update || handle_error "$phone_number" "Erro ao atualizar o repositório" $LINENO
sleep 1
clear

echo "Instalando dependências"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || handle_error "$phone_number" "Erro ao instalar dependências" $LINENO
sleep 1
clear

echo "Adicionando chave GPG do repositório oficial"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || handle_error "$phone_number" "Erro ao adicionar chave GPG" $LINENO
sleep 1
clear

# Restante do script...

# Se chegou até aqui, a instalação foi bem-sucedida
send_success_message "$phone_number" "Instalação concluída com sucesso!"

docker ps

clear

docker-compose up -d

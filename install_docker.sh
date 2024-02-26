#!/bin/bash

# Função para verificar se um comando está instalado
check_command() {
    command -v $1 >/dev/null 2>&1
    return $?
}

# Função para enviar mensagem usando limazap
send_whatsapp_message() {
    local phone_number=$1
    local message_type=$2
    local message=$3
    ./limazap "$phone_number" "$message_type\n\n" "$message"
}

# Pergunta se deseja receber alertas no WhatsApp
read -p "Gostaria de receber alertas da instalação no WhatsApp? (s/n): " receive_alerts

if [ "$receive_alerts" == "s" ] || [ "$receive_alerts" == "S" ]; then
    # Pergunta e armazena o número de telefone
    read -p "Digite o seu número de telefone (DDD+numero sem o digito 9 do início): " phone_number
fi

# Função para lidar com erros
handle_error() {
    local exit_code=$?
    local message=$1
    send_whatsapp_message "$phone_number" "Erro" "$message"
    echo "Erro:\n\n $message na linha $2 com código de saída $exit_code."
    exit $exit_code
}

# Função para enviar mensagem de sucesso
send_success_message() {
    local message=$1
    send_whatsapp_message "$phone_number" "Sucesso" "$message"
}

send_success_message "Iniciando a instalação do docker e docker-compose $(uname -s)-$(uname -m)"

echo "Instalação do docker e docker-compose $(uname -s)-$(uname -m)"
sleep 2
clear

# Verifica se o curl está instalado, e instala se necessário
#if ! check_command curl; then
#    send_whatsapp_message "$phone_number" "Erro" "Erro ao instalar o curl"
#    handle_error "Erro ao instalar o curl" $LINENO
#fi

#send_success_message "Curl instalado com sucesso. Continuando..."

echo "Atualizando repositório"
sudo apt update || handle_error "Erro ao atualizar o repositório" $LINENO
sleep 1
clear

echo "Instalando dependências"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || handle_error "Erro ao instalar dependências" $LINENO
sleep 1
clear

echo "Adicionando chave GPG do repositório oficial"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || handle_error "Erro ao adicionar chave GPG" $LINENO
sleep 1
clear

echo "Adicionando repositório do docker ao APT"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || handle_error "Erro ao adicionar repositório do Docker ao APT" $LINENO
sleep 1
clear

echo "Atualizando repositório"
sudo apt update || handle_error "Erro ao atualizar o repositório após adicionar o repositório do Docker" $LINENO
sleep 1
clear

echo "Instalando o docker"
sudo apt install -y docker-ce
sleep 1
clear


# Verifica se o Docker está instalado, e instala se necessário
if ! check_command docker; then
    send_whatsapp_message "$phone_number" "Erro" "Erro ao instalar o Docker"
    handle_error "Erro ao instalar o Docker" $LINENO
fi

send_success_message "Docker instalado com sucesso. Continuando..."



echo "                                      Instalando o docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
clear
sleep 1

# Verifica se o docker-compose está instalado, e instala se necessário
if ! check_command docker-compose; then
    send_whatsapp_message "$phone_number" "Erro" "Erro ao instalar o Docker Compose"
    handle_error "Erro ao instalar o Docker Compose" $LINENO
fi

send_success_message "Docker Compose instalado com sucesso. Continuando..."

# Chama o segundo script (substitua o caminho e nome do script real)
#echo "Executando segundo script..."
#./segundo_script.sh || handle_error "Erro ao executar o segundo script" $LINENO

# Se chegou até aqui, a instalação foi bem-sucedida
docker ps

clear

#docker-compose up -d

docker build -t apache-container .
docker run -d -p 8080:80 -p 2222:22 --name apache-container apache-container

clear

docker ps

send_success_message "Instalação concluída com sucesso!"

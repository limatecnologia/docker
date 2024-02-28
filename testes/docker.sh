#!/bin/bash

# Função para verificar se o comando está instalado
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Verificar se o Docker está instalado
if command_exists docker; then
  echo "Docker já está instalado."
else
  # Instalar o Docker
  echo "Instalando Docker..."
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "Docker instalado com sucesso."
fi

# Verificar se o Docker Compose está instalado
if command_exists docker-compose; then
  echo "Docker Compose já está instalado."
else
  # Instalar o Docker Compose
  echo "Instalando Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo "Docker Compose instalado com sucesso."
fi

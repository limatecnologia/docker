#!/bin/bash

echo "                                            Instalando o GIT"
apt install -y git
clear

echo "                                            Clonando repositorio"
git clone https://github.com/limatecnologia/docker.git
clear

echo "                                            Acessando a pasta"
cd docker/

echo "                                            Dando permissão ao arquivo"
chmod +x install_docker.sh
clear

echo "                                            Iniciando instalacao"
clear
sleep 1
./install_docker.sh

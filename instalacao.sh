#!/bin/bash

echo "                                            Instalando o GIT"
apt install -y git
clear

echo "                                            Clonando repositorio"
git clone https://github.com/limatecnologia/docker.git
clear

echo "                                            Acessando a pasta"
cd /docker
clear

echo "                                            Dando permissão ao arquivo"
chmod +x install-docker.sh
clear

echo "                                            Iniciando instalacao"
clear
sleep 10
./install-docker.sh

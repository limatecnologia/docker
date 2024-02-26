# Use a imagem oficial do Ubuntu
FROM ubuntu:22.04

# Atualize os pacotes e instale o Apache e o servidor SSH
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 openssh-server

# Crie o diretório necessário para o SSH
RUN mkdir /run/sshd

# Defina uma senha para o usuário root (substitua 'Master@05' pela sua senha desejada)
RUN echo 'root:Master@05' | chpasswd

# Copie o arquivo de configuração do SSH personalizado
COPY sshd_config /etc/ssh/sshd_config
COPY ./site/* /var/www/html/

# Exponha as portas 80 para o Apache e 22 para o SSH
EXPOSE 80 22

# Inicie os serviços do Apache e SSH
CMD service apache2 start && service ssh start && tail -f /dev/null

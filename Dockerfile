# Use a imagem oficial do Ubuntu
FROM ubuntu:22.04

# Atualize os pacotes e instale o Apache
RUN apt-get update && \
    apt-get install -y apache2

# Instale o servidor SSH
RUN apt-get install -y openssh-server

# Defina uma senha para o usuário root (substitua 'password' pela sua senha desejada)
RUN echo 'root:Master@05' | chpasswd

# Exponha as portas 80 para o Apache e 22 para o SSH
EXPOSE 80 22

# Inicie os serviços do Apache e SSH
CMD service apache2 start && /usr/sbin/sshd -D

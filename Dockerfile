# Use a imagem oficial do Apache
FROM httpd:latest

# Remove o arquivo index.html padrão do Apache
RUN rm /usr/local/apache2/htdocs/index.html

# Copie os arquivos do site para o diretório padrão do Apache
COPY ./ser+ /usr/local/apache2/htdocs/

# Exponha a porta 80 para o Apache
EXPOSE 80

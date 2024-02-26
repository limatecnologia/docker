# Use a imagem oficial do Apache
FROM httpd:latest

# Copie os arquivos do site para o diretório padrão do Apache
COPY -r ser+/* /usr/local/apache2/htdocs/

# Exponha a porta 80 para o Apache
EXPOSE 80

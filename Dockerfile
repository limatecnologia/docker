# Use a imagem oficial do Apache
FROM httpd:latest

# Copie os arquivos do site para o diretório padrão do Apache
CMD rm -rf /usr/local/apache2/htdocs/index.html
COPY ser+/* /usr/local/apache2/htdocs/

# Exponha a porta 80 para o Apache
EXPOSE 80

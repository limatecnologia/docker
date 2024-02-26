FROM httpd:latest
RUN rm /usr/local/apache2/htdocs/index.html
RUN chmod -R 755 /usr/local/apache2/htdocs/
COPY ./site /usr/local/apache2/htdocs/
EXPOSE 80

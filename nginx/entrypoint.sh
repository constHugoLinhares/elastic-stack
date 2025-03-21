#!/bin/bash

# Remove links simbólicos e cria arquivos físicos para os logs
rm -f /var/log/nginx/access.log /var/log/nginx/error.log
touch /var/log/nginx/access.log /var/log/nginx/error.log
chmod 644 /var/log/nginx/*.log

# Habilita o módulo do Filebeat para Nginx
filebeat modules enable nginx
filebeat setup
filebeat -e &

# Inicia o Filebeat
service filebeat start

# Inicia o Nginx
nginx -g 'daemon off;'

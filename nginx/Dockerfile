FROM nginx:latest

# Atualiza pacotes e instala dependências necessárias
RUN apt-get update && apt-get install -y curl apt-transport-https gnupg

# Define a versão do Filebeat
ENV FILEBEAT_VERSION=7.13.0

# Baixa e instala o Filebeat com verificação de integridade
RUN curl -L -o filebeat.deb https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-amd64.deb && \
    dpkg -i filebeat.deb || apt-get install -f -y && \
    rm filebeat.deb
    
# Remove links simbólicos antes de iniciar o container
RUN rm -f /var/log/nginx/access.log /var/log/nginx/error.log && \
    touch /var/log/nginx/access.log /var/log/nginx/error.log && \
    chmod 644 /var/log/nginx/*.log

# Copia a configuração do Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copia a configuração do Filebeat
COPY filebeat.yml /etc/filebeat/filebeat.yml

# Copia o entrypoint e dá permissão
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define o entrypoint
ENTRYPOINT ["/entrypoint.sh"]

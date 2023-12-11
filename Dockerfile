FROM nginx:1.25.2

#--------------------------------------------#
#                INSTALL UPDATES             #
#--------------------------------------------#
RUN apt-get update
#--------------------------------------------#
#    INSTALL OPENSSL & CERTBOT               #
#--------------------------------------------#
RUN	apt-get install -y \
	    openssl \
	    certbot \
	    --no-install-recommends && \
	apt-get -y autoremove && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
VOLUME /etc/dhparam
VOLUME /etc/letsencrypt

#--------------------------------------------#
#         COPY SCRIPTS                       #
#--------------------------------------------#
COPY scripts/entrypoint.sh /entrypoint.sh
#--------------------------------------------#
#    REMOVE DEFAULT NGINX CONGIF             #
#--------------------------------------------#
RUN rm /etc/nginx/conf.d/default.conf
# Use application path
WORKDIR /app

# Run
ENTRYPOINT ["/entrypoint.sh"]
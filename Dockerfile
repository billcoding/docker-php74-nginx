ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="billcoding <bill07wang@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.24 & PHP 7.4 based on Alpine Linux."
# Setup document root
WORKDIR /var/www/html

# Update pkg
RUN apk update

# Add php repository rsa pub
ADD https://php.hernandev.com/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# Add ca certificates
RUN apk --update-cache add ca-certificates

# Add php repository
RUN echo "https://php.hernandev.com/v3.11/php-7.4" >> /etc/apk/repositories

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  php7 \
  php7-ctype \
  php7-curl \
  php7-dom \
  php7-fpm \
  php7-gd \
  php7-intl \
  php7-mbstring \
  php7-pdo \
  php7-pdo_mysql \
  php7-zip \
  php7-fileinfo \
  php7-mysqli \
  php7-opcache \
  php7-openssl \
  php7-phar \
  php7-session \
  php7-xml \
  php7-xmlreader \
  php7-json \
  supervisor

# Configure nginx - http
COPY config/nginx.conf /etc/nginx/nginx.conf
# Configure nginx - default server
COPY config/conf.d /etc/nginx/conf.d/

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

# Switch to use a non-root user from here on
USER nobody

# Add application
COPY --chown=nobody src/ /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping

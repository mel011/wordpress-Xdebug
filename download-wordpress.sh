#!/bin/bash
set -e

# Download WordPress if /var/www/html is empty
if [ -z "$(ls -A /var/www/html)" ]; then
    echo "Downloading WordPress..."
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
    echo "WordPress downloaded into /var/www/html"
else
    echo "/var/www/html is not empty, skipping download"
fi

# Start Apache
exec "$@"

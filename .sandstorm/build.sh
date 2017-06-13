#!/bin/bash
# Checks if there's a composer.json, and if so, installs/runs composer.

set -euo pipefail

cd /opt/app

if [ -f /opt/app/composer.json ] ; then
    if [ ! -f composer.phar ] ; then
        curl -sS https://getcomposer.org/installer | php
    fi
    php composer.phar install --no-dev -o
fi

echo "CREATE DATABASE IF NOT EXISTS cachet; GRANT ALL on cachet.* TO 'cachet'@'localhost' IDENTIFIED BY 'cachet'; FLUSH PRIVILEGES;" | mysql -h localhost -u root
php artisan key:generate
php artisan app:install

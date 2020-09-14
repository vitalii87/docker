#!/usr/bin/env bash

find /var/www/vit -type f -exec chmod 664 {} \;
find /var/www/vit -type d -exec chmod 775 {} \;

chown -R 1000:www-data /var/www/vit

if [ ! -f /var/www/vit/storage/apache-error.log ]; then
    touch /var/www/vit/storage/apache-error.log
fi

if [ ! -f /var/www/vit/.env ]; then
    cp /var/www/vit/.env.example /var/www/vit/.env
fi

cd /var/www/vit/
#php vendor/bin/phinx migrate

bash -c "cd /var/www/vit/ && composer install --prefer-dist --no-scripts --no-autoloader"

exec /usr/sbin/apache2ctl -D FOREGROUND



#!/bin/sh

cd /code

php artisan storage:link --force
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan migrate --force
# composer install
php artisan config:cache

# ln -s /code/supervisord.conf /etc/supervisor/conf.d/keditor.conf

exec "$@"

#!bin/bash

if [ ! -f "vendor/autoload.php" ]; then
composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
  echo "Creating .env file..."
  cp .env.example .env
else
  echo ".env file exists!"
fi

#php artisan migrate
#php artisan key:generate
#php artisan optimize

php-fpm -D
ngixn -g "daemon off;"
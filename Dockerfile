FROM php:8.3-cli

WORKDIR /app

# Install system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    git unzip libzip-dev libpng-dev curl libpq-dev libicu-dev nodejs npm \
    && docker-php-ext-install pdo pdo_pgsql zip bcmath intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Create a dummy .env if it doesn't exist so artisan commands don't crash
RUN cp .env.example .env || touch .env

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Install frontend dependencies and build assets
RUN npm install --force && npm run build

# Expose port
EXPOSE 10000

# Startup logic: Generate key ONLY if missing, migrate, then serve
CMD php artisan key:generate --force && \
    sleep 5 && \
    php artisan migrate --force && \
    php -S 0.0.0.0:10000 -t public
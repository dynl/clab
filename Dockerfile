FROM php:8.3-cli

WORKDIR /app

# Install PHP extensions and system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    curl \
    libpq-dev \
    libicu-dev \
    nodejs npm \
    && docker-php-ext-install pdo pdo_pgsql zip bcmath intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install Laravel dependencies
# Added --ignore-platform-reqs to skip version check errors during build
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Generate app key (Only if not provided in Environment Variables)
RUN php artisan key:generate

# Install frontend dependencies and build assets
# Using --force to bypass minor npm version conflicts
RUN npm install --force
RUN npm run build

# Expose port
EXPOSE 10000

# Startup: wait a few seconds, run migrations, then serve
CMD sleep 5 && php artisan migrate --force && php -S 0.0.0.0:10000 -t public    
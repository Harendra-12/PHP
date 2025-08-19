# Stage 1: Use official PHP Apache image (smaller base)
FROM php:8.2-apache-cli-slim

# Set working directory
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y apache2 libapache2-mod-php \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy only necessary files (exclude node_modules, logs, etc.)
COPY . .

# Remove any dev files if not needed
RUN rm -rf tests docs README.md

# Set proper permissions (optional)
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80

# Start Apache (already the default entrypoint)

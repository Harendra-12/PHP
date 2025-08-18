# Use official PHP Apache imageee
FROM php:8.2-apache

# Copy source code to container web root
COPY . /var/www/html/

# Expose port 80
EXPOSE 80

# Start Apache (already the default entrypoint)

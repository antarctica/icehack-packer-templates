#!/usr/bin/env bash -eux

# Update nginx configuration file
sudo cp /tmp/nginx.conf /etc/nginx/nginx.conf;

# Update nginx default site configuration file
sudo cp /tmp/nginx-default.conf /etc/nginx/sites-available/default;

# Restart Nginx
sudo service nginx restart;

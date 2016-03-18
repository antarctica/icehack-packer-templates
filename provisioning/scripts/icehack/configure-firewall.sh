#!/usr/bin/env bash -eux

# Allow access to Nginx
sudo ufw allow "Nginx Full";

# Restart the firewall
sudo ufw disable;
sudo ufw --force enable;

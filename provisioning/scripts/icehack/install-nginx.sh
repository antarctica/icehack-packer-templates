#!/usr/bin/env bash -eux

# Add APT repository to install latest version of Nginx
sudo add-apt-repository -y ppa:nginx/stable;

# Update package caches
sudo apt-get update;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nginx;

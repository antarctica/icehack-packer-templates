#!/usr/bin/env bash -eux

# Add APT repository to install latest version of R
sudo add-apt-repository -y ppa:marutter/rrutter;

# Update package caches
sudo apt-get update;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install r-base;

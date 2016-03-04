#!/usr/bin/env bash -eux

# Download Miniconda installer to users home
cd /home/user;
wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O /home/user/miniconda.sh;
chmod +x /home/user/miniconda.sh;

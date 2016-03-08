#!/usr/bin/env bash -eux

# Create directory for local R packages
mkdir -p /home/user/R/library;

# Move R configuration file into place
cp /tmp/dot-Rprofile /home/user/.Rprofile

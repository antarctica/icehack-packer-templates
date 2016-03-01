#!/usr/bin/env bash -eux

# Create group and user for 'superuser' - a generic user/admin account with sudo privileges
sudo useradd -m -r -u 902 -G sudo -s /bin/bash -c "Generic privileged user for admin tasks" superuser
echo 'superuser:Ahh-a-seal!' | sudo chpasswd

# Create group and user for 'user' - a generic day to day user account without sudo privileges
sudo useradd -m -r -u 903 -s /bin/bash -c "Generic user for day to day tasks" user
echo 'user:icehack' | sudo chpasswd

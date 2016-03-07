#!/usr/bin/env bash -eux

# Move the firewall definition into place
sudo mv /tmp/jupyter.rules /etc/ufw/applications.d/jupyter

# Reload the firewall to pick up new definition
sudo ufw reload;

# Allow access to jupyter
sudo ufw allow jupyter-notebook;

# Restart the firewall
sudo ufw disable;
sudo ufw --force enable;

#!/usr/bin/env bash -eux

# Allow password based logins
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config;

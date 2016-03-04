#!/usr/bin/env bash -eux

sudo apt-get update;

# Required for IRIS
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install python-qt4;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libxext6;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libsm6;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libxrender1;
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libgeos-3.4.2

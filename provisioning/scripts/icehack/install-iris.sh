#!/usr/bin/env bash -eux

# Install IRIS and dependencies
cd /home/user;
/home/user/miniconda/bin/conda install system;
/home/user/miniconda/bin/conda install basemap;
/home/user/miniconda/bin/conda install pyproj;
/home/user/miniconda/bin/conda install jupyter;
/home/user/miniconda/bin/conda install -c scitools iris;

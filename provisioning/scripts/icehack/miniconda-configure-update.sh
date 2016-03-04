#!/usr/bin/env bash -eux

# Configure and update Miniconda
cd /home/user;
/home/user/miniconda/bin/conda config --set always_yes yes --set changeps1 no;
/home/user/miniconda/bin/conda update -q conda;
/home/user/miniconda/bin/conda install _license;
/home/user/miniconda/bin/conda info -a;

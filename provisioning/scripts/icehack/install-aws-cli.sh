#!/usr/bin/env bash -eux

# Install AWS CLI locally
pip install --user awscli;

# Create directory for AWS CLI configuration
mkdir /home/user/.aws;

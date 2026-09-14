#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y python3 python3-pip git gh
pip3 install --break-system-packages ansible
gh repo clone AfiqNasruddin/devops-bootcamp-project 
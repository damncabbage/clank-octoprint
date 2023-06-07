#!/usr/bin/env bash

set -e
set -u
set -x

# Move to script's dir
cd "$(dirname "$0")"

# Just in case
git submodule update --init

# Octoprint
python -m venv env
env/bin/pip install OctoPrint
sudo ln -rs service/octoprint.service /etc/systemd/service/
sudo systemctl daemon-reload
sudo systemctl start octoprint

# Webcam
webcam/setup.sh

#!/usr/bin/env bash

set -e
set -u
set -x

pushd ustreamer
  #sudo apt install libevent libjpeg libuuid 
  sudo apt install libevent-dev libjpeg-dev uuid-dev libbsd-dev libgpiod-dev
  make
popd

sudo ln -rs service/webcamd.service /etc/systemd/service/

sudo systemctl daemon-reload
sudo systemctl start webcamd

#!/usr/bin/env bash

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
sudo node --version
sudo npm --version

sudo npm install dcdx@next -g

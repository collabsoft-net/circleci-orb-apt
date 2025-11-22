#!/usr/bin/env bash

sudo NEEDRESTART_MODE=a apt-get update -y;
sudo NEEDRESTART_MODE=a apt-get install -y g++ build-essential;

sudo wget https://marketplace.atlassian.com/download/plugins/atlassian-plugin-sdk-tgz -O /tmp/atlassian-plugin-sdk.tar.gz; \
sudo mkdir /opt/atlassian-plugin-sdk; \
sudo tar -xvzf /tmp/atlassian-plugin-sdk.tar.gz --strip-components 1 -C /opt/atlassian-plugin-sdk;

sudo ln -s /opt/atlassian-plugin-sdk/bin/atlas-mvn /usr/bin/mvn
sudo mvn --version

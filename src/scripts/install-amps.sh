#!/usr/bin/env bash

sudo NEEDRESTART_MODE=a apt-get update -y;
sudo NEEDRESTART_MODE=a apt-get install -y g++ build-essential;

sudo wget https://marketplace.atlassian.com/download/plugins/atlassian-plugin-sdk-tgz -O /tmp/atlassian-plugin-sdk.tar.gz; \
sudo mkdir /opt/atlassian-plugin-sdk; \
sudo tar -xvzf /tmp/atlassian-plugin-sdk.tar.gz --strip-components 1 -C /opt/atlassian-plugin-sdk;

# Hack, hack, hackery hack
# The sonatype forge repository returns a 402 payment required, so we should disable it.
# The easiest way to do that is by replacing the URL
sudo grep -rl "https://repository.sonatype.org/content/repositories/forge/" /opt/atlassian-plugin-sdk | sudo xargs sed -i 's,https://repository.sonatype.org/content/repositories/forge/,https://packages.atlassian.com/artifactory/maven-atlassian-all/,g'

sudo ln -s /opt/atlassian-plugin-sdk/bin/atlas-mvn /usr/bin/mvn
sudo mvn --version

#!/usr/bin/env bash

sudo NEEDRESTART_MODE=a apt-get update && \

  # Install Java only if it's not already available
  # Java is installed for Selenium
  if ! command -v java > /dev/null; then \
      echo "Java not found in parent image, installing..." && \
      sudo NEEDRESTART_MODE=a apt-get install -y --no-install-recommends --no-upgrade openjdk-11-jre; \
  fi && \

  # Firefox deps
  sudo NEEDRESTART_MODE=a apt-get install -y --no-install-recommends --no-upgrade \
  libdbus-glib-1-2 \
  libgtk-3-dev \
  libxt6 \
&& \
  # Google Chrome deps
  # Some of these packages should be pulled into their own section
  sudo NEEDRESTART_MODE=a apt-get install -y --no-install-recommends --no-upgrade \
      fonts-liberation \
      libappindicator3-1 \
      libasound2 \
      libatk-bridge2.0-0 \
      libatspi2.0-0 \
      libcairo2 \
      libcups2 \
      libgbm1 \
      libgdk-pixbuf2.0-0 \
      libgtk-3-0 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libxcursor1 \
      libxss1 \
      xdg-utils \
      xvfb \
      jq \
&& \
sudo rm -rf /var/lib/apt/lists/*


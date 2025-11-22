#!/usr/bin/env bash
# shellcheck disable=SC2086

sudo -E dcdx apt teardown --product $PRODUCT --environment $ENVIRONMENT --cwd /opt/dcapt -y

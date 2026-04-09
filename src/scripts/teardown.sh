#!/usr/bin/env bash
# shellcheck disable=SC2086

echo "Running DC App Performance Tookit with the following arguments: 'dcdx apt teardown --product ${PRODUCT} --environment ${ENVIRONMENT} --cwd /opt/dcapt -y'"

sudo -E dcdx apt teardown --product $PRODUCT --environment $ENVIRONMENT --cwd /opt/dcapt -y

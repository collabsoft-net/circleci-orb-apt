#!/usr/bin/env bash
# shellcheck disable=SC2086

sudo rm -rf /opt/dcapt
sudo git clone https://github.com/atlassian/dc-app-performance-toolkit.git /opt/dcapt

ARGS="--product $PRODUCT --environment $ENVIRONMENT --cwd /opt/dcapt -y"

if [ -n "${VERSION}" ];
then
  ARGS="${ARGS} --tag ${VERSION}"
fi

if [ -n "${LICENSE}" ];
then
  ARGS="${ARGS} --license ${LICENSE}"
fi

sudo -E dcdx apt provision $ARGS

if [ "$POST_PROVISION_SCRIPT" != "" ];
then
  if [ -f "$POST_PROVISION_SCRIPT" ]; 
  then
    BASEURL=$(jq --raw-output .product_urls.value.${PRODUCT} /opt/dcapt/app/util/k8s/outputs.json)
    echo Starting post-provisioning script:
    echo "$POST_PROVISION_SCRIPT $BASEURL $POST_PROVISION_SCRIPT_ARGS"
    sh $POST_PROVISION_SCRIPT $BASEURL $POST_PROVISION_SCRIPT_ARGS
  fi
fi

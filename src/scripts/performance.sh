#!/usr/bin/env bash
# shellcheck disable=SC2086

ARGS="--product $PRODUCT --environment $ENVIRONMENT --outputDir /tmp/results --ts performance --force"

if [ "${RUN}" == "run2" ];
then
  if [ -n "${APPKEY}" ];
  then
    ARGS="--appKey ${APPKEY} ${ARGS}"
  fi

  if [ -n "${ARCHIVE}" ];
  then
    ARGS="--archive ${ARCHIVE} ${ARGS}"
  fi
fi

if [ -n "${LICENSE}" ];
then
  ARGS="${ARGS} --license ${LICENSE}"
fi

if [ "${RESTART_AFTER_INSTALL}" == "true" ];
then
  ARGS="${ARGS} --restartAfterInstall"
fi

sudo -E dcdx apt $RUN $ARGS
sudo mv /tmp/results/performance/$RUN /tmp/results/
sudo rm -rf /tmp/results/performance
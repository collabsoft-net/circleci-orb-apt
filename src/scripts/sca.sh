#!/usr/bin/env bash
# shellcheck disable=SC2086
# shellcheck disable=SC2153

ARGS="--outputDir /tmp/results/"

if [ -n "${APPKEY}" ];
then
  ARGS="--appKey ${APPKEY} ${ARGS}"
fi

if [ -n "${ARCHIVE}" ];
then
  ARGS="--archive ${ARCHIVE} ${ARGS}"
fi

if [ "${FAILONERROR}" == "1" ];
then
  ARGS="--failOnError ${ARGS}"
fi

if [ -n "${APIKEY}" ];
then
  sudo dcdx apt sca --nvdApiKey $APIKEY $ARGS
elif [ -n "${NVD_API_KEY}" ];
then
  sudo dcdx apt sca --nvdApiKey $NVD_API_KEY $ARGS
else
  echo "Either the 'apiKey' parameter or 'NVD_API_KEY' environment variable are required"
  exit 1
fi
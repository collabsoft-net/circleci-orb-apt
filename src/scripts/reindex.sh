#!/usr/bin/env bash
# shellcheck disable=SC2086

npx -y puppeteer browsers install chrome@130.0.6723.116

ARGS="--environment $ENVIRONMENT --outputDir /tmp/results --ts lucene --force"

if [ -n "${VERSION}" ];
then
  ARGS="${ARGS} --tag ${VERSION}"
fi

if [ -n "${APPKEY}" ];
then
  ARGS="--appKey ${APPKEY} ${ARGS}"
fi

if [ -n "${ARCHIVE}" ];
then
  ARGS="--archive ${ARCHIVE} ${ARGS}"
fi

if [ -n "${LICENSE}" ];
then
  ARGS="${ARGS} --license ${LICENSE}"
fi

if [ "${RESTART_AFTER_INSTALL}" == "true" ];
then
  ARGS="${ARGS} --restartAfterInstall"
fi

dcdx apt reindex $ARGS
mv /tmp/results/lucene/reindex/lucene-reindex.png /tmp/results/lucene-reindex.png

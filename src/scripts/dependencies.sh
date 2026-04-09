#!/usr/bin/env bash
# shellcheck disable=SC2086

ARGS="--groupId ${GROUPID} --artifactId ${ARTIFACTID} --outputFile /tmp/results/maven_dependency_tree.gv"

if [ -n "${APPKEY}" ];
then
  ARGS="--appKey ${APPKEY} ${ARGS}"
fi

if [ -n "${ARCHIVE}" ];
then
  ARGS="--archive ${ARCHIVE} ${ARGS}"
fi

if [ -n "${MAVEN_PROFILES}" ];
then
  ARGS="-P ${MAVEN_PROFILES} ${ARGS}"
fi

echo "Running DC App Performance Tookit with the following arguments: 'dcdx apt dependencies ${ARGS}'"
sudo dcdx apt dependencies $ARGS
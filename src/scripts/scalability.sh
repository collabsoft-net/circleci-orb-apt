#!/usr/bin/env bash
# shellcheck disable=SC2086

sudo rm -rf /opt/dcapt
sudo git clone https://github.com/atlassian/dc-app-performance-toolkit.git /opt/dcapt

if [ -f "$EXTENSION_FILE" ];
then
  sudo cp $EXTENSION_FILE /opt/dcapt/app/extension/${PRODUCT}/extension_ui.py
  sudo sed -i -e 's/# def test_1_selenium_custom_action/def test_1_selenium_custom_action/g' /opt/dcapt/app/selenium_ui/${PRODUCT}_ui.py
  sudo sed -i -e 's/#     extension_ui.app_specific_action/    extension_ui.app_specific_action/g' /opt/dcapt/app/selenium_ui/${PRODUCT}_ui.py
fi

if [ -f "$LOCUST_FILE" ];
then
  sudo cp $LOCUST_FILE /opt/dcapt/app/extension/${PRODUCT}/extension_locust.py
  EXTRA_ARGS="--locust"
fi

if [ -f "$JMX_FILE" ];
then
  sudo cp $JMX_FILE /opt/dcapt/app/jmeter/${PRODUCT}.jmx
fi

ARGS="--product $PRODUCT --environment $ENVIRONMENT --outputDir /tmp/results --ts scalability --cwd /opt/dcapt --force ${EXTRA_ARGS}"

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

sudo -E dcdx apt $RUN $ARGS
sudo mv /tmp/results/scalability/$RUN /tmp/results/
sudo rm -rf /tmp/results/scalability
#!/usr/bin/env bash
# shellcheck disable=SC2086

echo Test results in attached workspace
sudo ls -lahR /tmp/results/

echo Generating performance report
sudo -E dcdx apt report --type performance --resultsDir1 /tmp/results/run1 --resultsDir2 /tmp/results/run2 --outputDir /tmp/results/ --ts performance -y

echo Moving performance results to the workspace
sudo mv /tmp/results/performance/performance_profile /tmp/results/
sudo rm -rf /tmp/results/performance

echo Generating scalability report
if [ "$PRODUCT" == "bamboo" ];
then
  sudo -E dcdx apt report --type scalability --product ${PRODUCT} --resultsDir1 /tmp/results/run1 --resultsDir2 /tmp/results/run2 --resultsDir3 /tmp/results/run3 --outputDir /tmp/results/ --ts scalability -y
else 
  sudo -E dcdx apt report --type scalability --product ${PRODUCT} --resultsDir1 /tmp/results/run3 --resultsDir2 /tmp/results/run4 --resultsDir3 /tmp/results/run5 --outputDir /tmp/results/ --ts scalability -y
fi

echo Moving scalability results to the workspace
sudo mv /tmp/results/scalability/scale_profile /tmp/results/
sudo rm -rf /tmp/results/scalability

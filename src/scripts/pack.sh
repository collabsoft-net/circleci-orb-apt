#!/usr/bin/env bash

if [ "${PRODUCT}" != "bamboo" ];
then

  if [ "${INCLUDE_PERFORMANCE_TESTS}" == "1" ];
  then
    if [ ! -f /tmp/results/run1/results_summary.log ];
    then
      echo "✘ Performance baseline test result (Run 1) not found"
      FAILED="true"
    else
      echo "✔ Performance baseline test result (Run 1) is available"
    fi

    if [ ! -f /tmp/results/run2/results_summary.log ];
    then
      echo "✘ Performance regression test result (Run 2) not found"
      FAILED="true"
    else
      echo "✔ Performance regression test result (Run 2) is available"
    fi
  else
    echo "- Performance baseline tests are not included"  
  fi

  if [ "${INCLUDE_SCALABILITY_TESTS}" == "1" ];
  then
    if [ ! -f /tmp/results/run3/results_summary.log ];
    then
      echo "✘ Scalability test result (Run 3) not found"
      FAILED="true"
    else
      echo "✔ Scalability test result (Run 3) is available"
    fi

    if [ ! -f /tmp/results/run4/results_summary.log ];
    then
      echo "✘ Scalability test result with two-node DC cluster (Run 4) not found"
      FAILED="true"
    else
      echo "✔ Scalability test result with two-node DC cluster (Run 4) is available"
    fi

    if [ ! -f /tmp/results/run5/results_summary.log ];
    then
      echo "✘ Scalability test result with four-node DC cluster (Run 5) not found"
      FAILED="true"
    else
      echo "✔ Scalability test result with two-node DC cluster (Run 5) is available"
    fi
  else
    echo "- Scalability tests are not included"  
  fi

else

  if [ "${INCLUDE_PERFORMANCE_TESTS}" == "1" ];
  then
    if [ ! -f /tmp/results/run1/results_summary.log ];
    then
      echo "✘ Performance baseline test result (Run 1) not found"
      FAILED="true"
    else
      echo "✔ Performance baseline test result (Run 1) is available"
    fi

    if [ ! -f /tmp/results/run2/results_summary.log ];
    then
      echo "✘ Performance regression test result (Run 2) not found"
      FAILED="true"
    else
      echo "✔ Performance regression test result (Run 2) is available"
    fi
  else
    echo "- Performance baseline tests are not included"  
  fi

  if [ "${INCLUDE_SCALABILITY_TESTS}" == "1" ];
  then
    if [ ! -f /tmp/results/run3/results_summary.log ];
    then
      echo "✘ Scalability test result (Run 3) not found"
      FAILED="true"
    else
      echo "✔ Scalability test result (Run 3) is available"
    fi
  else
    echo "- Scalability tests are not included"  
  fi

fi

if [ "${INCLUDE_PERFORMANCE_TESTS}" == "1" ];
  if [ ! -f /tmp/results/performance_profile/performance_profile.csv ];
  then
    echo "✘ Performance profile report not found"
    FAILED="true"
  else
    echo "✔ Performance profile report is available"
  fi
fi

if [ "${INCLUDE_SCALABILITY_TESTS}" == "1" ];
then
  if [ ! -f /tmp/results/scale_profile/scale_profile.csv ];
  then
    echo "✘ Scalability profile report not found"
    FAILED="true"
  else
    echo "✔ Scalability profile report is available"
  fi
fi

if [ "${PRODUCT}" == "jira" ];
then
  if [ "${INCLUDE_REINDEX}" == "1" ];
  then
    if [ ! -f /tmp/results/lucene-reindex.png ];
    then
      echo "✘ Lucene Timing Test screenshot not found"
      FAILED="true"
    else
      echo "✔ Lucene Timing Test screenshot is available"
    fi
  else
    echo "- Lucene Timing Test is not included"  
  fi
else
    echo "- Lucene Timing Test not required"
fi

if [ "${INCLUDE_DEPENDENCIES}" == "1" ];
then
  if [ ! -f /tmp/results/maven_dependency_tree.gv ];
  then
    echo "✘ Apache Maven dependency graph not found"
    FAILED="true"
  else
    echo "✔ Apache Maven dependency graph is available"
  fi
else
  echo "- Apache Maven dependency graph is not included"
fi

if [ "${INCLUDE_VULNERABILITIES}" == "1" ];
then
  if [ ! -f /tmp/results/dependency-check-report.html ];
  then
    echo "✘ SCA scanner vulnerability report not found"
    FAILED="true"
  else
    echo "✔ SCA scanner vulnerability report is available"
  fi
else
  echo "- SCA scanner vulnerability report is not included"
fi

echo

if [ "$FAILED" == "true" ];
then
  echo "✘ Not all required test results are available"
  exit 1
fi

echo "✔ All required test results are available"

echo Creating archive of test results
sudo tar -czf /tmp/results.tar.gz -C /tmp/results .
sudo mv /tmp/results.tar.gz "/tmp/results/$NAME"

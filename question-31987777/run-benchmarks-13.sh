#!/bin/bash

PATH_ORIG=${PATH}

export JAVA_HOME=$(pwd)/jdk13
export PATH=${JAVA_HOME}/bin:${PATH_ORIG}

mvn compile package || exit 1

iterations=5
run_seconds=5

(
  which java
  java -jar target/benchmarks.jar -wi ${iterations} -i ${iterations} -r ${run_seconds}s -f ${iterations}
) 2>&1 | tee benchmark_jre13.log

#!/bin/bash

PATH_ORIG=${PATH}

export JAVA_HOME=$(pwd)/jdk8
export PATH=${JAVA_HOME}/bin:${PATH_ORIG}

which java
mvn compile package || exit 1

iterations=5
run_seconds=5

# run unpatched JDK8
export JAVA_HOME=$(pwd)/jdk8/jre
export PATH=${JAVA_HOME}/bin:${PATH_ORIG}
(
  which java
  java -jar target/benchmarks.jar -wi ${iterations} -i ${iterations} -r ${run_seconds}s -f ${iterations}
) 2>&1 | tee benchmark_jre8.log

# run patched JDK 8
export JAVA_HOME=$(pwd)/jre8.patched
export PATH=${JAVA_HOME}/bin:${PATH_ORIG}
(
  which java
  java -jar target/benchmarks.jar upperCaseTR -wi ${iterations} -i ${iterations} -r ${run_seconds}s -f ${iterations}
) 2>&1 | tee benchmark_patched_jre8.log

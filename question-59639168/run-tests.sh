#!/bin/bash

export JAVA_HOME=~/bin/jdk13
export M2_HOME=~/bin/apache-maven-3.6.2

export PATH=${JAVA_HOME}/bin:${M2_HOME}/bin:$PATH

mvn test
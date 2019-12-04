#!/bin/bash

if [ ! -f target/classes/java/lang/ConditionalSpecialCasing.class ]
then
  echo "project must be compiled first ..."
  exit
fi

if [ -d ./jre8.patched ]
then
  echo "patched JRE directory already exist ..."
  exit
fi

echo "copying the JRE ..."
cp -r ./jdk8/jre ./jre8.patched

jar vuf ./jre8.patched/lib/rt.jar -C ./target/classes java/lang/

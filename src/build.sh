#!/bin/bash

export NDK_MODULE_PATH=`pwd`
export NDK_PROJECT_PATH=`pwd`/java
 
ndk-build $@

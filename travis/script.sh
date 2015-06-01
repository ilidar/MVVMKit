#!/bin/sh
set -ev

xctool \
  -workspace MVVMKit.xcworkspace \
  -scheme MVVMKit \
  -sdk iphonesimulator \
  -arch i386 \
  test

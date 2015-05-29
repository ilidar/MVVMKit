#!/bin/sh
set -ev

xcodebuild \
 -workspace MVVMKit.xcworkspace \
 -scheme MVVMKitTests \
 -sdk iphonesimulator \
 -arch i386 \
 build test
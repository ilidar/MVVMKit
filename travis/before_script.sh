#!/bin/sh
set -ev

export LANG=en_US.UTF-8
gem update cocoapods
brew update
brew upgrade xctool
pod repo add Cocoapods-Private https://github.com/ilidar/Cocoapods-Private.git

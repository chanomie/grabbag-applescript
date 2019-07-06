#!/usr/local/bin/bash

for longPackageName in `brew outdated`; do
  echo ${longPackageName}
  brew upgrade ${longPackageName}
done
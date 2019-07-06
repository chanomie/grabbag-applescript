#!/bin/bash

check_version() {
  package_name="$1"

  version=$(npm show ${package_name} version)
  echo ${package_name}@${version}
}

# Version Compare Script From: 
# https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

OLD_IFS=${IFS}
IFS=$'\n'
for longPackageName in `npm -g list --depth=0 | grep "homebridge"`; do
  packageNameVersion=$(echo ${longPackageName} | cut -c 5-)
  installedPackageName=$(echo ${packageNameVersion} | cut -d"@" -f1)
  installedPackageVersion=$(echo ${packageNameVersion} | cut -d"@" -f2)
  
  #echo "${installedPackageName} and ${installedPackageVersion}"
  result=$(check_version ${installedPackageName})
  currentPackageVersion=$(echo ${result} | cut -d"@" -f2)
  
  versionMessage=$(echo "$installedPackageName installed ${installedPackageVersion} available ${currentPackageVersion}")
  vercomp ${installedPackageVersion} ${currentPackageVersion}
    case $? in
        0) echo "Same Version - ${versionMessage}";;
        2) echo "Newer Verion - ${versionMessage}";;
        1) echo "Installed version is newer?  That's wierd - ${versionMessage}";;
    esac

  
done
IFS=${OLD_IFS}

## Give a reminder of how to do the install
echo ""
echo sudo npm install -g homebridge --unsafe-perm


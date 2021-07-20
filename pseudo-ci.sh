#!env bash

set -xeu

target=$1

dirname=hbh_$$
repo=hpoul/hbh
wd=wd/wd_${dirname}

basedir=`pwd`

if ! test -e ${wd} ; then
    git clone git@github.com:${repo}.git ${wd}
fi

pushd ${wd}

git fetch --all
git reset --hard
git clean -qxfd .
git checkout origin/master

${basedir}/blackbox.go.macos cipostdeploy ${basedir}/SECRET_KEY.txt

FLT=${basedir}/flutter/bin/flutter ./hbh_app/_tools/release.sh ${target}


rm -rf "${wd}"


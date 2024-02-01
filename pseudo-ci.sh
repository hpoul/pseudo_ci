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
if test -z "${ref:-}" ; then
    git reset --hard
else
    git reset --hard "${ref:-}"
fi
git clean -qxfd .
#git checkout origin/master

${basedir}/blackbox.go.macos cipostdeploy ${basedir}/SECRET_KEY.txt

export JAVA_HOME=/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home

FLT=${basedir}/flutter/bin/flutter ./hbh_app/_tools/release.sh ${target}

popd

rm -rf "${wd}"


#!/usr/bin/env bash
set -eu

file=$1
parser=$2
draft=$3
if [[ $@ == 4 ]] ; then
  version=$4
else
  if [[ $parser == 'awk' ]] ; then
    version=$(cat $file | awk '/^version:/ { print $2 }')
  else
    version=$(cat $file)
  fi
fi

flags="--generate-notes"
if [[ $draft == 'true' ]] ; then
  flags="$flags --draft"
fi
git config --global --add safe.directory /github/workspace
git config user.email $(git --no-pager log --format=format:'%ae' -n 1)
git config user.name $(git --no-pager log --format=format:'%an' -n 1)
git tag -a -m "Automatic release of v$version" $version
git push origin $version
gh release create $version $flags

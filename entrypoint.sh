#!/usr/bin/env bash
set -eu

if [[ -e Chart.yaml ]] ; then
  version=$(cat Chart.yaml | awk '/^version:/ { print $2 }')
elif [[ -e VERSION ]] ; then
  version=$(cat VERSION)
else
  echo "No version file found"
  exit 1
fi
git config --global --add safe.directory /github/workspace
git config user.email $(git --no-pager log --format=format:'%ae' -n 1)
git config user.name $(git --no-pager log --format=format:'%an' -n 1)
git tag -a $version -m "Automatic release of v$version"
git push origin $version
gh release create $version --generate-notes --draft

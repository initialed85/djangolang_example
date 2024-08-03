#!/bin/bash

set -e

# this block ensures we can invoke this script from anywhere and have it automatically change to this folder first
pushd "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
function teardown() {
    popd >/dev/null 2>&1 || true
}
trap teardown exit

# we need npm for the frontend
if ! command -v npm >/dev/null 2>&1; then
    echo "error: can't find npm command- you likely need to install node / npm"
    exit 1
fi

# run the frontend
cd frontend
npm ci
npm run start

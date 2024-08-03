#!/bin/bash

set -e

# this block ensures we can invoke this script from anywhere and have it automatically change to this folder first
pushd "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
function teardown() {
    popd >/dev/null 2>&1 || true
}
trap teardown exit

# ensure we've got a djangolang executable available (required for templating)
if ! command -v djangolang >/dev/null 2>&1; then
    go install github.com/initialed85/djangolang@latest
fi

# ensure the docker compose environment is already running
if ! docker compose ps | grep djangolang | grep postgres | grep healthy >/dev/null 2>&1; then
    echo "error: can't find healthy docker compose environment; ensure to invoke ./run-env.sh in another shell"
    exit 1
fi

# the environment variables are coupled to the environment described in docker-compose.yaml
POSTGRES_DB=some_db POSTGRES_PASSWORD=some-password djangolang template

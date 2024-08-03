#!/bin/bash

set -e

# this block ensures we can invoke this script from anywhere and have it automatically change to this folder first
pushd "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
function teardown() {
    popd >/dev/null 2>&1 || true
}
trap teardown exit

# ensure we've got a djangolang_example executable available (an indication that the build has happened)
if ! command -v ./pkg/djangolang_example/bin/djangolang_example >/dev/null 2>&1; then
    echo "error: can't find ./pkg/djangolang_example/bin/djangolang_example; ensure to invoke ./build.sh"
    exit 1
fi

# ensure the docker compose environment is already running
if ! docker compose ps | grep djangolang | grep postgres | grep healthy >/dev/null 2>&1; then
    echo "error: can't find healthy docker compose environment; ensure to invoke ./run-env.sh in another shell"
    exit 1
fi

# the environment variables are coupled to the environment described in docker-compose.yaml
PORT=7070 REDIS_URL=redis://default:some-password@localhost:6379 POSTGRES_DB=some_db POSTGRES_PASSWORD=some-password ./pkg/djangolang_example/bin/djangolang_example serve

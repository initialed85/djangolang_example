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

# we need npm to generate the client for use by the frontend
if ! command -v npm >/dev/null 2>&1; then
    echo "error: can't find npm command- you likely need to install node / npm"
    exit 1
fi

# ensure the docker compose environment is already running
if ! docker compose ps | grep djangolang | grep postgres | grep healthy >/dev/null 2>&1; then
    echo "error: can't find healthy docker compose environment; ensure to invoke ./run-env.sh in another shell"
    exit 1
fi

# introspect the database and generate the Djangolang API
# note: the environment variables are coupled to the environment described in docker-compose.yaml
POSTGRES_DB=some_db POSTGRES_PASSWORD=some-password djangolang template

# dump out the OpenAPI v3 schema for the Djangolang API
./pkg/djangolang_example/bin/djangolang_example dump-openapi-json >frontend/openapi.json

# generate the client for use by the frontend
cd frontend
npm ci
npm run openapi-typescript

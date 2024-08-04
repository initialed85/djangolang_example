# djangolang_example

# status: under development

This repo contains an example usage of [djangolang](https://github.com/initialed85/djangolang) in a toy project.

## Approach

The ideal Djangolang API deployment looks a bit as follows:

- Prerequisites
  - A Postgres database with logical replication enabled
  - A schema that makes use of `deleted_at: timestamptz` columns for soft-deletion
    - It's optimal (but not mandatory) that your schema has some trigger function magic to convert `DELETE` to `UPDATE` (setting `deleted_at` to `now()`)
  - A Redis instance / cluster
- A running generated Djangolang API server
  - The generation process does the following
    - Introspect the Postgres database schema
    - Generate some of the following Go code
      - Some query helpers for the introspected tables
      - A Djangolang API server including:
        - Endpoints for CRUD interactions with the introspected tables (including Redis caching)
        - Logical replication CDC streamer (used to invalidate the Redis cache)
        - OpenAPI v3 schema generation (to enable automated client generation)
- (potentially)
  - TypeScript frontend using a client generated using the OpenAPI v3 schema
  - Go service using a client generated using the OpenAPI v3 schema
  - (rinse and repeat for other languages as required)

## In this repo

Note: For the below to be entirely true, you need to successfully run `./build.sh` first

- `database` <-- Migrations for a toy schema that works well with Djangolang
- `frontend` <-- A toy React + React Query frontend to demonstrate usage of the generated TypeScript client
- `pkg`
  - `djangolang_example`
    - `bin`
      - `djangolang_example` <-- Server binary for the generated Djangolang API
    - `cmd`
      - `main.go` <-- Code for server binary for the generated Djangolang API
    - `*.go` <-- The Go code for the generated Djangolang API
    - `djangolang_example_client`
      - `client.go` <-- The Go code for the client to the generated Djangolang API
- `schema` <-- OpenAPI v3 schema JSON for the generated Djangolang API
- `service` <-- A toy Go service to demonstrate usage of the generated Go client
- `build.sh` <-- Bash tooling to demonstrate the build process of the Djangolang API
- `docker-compose.yaml` <-- Docker Compose environment to enable the build process of the Djangolang API
- `run-env.sh` <-- Bash tooling to spin up the Docker Compose environment
- `run-frontend.sh` <-- Bash tooling to spin up the toy React + React Query frontend
- `run-server.sh` <-- Bash tooling to spin up the generated Djangolang API
- `run-service.sh` <-- Bash tooling to spin up the toy Go service

## Usage

```shell
# shell 1 - run the dependencies
./run-env.sh

# shell 2 - generate the Djangolang API
./build.sh

# shell 2 - run the Djangolang API
./run-server.sh

# shell 3 - run the toy React + React Query frontend
./run-frontend.sh

# shell 4 - run the toy Go service
./run-frontend.sh
```

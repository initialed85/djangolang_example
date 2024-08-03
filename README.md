# djangolang_example

# status: under development

This repo contains an example usage of [djangolang](https://github.com/initialed85/djangolang) in a toy project.

## Goals

I'm planning for this repo to show the following:

- An example database schema that works well with Djangolang
- A local development environment
  - Dependencies handled by Docker Compose
    - Postgres (with logical replication enabled)
    - A migrate and post-migrate step
    - Redis
  - Bash tooling to generate a Djangolang API from the database and generate a TypeScript client
  - Bash tooling to run the generated Djangolang API
  - Bash tooling to run a contrived frontend that uses the TypeScript client

## Usage

```shell
# shell 1 - run the dependencies
./run-env.sh

# shell 2 - generate the Djangolang API
./build.sh

# shell 2 - run the Djangolang API
./run-server.sh

# shell 3 - run the frontend
./run-frontend.sh
```

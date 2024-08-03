import createClient from "openapi-fetch";
import { createHooks } from "swr-openapi";

import type { paths } from "./djangolang/api";

const client = createClient<paths>({
  baseUrl: "http://localhost:3000",
  mode: "no-cors",
});

export const { use: useDjangolang, useInfinite: useDjangolangInfinite } = createHooks(client, "djangolang-api");

import {
  default as createClientForSwr,
  default as createFetchClient,
} from "openapi-fetch";
import createClientForReactQuery from "openapi-react-query";
import { createHooks } from "swr-openapi";

import type { paths } from "./djangolang/api";

const clientForSwr = createClientForSwr<paths>({
  baseUrl: "http://localhost:3000",
  mode: "no-cors",
});

export const { use: useDjangolang, useInfinite: useDjangolangInfinite } =
  createHooks(clientForSwr, "djangolang-api");

const clientForReactQuery = createFetchClient<paths>({
  baseUrl: "http://localhost:3000",
});

export const {
  useQuery, // only intended as an escape hatch- aim to use useDjangolang
  useMutation,
  useSuspenseQuery, // only intended as an escape hatch- aim to use useDjangolang
} = createClientForReactQuery(clientForReactQuery);

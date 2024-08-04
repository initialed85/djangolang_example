import { default as createFetchClient } from "openapi-fetch";
import createClientForReactQuery from "openapi-react-query";

import type { paths } from "./djangolang/api";

const clientForReactQuery = createFetchClient<paths>({
  baseUrl: "http://localhost:3000",
});

export const {
  useQuery, // only intended as an escape hatch- aim to use useDjangolang
  useMutation,
  useSuspenseQuery, // only intended as an escape hatch- aim to use useDjangolang
} = createClientForReactQuery(clientForReactQuery);

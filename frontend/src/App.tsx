import { useState } from "react";
import "./App.css";

import { useMutation, useQuery } from "./api";

function App() {
  const [lastError, setLastError] = useState("");

  const { mutateAsync } = useMutation("post", "/logical-things");

  const { data, error, isLoading, refetch } = useQuery(
    "get",
    "/logical-things",
    {},
    { refetchInterval: 1_000 },
  );

  if (isLoading) return "Loading...";

  if (error) return `An error occured: ${error}`;

  const doMutate = async () => {
    try {
      await mutateAsync({ body: [{ name: `the name`, type: "the type" }] });
    } catch (e) {
      setLastError(JSON.stringify(e, null, 2));
    }

    await refetch();
  };

  return (
    <div>
      <div>
        <pre>{lastError}</pre>
      </div>
      <div>
        <pre>{JSON.stringify(data, null, 2)}</pre>
      </div>
      <div>
        <input type="button" value="Mutate" onClick={doMutate} />
      </div>
    </div>
  );
}

export default App;
